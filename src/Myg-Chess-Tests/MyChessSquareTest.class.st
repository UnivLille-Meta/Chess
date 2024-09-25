Class {
	#name : 'MyChessSquareTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyChessSquareTest >> testColor [
	|square color|
	square := MyChessSquare black.
	color:= Color black.
	
	self assert: square color equals: color.
]

{ #category : 'tests' }
MyChessSquareTest >> testContent [
	"the content method should set the given piece in the square object"

	| square piece |
	
	square := MyChessSquare black.
	square board: MyChessBoard empty.
	piece := MyKnight black.
	square contents: piece.
	self assert: square contents equals: piece.
]

{ #category : 'tests' }
MyChessSquareTest >> testHasPieceWithNoContent [ 
	" this test if one square has a piece as content"

	| square|
	square := MyChessSquare black.
	self assert: square hasPiece equals: false.
]
