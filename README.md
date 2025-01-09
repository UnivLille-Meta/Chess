# Installation and usage instructions
You can get the code in Pharo 12 by installing the following baseline code:

```
Metacello new
	repository: 'github://elisabethbercy/Chess:main';
	baseline: 'MygChess';
	onConflictUseLoaded;
	load.
```

You can open the Chess Game with the following expression:
```
	board := MyChessGame freshGame.
	board size: 800@600.
	space := BlSpace new.
	space root addChild: board.
	space pulse.
	space resizable: true.
	space show.
```
---

# Our Katas
We chose the following Katas: Fix pawn moves! Restrcit legal moves! Refactoring of pieces rendering

# Kata 1: Correction of Pawn Movement

# Objective  
Practice debugging and testing.



## Implementation Summary  
This kata focused on implementing the rules for pawn movements, including:  
- Moving one square straight ahead.  
- Moving two squares on the first move.  
- Capturing diagonally.  

An incremental approach and the **State Design Pattern** were used to structure the movement logic.



## Key Steps  

### 1. Writing Tests  
- Verifying standard and initial movements.  
- Testing diagonal captures.  
- Validating illegal cases.  

### 2. Managing States with the State Pattern  
- **InitialForwardState:** Handles the two-square move on the first turn.  
- **NormalForwardState:** Manages single-square movements.  
- **DiagonalCaptureState:** Handles diagonal captures.  

Each state calculates possible moves, simplifying the logic within the `Pawn` class.



## Tests and Coverage  
- Unit tests for each movement rule.  
- Manual checks using a simplified graphical interface.



## Design Decisions  

### 1. Prioritization of Essential Features  
Basic movement rules were implemented first, before adding advanced rules like *En passant*.  

### 2. Reducing Complexity  
Dividing logic into state subclasses resulted in clearer, more modular code.  

### 3. Focus on Testability  
Thorough testing ensured the reliability of all implemented features.


---




# Kata 2
Refactor piece rendering
Goal: Practice refactorings, double dispatch and table dispatch
The game renders pieces with methods that look like these:
MyChessSquare >> renderKnight: aPiece

```
	^ aPiece isWhite
		  ifFalse: [ color isBlack
				  ifFalse: [ 'M' ]
				  ifTrue: [ 'm' ] ]
		  ifTrue: [
			  color isBlack
				  ifFalse: [ 'N' ]
				  ifTrue: [ 'n' ] ]
```

As any project done in stress during a short period of time (a couple of evenings when the son is sick), the original developer (Guille P) was not 100% following coding standards and quality recommendations. We would like you to clean up this rendering logic and remove as much conditionals as possible, for the sake of it. You can do it.
Questions and ideas that can help you in the process:
- Can you do an implementation with double dispatch?
- Can you do an implementation with table dispatch?
- What are the good and bad parts of them in this scenario? Do you understand why?


# Refactoring Report: Piece Rendering in Pharo

## Objective

The goal of this kata is to simplify the piece rendering logic by removing unnecessary conditionals. The previous implementation relied heavily on complex checks, making the code harder to read and maintain. We applied **double dispatch**, **inheritance**, and **polymorphism** to achieve cleaner, more maintainable code while preserving functionality.



## Key Steps in the Refactoring Process

1. **Identifying the Problem**:  
   The original piece rendering logic contained conditionals that checked both the piece type and the square color, making the code difficult to maintain.

2. **Applying Double Dispatch**:  
   We eliminated conditionals by splitting the rendering logic into specific methods for each combination of piece and square color, using **double dispatch** to delegate the rendering behavior to the appropriate method based on both piece type and square color.

3. **Creating Specific Methods**:  
   Each piece class (e.g., `BlackBishop`, `WhiteBishop`) now has methods to render on black and white squares:
   ```pharo
   BlackBishop >> renderPieceOnBlackSquare [ ^ 'v' ]
   BlackBishop >> renderPieceOnWhiteSquare [ ^ 'V' ]
   ```

4. **Utilizing Inheritance**:  
   The `BlackBishop` and `WhiteBishop` classes inherit common behavior, reducing duplication and promoting code reuse, while still allowing for future extension.

