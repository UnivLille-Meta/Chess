Class {
	#name : 'MyPawnTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyPawnTest >> testEnPassantCaptureSuccessful [ 
    | pawn opponentPawn board targetSquare |
    
    board := MyChessBoard empty.
    pawn := MyPawn white.
    opponentPawn := MyPawn black.
    
    "Placez le pion noir sur la case e7"
    board at: 'f7' put: opponentPawn.
    
    "Le pion blanc doit se trouver en e5 pour capturer en passant"
    board at: 'e5' put: pawn.

    "Déplacez le pion noir de f7 à f5"
    opponentPawn moveTo: (board at: 'f5').

    "Simulez la capture en passant"
    targetSquare := 'f6'.
    pawn moveTo: (board at: targetSquare).

    "Vérifiez que le pion noir est capturé"
    self assert: ((board at: 'f6') contents = pawn).

    self assert: ((board at: 'e5') contents isNil).
    self assert: ((board at: 'f5') contents isNil).
]

{ #category : 'tests' }
MyPawnTest >> testId [ 

	self assert: MyPawn new id equals: 'P'
]

{ #category : 'tests' }
MyPawnTest >> testInterActivePawnPromotion [

| pawn board |
	board := MyChessBoard empty.
	board at: 'd7' put: (pawn := MyPawn white).
	

	pawn moveToInterActiveVersion: (board at: 'd8').
	self assert: ((board at:'d8') contents) class equals: MyQueen .
	self assert: ((board at:'d8') contents) isWhite.
	
]

{ #category : 'tests' }
MyPawnTest >> testPawnCaptureMove [ 
    | pawn capturedPawn board |
    board := MyChessBoard empty.
    board at: 'e4' put: (pawn := MyPawn white).
    board at: 'd5' put: (capturedPawn := MyPawn black).  "Pièce adverse sur la case diagonale"
    
    "Simuler la capture"
    pawn moveTo: (board at: 'd5').  "Déplacer le pion blanc vers 'd5'"
    
    "Vérifier que 'e4' est vide après le déplacement"
    self assert: ((board at: 'e4') contents isNil).

    "Vérifier que le pion blanc est bien à 'd5' après la capture"
    self assert: ((board at: 'd5') contents = pawn).

    "Vérifier que l'ancienne pièce noire a été capturée"
    self assert: ((board at: 'd5') contents ~~ capturedPawn).
]

{ #category : 'tests' }
MyPawnTest >> testPawnInitialDoubleMove [ 
    | pawn1 pawn2 squares1 squares2 board |
    board := MyChessBoard empty. 
    board at: 'e2' put: (pawn1 := MyPawn white). 
    board at: 'e7' put: (pawn2 := MyPawn black ). 

    squares1 := pawn1 targetSquaresLegal: true. 
    squares2 := pawn2 targetSquaresLegal: true. 

    self assertCollection: squares1
        includesAll: (#(e3 e4) collect: [ :name | board at: name ]).
    self assertCollection: squares2
        includesAll: (#(e6 e5) collect: [ :name | board at: name ]).

]

{ #category : 'tests' }
MyPawnTest >> testSimplePawnMove [ 
    | pawn1 pawn2 squares1 squares2 board | 

    board := MyChessBoard empty.  

    board at: 'e4' put: (pawn1 := MyPawn white).  
    board at: 'e7' put: (pawn2 := MyPawn black). 

    squares1 := pawn1 targetSquares.  
    squares2 := pawn2 targetSquares.

    self assertCollection: squares1 
        includesAll: 
            (#( e5) collect: [ :name | 
                board at: name ]).

    self assertCollection: squares2
        includesAll: 
            (#( e6) collect: [ :name | 
                board at: name ]).
]

{ #category : 'tests' }
MyPawnTest >> testSimplePawnPromotion [

| pawn board |
	board := MyChessBoard empty.
	board at: 'd7' put: (pawn := MyPawn white).
	

	pawn moveTo: (board at: 'd8').
	self assert: (board at:'d8') contents equals: MyQueen white.
]
