Class {
	#name : 'MyPawnTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyPawnTest >> testFirstMove [

	| pawn board |
	board := MyChessBoard empty.
	pawn := MyPawn white.
	board at: 'e2' put: pawn.

	self assert: pawn isFirstMove equals: true
]

{ #category : 'tests' }
MyPawnTest >> testId [

	self assert: MyPawn new id equals: 'P'
]

{ #category : 'tests' }
MyPawnTest >> testMovePawn [

	| pawn board squares |
	board := MyChessBoard empty.
	pawn := MyPawn white.
	board at: 'e2' put: pawn.
	pawn movePawn: 'e4'.

	self assert: pawn isFirstMove equals: false
]

{ #category : 'tests' }
MyPawnTest >> testTwoFirstMove [

	| pawn board |
	board := MyChessBoard empty.
	pawn := MyPawn white.
	board at: 'e2' put: pawn.
	pawn moveTo: 'e4'.

	self assert: pawn isFirstMove equals: false
]