5. **Using Polymorphism**:  
   Each class implements its own rendering behavior, making the code **flexible** and **extensible**. New pieces can be added without modifying the existing logic.

6. **Eliminating Conditionals**:  
   We removed complex conditionals, simplifying the code and improving readability.

7. **Ensuring Easy Extensibility**:  
   This structure allows the other pieces to be added easily by implementing their own rendering methods without touching other parts of the code.



## Rendered Symbols

Here’s how each bishop is displayed based on the square color:

| Bishop Type     | Square Color | Rendered Symbol |  
|-----------------|--------------|-----------------|  
| Black Bishop    | Black        | v               |  
| Black Bishop    | White        | V               |  
| White Bishop    | Black        | b               |  
| White Bishop    | White        | B               |  



## Why This is Better

- **No Conditionals**: The rendering logic is now handled by specific methods for each piece and square color combination, eliminating the need for conditional checks.
- **Simpler Logic**: The code is cleaner and more maintainable, with each piece class directly handling its rendering.
- **Easy to Extend**: New pieces can be added without altering existing code.

This refactor uses **double dispatch**, **inheritance**, and **polymorphism** to:
- **Double Dispatch**: Dispatch behavior based on both piece type and square color.
- **Inheritance**: Shared behavior is inherited, reducing duplication.
- **Polymorphism**: Each class can implement its specific rendering logic, allowing for easy extension.

This refactor improves the code by :
- ** Simplifying the piece rendering logic.
- ** Semoving complex conditionals, and making the codebase more maintainable and extensible.
- ** By leveraging double dispatch, inheritance, and polymorphism, the solution is flexible and scalable, allowing for easy adaptation to future changes.



---



# Kata 3 Restrict Legal Move


## Introduction

This kata aims the main focuses is protecting the King while being in check/danger.
The initial implementation of the King protection logic that we started with contained a very large method that was responsible 
for handling all aspects that we could though  of checking the King’s safety. 

This led to warnings in Pharo due to the method’s size and complexity.
As a result, we refactored the code into smaller, more focused methods to comply with Pharo’s philosophy of simplicity and readability.

## The method (codesmell) that we came up with 


```pharo
MyPiece >> legalTargetSquares [

"king is in check , only authorize my pieces to move on fatal squares"

|inCheck pieces king initialTargets killAttackSquares defendingSquares allowedSquares projectedSquares nextDecisiveSquares allSquares|

 initialTargets := self targetSquaresLegal: true.

  
 pieces := self square board pieces select: [:s | s isNotNil ].

"first condition"
 king := (self isWhite ifFalse: [ pieces select:[:p | p isKing and: p color = Color black ]] 
							 ifTrue: [ pieces select:[:p | p isKing and: p color = Color white ] ]) at:1 .

 
inCheck  := king isInCheck.

Transcript show: (king attackingSquares) .

"Second condition"
killAttackSquares := self opponentPieces select: [ :opponent | 
    opponent attackingSquares includes: king square
] thenCollect: [ :opponent | opponent square ].

"Transcript show: killAttackSquares ."

allowedSquares := initialTargets select: [ :s | (king fatalSquares includes: s) or: [killAttackSquares includes: s]. ].

"Transcript show: allowedSquares ."


 "third condition"
nextDecisiveSquares := OrderedCollection new.

self opponentPieces do: [ :opponent | 
    | hypoSquares tempDecisiveSquares |
    
    "Opponent attackingSquares"
    hypoSquares := opponent attackingSquares.

    tempDecisiveSquares := hypoSquares select: [ :hsquare | 
        | projectedOpponentSquares |
        
        "Simuler le mouvement de l'adversaire"
        opponent nextSquare: hsquare.
        projectedOpponentSquares := opponent attackingSquares.
        opponent nextSquare: nil.

        "Vérifier si cela correspond à une position critique pour le roi"
        projectedOpponentSquares anySatisfy: [ :ps | 
				(ps isNil not) and:[ (ps samePositionAs: king square) 
             or: [ king attackingSquares anySatisfy: [ :ks | ks isNil not and: [ ks samePositionAs: ps ]  ] ] ].
        ].
    ].

    "Ajouter les carrés décisifs trouvés"
    nextDecisiveSquares addAll: tempDecisiveSquares.
].

nextDecisiveSquares := nextDecisiveSquares asSet asOrderedCollection.  

defendingSquares := initialTargets select: [ :initial | 
    "Simulate moving the piece to the square 'initial'"
    self nextSquare: initial.

    "Get the projected squares after the move"
    projectedSquares := self attackingSquares.

    "Reset the piece's position"
    self nextSquare: nil.

    "Check if the projected squares have a common element with 'nextDecisiveSquares'"
    (nextDecisiveSquares intersection: projectedSquares) isEmpty not.
].


 allSquares := (allowedSquares , defendingSquares ) asOrderedCollection . 

"^initialTargets "
 ^ inCheck ifTrue: [ allSquares ]
	ifFalse: [ initialTargets ] 


]


```

