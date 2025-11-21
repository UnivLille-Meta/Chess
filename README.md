# Myg Chess Game

This is a chess game for Pharo based on Bloc, Toplo and Myg.

## What is this repository really about

The goal of this repository is not to be a complete full blown game, but a good enough implementation to practice software engineering skills:
 - testing
 - reading existing code
 - refactorings
 - profiling
 - debugging

## Getting started

### Getting the code

This code has been tested in Pharo 12. You can get it by installing the following baseline code:

```smalltalk
Metacello new
	repository: 'github://UnivLille-Meta/Chess:main';
	baseline: 'MygChess';
	onConflictUseLoaded;
	load.
```

### Using it

You can open the chess game using the following expression:

```smalltalk
board := MyChessGame freshGame.
board size: 800@600.
space := BlSpace new.
space root addChild: board.
space pulse.
space resizable: true.
space show.
```

## Relevant Design Points

This repository contains:
 - a chess model: the board/squares, the pieces, their movements, how they threat each other
 - a UI using Bloc and Toplo: a board is rendered as bloc UI elements. Each square is a UI element that contains a selection, an optional piece. Pieces are rendered using a text element and a special chess font (https://github.com/joshwalters/open-chess-font/tree/master).
 - Textual game importers for the PGN and FEN standards (see https://ia902908.us.archive.org/26/items/pgn-standard-1994-03-12/PGN_standard_1994-03-12.txt and https://www.chessprogramming.org/Forsyth-Edwards_Notation#Samples)

## Katas

## Refactor piece rendering (KANTO RASOANAIVO et CATHY KENGLE)

**NB:** Nous avons travailler sur une même branche et sur un seul compte github. 

**Goal:** Practice refactorings, double dispatch and table dispatch

The game renders pieces with methods that look like these:

```smalltalk
MyChessSquare >> renderKnight: aPiece

	^ aPiece isWhite
		  ifFalse: [ color isBlack
				  ifFalse: [ 'M' ]
				  ifTrue: [ 'm' ] ]
		  ifTrue: [
			  color isBlack
				  ifFalse: [ 'N' ]
				  ifTrue: [ 'n' ] ]
```
As any project done in stress during a short period of time (a couple of evenings when the son is sick), the original developer (Guille P) was not 100% following coding standards and quality recommendations.
We would like you to clean up this rendering logic and remove as much conditionals as possible, for the sake of it.
You can do it.

Questions and ideas that can help you in the process:
- Can you do an implementation with double dispatch?
- Can you do an implementation with table dispatch?
- What are the good and bad parts of them in *this scenario*? Do you understand why?

**Problèmes :**

![1](https://github.com/user-attachments/assets/d01330f0-d589-4dc5-a31b-dfc91be77baf)

- Forte dépendance entre **MyChessSquare** et les types de pièces (MyKnight, MyBishop, etc.)
- Difficulté à ajouter une nouvelle pièce (il faut modifier la case)
- Multiplication des conditionnels ifTrue:/ifFalse:
- Faible extensibilité et violation du principe de responsabilité unique (SRP)

### SOLUTION PROPOSEE
#### Refactoring n°1:  Double Dispatch
L’objectif était de déplacer la logique de rendu dans la pièce elle-même, pour supprimer les tests du type de pièce dans MyChessSquare.

Nous avons introduit une méthode générique :

```smalltalk

	MyChessSquare >> renderPiece: aPiece
    ^ aPiece renderPieceOn: self

```
Chaque pièce (ex. : MyKnight) décide ensuite comment se rendre sur la case :

```smalltalk

	MyKnight >> renderPieceOn: aSquare
    	^ aSquare renderKnight: self
```

Cela introduit **le double dispatch :**
MyChessSquare délègue à la pièce, et la pièce redirige à la case.
Chaque classe garde sa responsabilité.


Mais il restait encore des conditionnels à l’intérieur de **renderKnight:**.
Nous avons donc poursuivi avec une approche plus propre.

#### Refactoring n°2: Table Dispatch
Pour éliminer totalement les conditionnels, nous avons remplacé les **ifTrue:/ifFalse:** par une table de correspondance **(Dictionary)**.

Chaque pièce fournit sa propre table de rendu :

```smalltalk

	MyKnight >> renderTable
	    ^ Dictionary newFrom: {
	        true -> (Dictionary newFrom: {
	            #black -> 'N'.
	            #white -> 'n'
	        }).
	        false -> (Dictionary newFrom: {
	            #black -> 'M'.
	            #white -> 'm'
	        })
	    }
```
Puis la méthode de rendu devient simple :

```smalltalk

	MyKnight >> symbolOnSquareColor: aColor
	    | colorKey |
	    colorKey := (aColor respondsTo: #isBlack)
	        ifTrue: [ aColor isBlack ifTrue: [ #black ] ifFalse: [ #white ] ]
	        ifFalse: [ aColor ].
	    ^ ((self renderTable at: self isWhite)
	        at: colorKey
	        ifAbsent: [ '?' ])
```

Enfin, **MyChessSquare** délègue le rendu à la pièce :

```smalltalk

	MyChessSquare >> renderPiece: aPiece
	    ^ aPiece symbolOnSquareColor: color
```

#### Avantages:

- Plus aucune conditionnelle imbriquée.
- Code ouvert à l’extension, fermé à la modification (principe Open/Closed).
- Responsabilités clairement séparées :
    * MyChessSquare gère la couleur de la case
    * MyKnight gère sa représentation
- Structure facile à tester (TDD).

#### Diagramme final simplifié
![2](https://github.com/user-attachments/assets/2c4a58d1-f02c-4da5-99ac-272222ed6e38)


Exemple de test (TDD)

```smalltalk
	testKnightRenderingOnBlackSquareWhenPieceIsBlack
	    | square piece |
	    square := MyChessSquare black.
	    piece  := MyKnight black.
	    self assert: (square renderPiece: piece) equals: 'M'.

```
**NB:** Nous avons procédé de la même manière pour toutes les autres pièces : MyBishop, MyQueen, MyKing, MyPawn, MyRook.

## Troubleshotting

- Exceptions in the Myg UI thread stop the event cycle. This makes the game "freeze": it receives events but the thread that treats them is not running. To restart the UI thread, execute the following:
```smalltalk
BlParallelUniverse all do: #startUniverse.
```
