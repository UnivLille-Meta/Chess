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
