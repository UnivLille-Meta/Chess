Class {
	#name : 'MyKingTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyKingTest >> testId [

	self assert: MyKing new id equals: 'K'
]

{ #category : 'tests' }
MyKingTest >> testIsCheckByOpponentsBishop [

	| king board |
	board := MyChessBoard empty.
	board at: 'e4' put: (king := MyKing white).

	"Put an atacker bishop diagonally"
	board at: 'd5' put: MyBishop black.

	self assert: king isInCheck
]

{ #category : 'tests' }
MyKingTest >> testIsCheckByOpponentsKnight [

	| king board |
	board := MyChessBoard empty.
	board at: 'e4' put: (king := MyKing white).

	"Put an atacker knight in a attacking position"
	board at: 'd6' put: MyKnight black.

	self assert: king isInCheck
]

{ #category : 'tests' }
MyKingTest >> testIsCheckByOpponentsPawn [

	| king board |
	board := MyChessBoard empty.
	board at: 'e4' put: (king := MyKing white).

	"Put an atacker pawn diagonally"
	board at: 'd5' put: MyPawn black.

	self assert: king isInCheck
]

{ #category : 'tests' }
MyKingTest >> testIsCheckByOpponentsQueen [

	| king board |
	board := MyChessBoard empty.
	board at: 'e4' put: (king := MyKing white).

	"Put an atacker queen diagonally"
	board at: 'd5' put: MyQueen black.

	self assert: king isInCheck
]

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
MyKingTest >> testIsCheckMated [

	| king board |
	board := MyChessBoard empty.
	board at: 'a1' put: (king := MyKing white).

	"Put an atacker rook on e column"
	board at: 'e1' put: MyRook black.
	board at: 'e2' put: MyRook black.

	self assert: king isCheckMated 
]

{ #category : 'tests' }
MyKingTest >> testIsKing [

	| king board |
	board := MyChessBoard empty.
	board at: 'e4' put: (king := MyKing white).

	self assert: king isKing
]

{ #category : 'tests' }
MyKingTest >> testIsNotCheckBySameColorKnight [

	| king board |
	board := MyChessBoard empty.
	board at: 'e4' put: (king := MyKing white).

	"Put an same color knight on attacking position"
	board at: 'd6' put: MyKnight white.

	self deny: king isInCheck
]

{ #category : 'tests' }
MyKingTest >> testIsNotCheckBySameColorPawn [

	| king board |
	board := MyChessBoard empty.
	board at: 'e4' put: (king := MyKing white).

	"Put an same color pawn on diagonal"
	board at: 'd5' put: MyPawn white.

	self deny: king isInCheck
]

{ #category : 'tests' }
MyKingTest >> testIsNotCheckBySameColorQueen [

	| king board |
	board := MyChessBoard empty.
	board at: 'e4' put: (king := MyKing white).

	"Put an same color queen on e column"
	board at: 'e1' put: MyQueen white.

	self deny: king isInCheck
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
MyKingTest >> testNonCheckMoves [

	| king squares board |
	board := MyChessBoard empty.
	board at: 'e4' put: (king := MyKing white).

	"Put rival rooks around the king, making it only able on the 4 squares"
	board at: 'a5' put: MyRook black.
	board at: 'h3' put: MyRook black.
	
	squares := king targetSquares.
	self
		assertCollection: squares
		includesAll:
			(#( d4 f4 ) collect: [ :name |
				 board at: name ])
]
