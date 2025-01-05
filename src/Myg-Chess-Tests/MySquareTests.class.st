Class {
	#name : 'MySquareTests',
	#superclass : 'TestCase',
	#classVars : [
		'MyChessPiece'
	],
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MySquareTests >> testBoard [ 

	| board square |
	board := MyChessBoard empty.
	square := MyChessSquare new.
	square board: board.

	self assert: square board isNotNil .
]

{ #category : 'tests' }
MySquareTests >> testCaseIsEmpty [

    | chessSquare |
	 chessSquare := MyChessSquare new.
    self assert: chessSquare hasPiece equals: false.
    
    


]

{ #category : 'tests' }
MySquareTests >> testChessSquareCreation [
   | chessSquare |
   chessSquare := MyChessSquare new.   
 	self assert: chessSquare notNil.

]

{ #category : 'tests' }
MySquareTests >> testColorSetter [

    | square |
    square := MyChessSquare new.
	 square color: Color black.

    self assert: square color equals: Color black.
    
    
    
]

{ #category : 'tests' }
MySquareTests >> testContentsSetter [

	|square piece board|
	board := MyChessBoard empty.
	square := MyChessSquare new.
	square color: Color black.
	square name: 'e4'.
	square := board at: 'e4'.
	piece := MyPawn white .
	square contents: piece .

	self assert: square contents equals: piece.
]

{ #category : 'tests' }
MySquareTests >> testEmptyContents [ 

	|square piece board|
	board := MyChessBoard empty.
	square := MyChessSquare new.
	square := board at: 'e4'.
	piece := MyPawn white .
	square contents: piece .
	square emptyContents .

	self assert: square contents equals: nil.
]

{ #category : 'tests' }
MySquareTests >> testEmptyContentsWithoutNilChecks [

	|square piece board|
	board := MyChessBoard empty.
	square := MyChessSquare new.
	square := board at: 'e4'.
	piece := MyPawn white .
	square contents: piece .
	square emptyContents .

	self assert: (square contents isKindOf: NullPiece).
]

{ #category : 'tests' }
MySquareTests >> testHasPiece [ 

	|square piece board|
	board := MyChessBoard empty.
	square := MyChessSquare new.
	square := board at: 'e4'.
	piece := MyPawn white .
	square contents: piece .
	square hasPiece .

	self deny: square contents equals: nil.
]

{ #category : 'tests' }
MySquareTests >> testHasPieceWithoutNilChecks [

	|square piece board|
	board := MyChessBoard empty.
	square := MyChessSquare new.
	square := board at: 'e4'.
	piece := MyPawn white .
	square contents: piece .
	square hasPiece .

	self assert: square hasPiece equals: piece.
]

{ #category : 'tests' }
MySquareTests >> testInitializeBackgroudColorIsBlack [

    | square |
    square := MyChessSquare new.
    
    "Test that the background is white"
    self assert: square background equals: Color black.
    
  
]

{ #category : 'tests' }
MySquareTests >> testInitializeBackgroudColorIsWhite [

    | square |
    square := MyChessSquare new.
    
    "Test that the background is white"
    self assert: square background equals: Color white.
    
  
]

{ #category : 'tests' }
MySquareTests >> testInitializeLayout [

    | square |
    square := MyChessSquare new.
    
    
    "Test that the layout is BlFrameLayout"
    self assert: square layout class equals: BlFrameLayout.
    
    
]

{ #category : 'tests' }
MySquareTests >> testNameSetter [

    | square |
    square := MyChessSquare new.
	 square color: Color black.
    square name: 'e4'.

    self assert: square name equals: 'e4'.
    
    
    
]
