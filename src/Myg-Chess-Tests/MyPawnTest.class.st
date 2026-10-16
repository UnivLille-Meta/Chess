Class {
	#name : 'MyPawnTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyPawnTest >> testBlackPawnsMoveDown [

| pawn squares board |
	board := MyChessBoard empty.
	board at: 'e5' put: (pawn:= MyPawn black ).

	squares := pawn targetSquares.
	self
	    assertCollection: squares includesAll: (#(e4) collect: [ :name |
				 board at: name ]).
]

{ #category : 'tests' }
MyPawnTest >> testBlackPawnsMoveToCase [


| pawn squares board |
	board := MyChessBoard empty.
	board at: 'e7' put: (pawn:= MyPawn black ).

	squares := pawn targetSquares.
	self
	    assertCollection: squares includesAll: (#(e6 e5) collect: [ :name |
				 board at: name ]).
			
	self assert: squares size equals: 2.


]

{ #category : 'tests' }
MyPawnTest >> testBlackPawnsMoveTwoCase [


| pawn squares board |
	board := MyChessBoard empty.
	board at: 'e7' put: (pawn:= MyPawn black ).

	squares := pawn targetSquares.
	self
	    assertCollection: squares includesAll: (#(e6 e5) collect: [ :name |
				 board at: name ]).
			
	self assert: squares size equals: 2.


]

{ #category : 'tests' }
MyPawnTest >> testCantMoveIfTheresAnOpponentForward [

| p1 p2 squares board |
	board := MyChessBoard empty.
	board at: 'e3' put: (p1:= MyPawn white ).
	board at: 'e4' put: (p2:= MyPawn black ) .

	squares := p1 targetSquares.
	self deny: (squares includes: (board at: 'e4')).
]

{ #category : 'tests' }
MyPawnTest >> testPawnCanCaptureLeft [

| pawn  pOpponant squares board |
	board := MyChessBoard empty.
	board at: 'e3' put: (pawn:= MyPawn white ).
	board at: 'f4' put: (pOpponant := MyPawn black). 
	

	squares := pawn targetSquares.
	self assert: (squares includes: (board at: 'f4')).
]

{ #category : 'tests' }
MyPawnTest >> testPawnCanMoveDiagonally [

| pawn squares board |
	board := MyChessBoard empty.
	board at: 'e4' put: (pawn:= MyPawn white ).

	squares := pawn targetSquares.
	self deny: (squares includes: (board at: 'd5'))
]

{ #category : 'tests' }
MyPawnTest >> testWhitePawnsMoveTwoCases [

| pawn squares board |
	board := MyChessBoard empty.
	board at: 'e2' put: (pawn:= MyPawn white ).

	squares := pawn targetSquares.
	self
	    assertCollection: squares includesAll: (#(e3 e4) collect: [ :name |
				 board at: name ]).
			
	self assert: squares size equals: 2.
]

{ #category : 'tests' }
MyPawnTest >> testWhitePawnsMoveUp [

| pawn squares board |
	board := MyChessBoard empty.
	board at: 'e3' put: (pawn:= MyPawn white ).

	squares := pawn targetSquares.
	self
	    assertCollection: squares includesAll: (#(e4) collect: [ :name |
				 board at: name ]).
]
