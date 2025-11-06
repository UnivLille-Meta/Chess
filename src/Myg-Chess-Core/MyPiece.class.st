Class {
	#name : 'MyPiece',
	#superclass : 'Object',
	#instVars : [
		'color',
		'square'
	],
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'constants' }
MyPiece class >> black [

	^ self new
		  color: Color black;
		  yourself
]

{ #category : 'constants' }
MyPiece class >> white [

	^ self new
		  color: Color white;
		  yourself
]

{ #category : 'as yet unclassified' }
MyPiece >> attackingSquares [

	^ self legalTargetSquares
]

{ #category : 'path commands' }
MyPiece >> board [

	^ square board
]

{ #category : 'accessing' }
MyPiece >> canBlockThreatFrom: attackerSquare to: kingSquare on: targetSquare [
    "Retourne true si la case targetSquare est sur la ligne entre attackerSquare et kingSquare,
    peu importe le sens (haut/bas/gauche/droite/diagonale)."

    | between1 between2 |

    (attackerSquare isNil or: [kingSquare isNil or: [targetSquare isNil]]) ifTrue: [ ^ false ].

    between1 := self squaresBetween: attackerSquare and: kingSquare.
    between2 := self squaresBetween: kingSquare and: attackerSquare.

    ^ (between1 , between2) anySatisfy: [:sq | sq = targetSquare]
]

{ #category : 'rendering' }
MyPiece >> collectSquares: aBlock [

	^ self collectSquares: aBlock legal: false
]

{ #category : 'rendering' }
MyPiece >> collectSquares: aBlock legal: shouldBeLegal [

	^ self collectSquares: aBlock while: [ :aSquare |
		  aSquare notNil and: [ shouldBeLegal ==> aSquare hasPiece not ] ]
]

{ #category : 'rendering' }
MyPiece >> collectSquares: collectBlock while: untilBlock [

	| targets next |
	targets := OrderedCollection new.

	"Collect up right"
	next := square.
	[ untilBlock value: (next := collectBlock value: next) ]
		whileTrue: [ targets add: next ].

	"If we can it the next piece, then add it too"
	(next notNil and: [ next contents color ~= color ]) ifTrue: [ targets add: next ].

	^ targets
]

{ #category : 'accessing' }
MyPiece >> color [

	^ color
]

{ #category : 'accessing' }
MyPiece >> color: aColor [

	color := aColor
]

{ #category : 'rendering' }
MyPiece >> downFile [

	^ self downFileLegal: false
]

{ #category : 'rendering' }
MyPiece >> downFileLegal: aBoolean [

	^ self collectSquares: [ :aSquare | aSquare down ] legal: aBoolean
]

{ #category : 'rendering' }
MyPiece >> downLeftDiagonal [

	^ self downLeftDiagonalLegal: false
]

{ #category : 'rendering' }
MyPiece >> downLeftDiagonalLegal: aBoolean [

	^ self
		  collectSquares: [ :aSquare | aSquare down ifNotNil: #left ]
		  legal: aBoolean
]

{ #category : 'rendering' }
MyPiece >> downRightDiagonal [

	^ self downRightDiagonalLegal: false
]

{ #category : 'rendering' }
MyPiece >> downRightDiagonalLegal: aBoolean [

	^ self
		  collectSquares: [ :aSquare | aSquare down ifNotNil: #right ]
		  legal: aBoolean
]

{ #category : 'accessing' }
MyPiece >> id [

	^ 'Q'
]

{ #category : 'testing' }
MyPiece >> isKing [
	
	^ false
]

{ #category : 'testing' }
MyPiece >> isPiece [
	
	^ true
]

{ #category : 'testing' }
MyPiece >> isWhite [
	
	^ color isBlack not
]

{ #category : 'rendering' }
MyPiece >> leftFile [

	^ self leftFileLegal: false
]

{ #category : 'rendering' }
MyPiece >> leftFileLegal: aBoolean [

	^ self collectSquares: [ :aSquare | aSquare left ] legal: aBoolean
]

{ #category : 'path commands' }
MyPiece >> legalTargetSquares [

	^ self targetSquaresLegal: true
]

{ #category : 'path commands' }
MyPiece >> legalTargetSquaresInCheck [

	^ self targetSquaresLegalInCheck: true
]

{ #category : 'path commands' }
MyPiece >> moveTo: aSquare [

	(self legalTargetSquares includes: aSquare) ifFalse: [ ^ self ].

	square emptyContents.
	square := aSquare.
	aSquare contents: self.

]

{ #category : 'accessing' }
MyPiece >> ownKing [

	
		^ (self board pieces reject: [ :p | p isNil ]) detect: [ :p |
			  p isKing and: [ p color = self color ] ] 
]

{ #category : 'rendering' }
MyPiece >> rightFile [

	^ self rightFileLegal: false
]

{ #category : 'rendering' }
MyPiece >> rightFileLegal: aBoolean [

	^ self collectSquares: [ :aSquare | aSquare right ] legal: aBoolean
]

{ #category : 'accessing' }
MyPiece >> square [
	^ square
]

{ #category : 'accessing' }
MyPiece >> square: aMyChessSquare [ 
	
	square := aMyChessSquare
]

{ #category : 'rendering' }
MyPiece >> squaresBetween: square1 and: square2 [
	 "Retourne les cases entre square1 et square2 (hors extrémités)"
    
    | squares board col1 col2 row1 row2 |
    squares := OrderedCollection new.

    (square1 isNil or: [square2 isNil]) ifTrue: [ ^ squares ].
    board := square1 board.
    board ifNil: [ ^ squares ].

    "Récupération des coordonnées"
    col1 := square1 column.  "caractère comme $e"
    col2 := square2 column.
    row1 := square1 file asString asInteger.  "Conversion safe"
    row2 := square2 file asString asInteger.

    "Cas vertical (même colonne)"
    (col1 = col2) ifTrue: [
        | startRow endRow |
        startRow := row1 min: row2.
        endRow := row1 max: row2.
        (startRow + 1 to: endRow - 1) do: [:r |
            | caseName targetSquare |
            caseName := col1 asString , r asString.
            targetSquare := board at: caseName ifAbsent: nil.
            targetSquare ifNotNil: [ squares add: targetSquare ].
        ].
        ^ squares
    ].

    "Cas horizontal (même rangée)"
    (row1 = row2) ifTrue: [
        | startCol endCol |
        startCol := col1 asciiValue min: col2 asciiValue.
        endCol := col1 asciiValue max: col2 asciiValue.
        (startCol + 1 to: endCol - 1) do: [:c |
            | caseName targetSquare |
            caseName := (c asCharacter asString) , row1 asString.
            targetSquare := board at: caseName ifAbsent: nil.
            targetSquare ifNotNil: [ squares add: targetSquare ].
        ].
        ^ squares
    ].

    "Cas diagonale"
    ((col1 asciiValue - col2 asciiValue) abs = (row1 - row2) abs) ifTrue: [
        | colDir rowDir steps |
        colDir := (col2 asciiValue - col1 asciiValue) sign.
        rowDir := (row2 - row1) sign.
        steps := (col2 asciiValue - col1 asciiValue) abs - 1.
        
        1 to: steps do: [:i |
            | newCol newRow caseName targetSquare |
            newCol := (col1 asciiValue + (colDir * i)) asCharacter.
            newRow := row1 + (rowDir * i).
            caseName := newCol asString , newRow asString.
            targetSquare := board at: caseName ifAbsent: nil.
            targetSquare ifNotNil: [ squares add: targetSquare ].
        ].
        ^ squares
    ].

    ^ squares
]

{ #category : 'rendering' }
MyPiece >> targetSquares [

	^ self targetSquaresLegal: false
]

{ #category : 'rendering' }
MyPiece >> targetSquaresLegal: aBoolean [

	self subclassResponsibility
]

{ #category : 'rendering' }
MyPiece >> targetSquaresLegalInCheck: aBoolean [

	self subclassResponsibility
]

{ #category : 'rendering' }
MyPiece >> upFile [

	^ self upFileLegal: false
]

{ #category : 'rendering' }
MyPiece >> upFileLegal: aBoolean [

	^ self collectSquares: [ :aSquare | aSquare up ] legal: aBoolean
]

{ #category : 'rendering' }
MyPiece >> upLeftDiagonal [

	^ self upLeftDiagonalLegal: false
]

{ #category : 'rendering' }
MyPiece >> upLeftDiagonalLegal: aBoolean [

	^ self collectSquares: [ :aSquare | aSquare up ifNotNil: #left ] legal: aBoolean
]

{ #category : 'rendering' }
MyPiece >> upRightDiagonal [

	^ self upRightDiagonalLegal: false
]

{ #category : 'rendering' }
MyPiece >> upRightDiagonalLegal: aBoolean [

	^ self
		  collectSquares: [ :aSquare | aSquare up ifNotNil: #right ]
		  legal: aBoolean
]
