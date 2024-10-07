Class {
	#name : 'MypawnTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : ' tests' }
MypawnTest >> testCaptureDiagonly [
	| pawn board squares |
	board := MyChessBoard empty.  "Créer un échiquier vide"
	board at: 'e2' put: (pawn := MyPawn white).  "Placer un pion blanc à e2"
	board at: 'f3' put: MyPawn black. 
	board at: 'd3' put: MyPawn black. 
	squares := pawn captureMoves.
	self
		assertCollection: squares
		includesAll:
			(#( f3 d3 ) collect: [ :name |
				 board at: name ])
	
]

{ #category : 'tests' }
MypawnTest >> testEnPassantMove [
	| board whitePawn blackPawn enPassantSquare legalMoves squares game|
	
	"Créer un échiquier vide"
	board := MyChessBoard empty.

	"Placer un pion blanc à e5"
	board at: 'e5' put: (whitePawn := MyPawn white).

	"Placer un pion noir à d7 et le déplacer de deux cases à d5"
	board at: 'd7' put: (blackPawn := MyPawn initialize black).
	blackPawn moveTo: (board at: 'd5'). 
	squares := whitePawn targetSquares.
	self
		assertCollection: squares
		includesAll:
			(#( d6) collect: [ :name |
				 board at: name ])
]

{ #category : ' tests' }
MypawnTest >> testMoves [
	| pawn board squares |
	
	board := MyChessBoard empty.  "Créer un échiquier vide"
	board at: 'e4' put: (pawn := MyPawn white).  "Placer un pion blanc à e4"
	board at: 'e5' put: MyPawn black.    "Placer un pion blanc à e4"
	squares := pawn targetSquares.
	self deny: (squares includes: (board at: 'e5')).
]

{ #category : ' tests' }
MypawnTest >> testfirsMoves [
	| pawn board squares |
	board := MyChessBoard empty.  "Créer un échiquier vide"
	board at: 'e2' put: (pawn := MyPawn white).  "Placer un pion blanc à e2"
	squares := pawn targetSquares.
	self
		assertCollection: squares
		includesAll:
			(#( e3 e4 ) collect: [ :name |
				 board at: name ])
	
]