## Refactoring Overview

The original method for checking the King’s safety included multiple responsibilities, such as:

- Detecting whether the King is in check.
- Calculating the allowed target squares for a piece’s movement.
- Simulating opponent moves and determining if they pose a threat.
- Identifying defending squares for the King.

Due to the complexity, the method was hard to maintain and violated the single-responsibility principle. To address this, we broke the logic down into smaller methods that each handle a specific part of the calculation.

## Key Refactored Methods

### 1. **Attacking Squares Calculation**

The `attackingSquares` method returns all the squares a piece can attack. This is critical for protecting the King, as we need to determine which squares might be under threat.

```pharo
MyPiece >> attackingSquares [
    ^ self legalTargetSquares
]
```

### 2. **Legal Target Squares**

The `legalTargetSquares` method calculates all squares where a piece can legally move. This helps identify safe squares for the King, ensuring it doesn’t move to a square under attack.

```pharo
MyPiece >> legalTargetSquares [
    ^ self targetSquaresLegal: true
]
```

### 3. **Simulating Moves and Collecting Squares**

We use the `collectSquares` method to gather squares based on conditions such as legality and movement direction. This method helps in simulating moves for the King’s protection.

```pharo
MyPiece >> collectSquares: aBlock legal: shouldBeLegal [
    ^ self collectSquares: aBlock while: [ :aSquare | 
        aSquare notNil and: [ shouldBeLegal ==> aSquare hasPiece not ] ]
]
```

### 4. **Path Commands for Collecting Specific Squares**

The `collectSquares: while: untilBlock` method is responsible for collecting squares based on specific conditions until a blocking condition is met, such as encountering an opponent’s piece.

```pharo
MyPiece >> collectSquares: collectBlock while: untilBlock [
    | targets next |
    targets := OrderedCollection new.

    "Collect up right"
    next := square.
    [ untilBlock value: (next := collectBlock value: next) ]
    whileTrue: [ targets add: next ].

    "If we can hit the next piece, then add it too"
    (next notNil and: [ next contents color ~= color ]) ifTrue: [ targets add: next ].

    ^ targets
]
```

### 5. **Moving to a Square**

The `moveTo: aSquare` method simulates moving a piece to a target square, ensuring it’s a legal move before updating the piece’s position.

```pharo
MyPiece >> moveTo: aSquare [
    (self legalTargetSquares includes: aSquare) ifFalse: [ ^ self ].
    square emptyContents.
    square := aSquare.
    aSquare contents: self
]
```

## Why Refactor?

Pharo promotes writing simple, clean, and maintainable code. By refactoring the large method into smaller methods, we achieved the following benefits:

- **Single Responsibility:** Each method now has a focused task, improving readability and maintenance.
- **Modularity:** Methods like `collectSquares`, `attackingSquares`, and `moveTo:` can be reused across different parts of the game logic.
- **Readability:** Smaller methods are easier to understand and follow, making the codebase more approachable.



## Conclusion  
- ** Kata 1 successfully structured pawn movement rules using an incremental approach and the State design pattern. Comprehensive testing helped detect and fix bugs efficiently.
- ** Kata 2 successfully restricted legal (allied pieces and King's movement)  rules to protect the king. We refactored the big method we had in smaller more manageable methods.
- ** kata 3 successfully refactored the piece rendering code into a cleaner and maintainable code.
