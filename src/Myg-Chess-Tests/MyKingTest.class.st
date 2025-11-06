Class {
	#name : 'MyKingTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyKingTest >> testIsCheckByOpponentsRook [

	| king board |
	board := MyChessBoard empty.
	board at: 'e4' put: (king := MyKing white).

	"Put an atacker rook on e column"
	board at: 'e1' put: MyRook black.

	self assert: king isInCheck
]

{ #category : 'tests' }
MyKingTest >> testIsNotCheckBySameColorRook [

	| king board |
	board := MyChessBoard empty.
	board at: 'e4' put: (king := MyKing white).

	"Put an same color rook on e column"
	board at: 'e1' put: MyRook white.

	self deny: king isInCheck
]

{ #category : 'tests' }
MyKingTest >> testKingCanMoveToSafeSquare [

	| rook safeMoves board|
	board := MyChessBoard empty.
	board at: 'h8' put: (rook := MyRook black).
]

{ #category : 'tests' }
MyKingTest >> testKingCanMoveToSafeSquareWhenInCheck [

	| king rook safeMoves board |
	board := MyChessBoard empty.
	board at: 'e1' put: (king := MyKing white).
	board at: 'h8' put: (rook := MyRook black).
	safeMoves := king targetSquaresLegalInCheck: true.
	"le roi peut bouger dans toutes les cases adjascentes"
	self assert: safeMoves size equals: 5. "d1, d2, e2, f2, f1"
	self assert: (safeMoves includes: (board at: 'd1')).
	self assert: (safeMoves includes: (board at: 'd2')).
	self assert: (safeMoves includes: (board at: 'e2')).
	self assert: (safeMoves includes: (board at: 'f2')).
	self assert: (safeMoves includes: (board at: 'f1'))
]

{ #category : 'tests' }
MyKingTest >> testThreateningPieces [

	| king board pairs |
	board := MyChessBoard empty.
	board at: 'e4' put: (king := MyKing white).

	"Put an atacker rook on e column"
	board at: 'e1' put: MyRook black.
	pairs := king threateningPieces.
	self assert: pairs size equals: 1.
	self assert: (pairs anySatisfy: [ :each | each key class = MyRook ])
]
