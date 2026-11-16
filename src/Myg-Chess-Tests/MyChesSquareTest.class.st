Class {
	#name : 'MyChesSquareTest',
	#superclass : 'TestCase',
	#instVars : [
		'board'
	],
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'running' }
MyChesSquareTest >> setUp [
	super setUp.
	board := MyChessBoard empty

	"Put here a common initialization logic for tests"
]

{ #category : 'tests' }
MyChesSquareTest >> testEmptyBoardHasNoPieces [

	self assert: board pieces isEmpty
]

{ #category : 'tests' }
MyChesSquareTest >> testEmptySquareHasNoTargets [

	self assert: (board at: 'e4') contents targetSquares isEmpty
]

{ #category : 'tests' }
MyChesSquareTest >> testNewSquareHasNoPiece [
	| board |
	board := MyChessBoard empty.
	self deny: (board at: 'e4') contents isPiece
]
