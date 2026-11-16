Class {
	#name : 'MyPawnTest',
	#superclass : 'TestCase',
	#instVars : [
		'board'
	],
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'as yet unclassified' }
MyPawnTest >> attackedNamesOf: aPawn [

	^ self namesOf: aPawn attackingSquares
]

{ #category : 'as yet unclassified' }
MyPawnTest >> legalTargetNamesOf: aPawn [

	^ self namesOf: aPawn legalTargetSquares
]

{ #category : 'as yet unclassified' }
MyPawnTest >> namesOf: squares [

	^ (squares collect: [ :each | each name ]) asSortedCollection asArray
]

{ #category : 'running' }
MyPawnTest >> setUp [

	super setUp.
	board := MyChessBoard empty
]

{ #category : 'tests' }
MyPawnTest >> testBlackPawnCanCaptureWhitePieceDiagonally [
    | pawn |
    board := MyChessBoard empty.
    board at: 'e5' put: (pawn := MyPawn black).
    board at: 'd4' put: MyRook white.

    self assert: (pawn legalTargetSquares includes: (board at: 'd4'))
]

{ #category : 'tests' }
MyPawnTest >> testBlackPawnCannotDoubleStepWhenNotOnStartingRank [

	| pawn |
	board at: 'e6' put: (pawn := MyPawn black).
	self assert: (self legalTargetNamesOf: pawn) equals: #( 'e5' )
]

{ #category : 'tests' }
MyPawnTest >> testBlackPawnCannotMoveBackwards [
    | pawn |
    board := MyChessBoard empty.
    board at: 'e5' put: (pawn := MyPawn black).

    self deny: (pawn legalTargetSquares includes: (board at: 'e6'))

]

{ #category : 'tests' }
MyPawnTest >> testBlackPawnCannotMoveBeyondBoard [
    | pawn |
    board := MyChessBoard empty.
    board at: 'e1' put: (pawn := MyPawn black).

    self assert: pawn legalTargetSquares isEmpty

]

{ #category : 'tests' }
MyPawnTest >> testBlackPawnCannotMoveForwardWhenBlocked [
    | pawn |
    board := MyChessBoard empty.
    board at: 'e5' put: (pawn := MyPawn black).
    board at: 'e4' put: MyRook white.

    self deny: (pawn legalTargetSquares includes: (board at: 'e4'))
]

{ #category : 'tests' }
MyPawnTest >> testBlackPawnMovesForward [
    | pawn |
    board := MyChessBoard empty.
    board at: 'e5' put: (pawn := MyPawn black).

    self assert: (pawn legalTargetSquares includes: (board at: 'e4'))

]

{ #category : 'tests' }
MyPawnTest >> testBlackPawnOnStartingRankCanMoveOneOrTwoSquares [

	| pawn |
	board at: 'e7' put: (pawn := MyPawn black).
	self assert: (self legalTargetNamesOf: pawn) equals: #( 'e5' 'e6' )
]

{ #category : 'tests' }
MyPawnTest >> testEveryPawnOfTheInitialPositionCanMoveOneOrTwoSquares [

	'abcdefgh' do: [ :column |
		| pawn |
		board at: column asString , '2' put: (pawn := MyPawn white).
		self
			assert: (self legalTargetNamesOf: pawn)
			equals: { (column asString , '3'). (column asString , '4') } ]
]

{ #category : 'tests' }
MyPawnTest >> testPawnCannotDoubleStepWhenFirstSquareIsBlocked [

	| pawn |
	board at: 'e2' put: (pawn := MyPawn white).
	board at: 'e3' put: MyRook black.
	self assert: (self legalTargetNamesOf: pawn) equals: #()
]

{ #category : 'tests' }
MyPawnTest >> testPawnCannotDoubleStepWhenSecondSquareIsBlocked [

	| pawn |
	board at: 'e2' put: (pawn := MyPawn white).
	board at: 'e4' put: MyRook black.
	self assert: (self legalTargetNamesOf: pawn) equals: #( 'e3' )
]

{ #category : 'tests' }
MyPawnTest >> testPawnDoesNotMoveToAnIllegalSquare [

	| pawn |
	board at: 'e2' put: (pawn := MyPawn white).
	pawn moveTo: (board at: 'e5').
	self assert: pawn square equals: (board at: 'e2')
]

{ #category : 'tests' }
MyPawnTest >> testPawnMovesForwardOneSquare [
    | pawn |
    board := MyChessBoard empty.
    board at: 'e4' put: (pawn := MyPawn white).

    self assert: (pawn legalTargetSquares includes: (board at: 'e5'))

]

{ #category : 'tests' }
MyPawnTest >> testPawnMovesTwoSquares [

	| pawn |
	board at: 'e2' put: (pawn := MyPawn white).
	pawn moveTo: (board at: 'e4').
	self deny: (board at: 'e2') hasPiece.
	self assert: (board at: 'e4') contents equals: pawn.
	self assert: pawn square equals: (board at: 'e4')
]

{ #category : 'tests' }
MyPawnTest >> testWhitePawnCanCaptureBlackPieceDiagonally [
    | pawn |
    board := MyChessBoard empty.
    board at: 'e4' put: (pawn := MyPawn white).
    board at: 'd5' put: MyRook black.

    self assert: (pawn legalTargetSquares includes: (board at: 'd5'))

]

{ #category : 'tests' }
MyPawnTest >> testWhitePawnCannotCaptureOwnPieceDiagonally [
    | pawn |
    board := MyChessBoard empty.
    board at: 'e4' put: (pawn := MyPawn white).
    board at: 'd5' put: MyRook white.

    self deny: (pawn legalTargetSquares includes: (board at: 'd5'))

]

{ #category : 'tests' }
MyPawnTest >> testWhitePawnCannotDoubleStepFromTheBlackStartingRank [

	| pawn |
	board at: 'e7' put: (pawn := MyPawn white).
	self assert: (self legalTargetNamesOf: pawn) equals: #( 'e8' )
]

{ #category : 'tests' }
MyPawnTest >> testWhitePawnCannotDoubleStepWhenNotOnStartingRank [

	| pawn |
	board at: 'e3' put: (pawn := MyPawn white).
	self assert: (self legalTargetNamesOf: pawn) equals: #( 'e4' )
]

{ #category : 'tests' }
MyPawnTest >> testWhitePawnCannotMoveBackwards [
    | pawn |
    board := MyChessBoard empty.
    board at: 'e4' put: (pawn := MyPawn white).

    self deny: (pawn legalTargetSquares includes: (board at: 'e3'))

]

{ #category : 'tests' }
MyPawnTest >> testWhitePawnCannotMoveBeyondBoard [
    | pawn |
    board := MyChessBoard empty.
    board at: 'e8' put: (pawn := MyPawn white).

    self assert: pawn legalTargetSquares isEmpty

]

{ #category : 'tests' }
MyPawnTest >> testWhitePawnCannotMoveForwardWhenBlocked [
    | pawn |
    board := MyChessBoard empty.
    board at: 'e4' put: (pawn := MyPawn white).
    board at: 'e5' put: MyRook white.

    self deny: (pawn legalTargetSquares includes: (board at: 'e5'))

]

{ #category : 'tests' }
MyPawnTest >> testWhitePawnMovesForward [
    | pawn |
    board := MyChessBoard empty.
    board at: 'e4' put: (pawn := MyPawn white).

    self assert: (pawn legalTargetSquares includes: (board at: 'e5'))

]

{ #category : 'tests' }
MyPawnTest >> testWhitePawnOnStartingRankCanMoveOneOrTwoSquares [

	| pawn |
	board at: 'e2' put: (pawn := MyPawn white).
	self assert: (self legalTargetNamesOf: pawn) equals: #( 'e3' 'e4' )
]
