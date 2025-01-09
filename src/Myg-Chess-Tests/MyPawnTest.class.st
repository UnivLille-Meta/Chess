Class {
	#name : 'MyPawnTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyPawnTest >> testDiagonalCapture [
    | board whitePawn blackPawn legalMoves |

    "Création d'un plateau vide"
    board := MyChessBoard empty.
    
    "Création d'un pion blanc et d'un pion noir"
    whitePawn := Pawn white.
    blackPawn := Pawn black.

    "Place un pion blanc sur la case 'd4'"
    board at: 'd4' put: whitePawn.
    
    "Place un pion noir en diagonale sur les cases 'c5' et 'e5'"
    board at: 'c5' put: blackPawn.
    board at: 'e5' put: blackPawn.

    "Récupère les mouvements légaux du pion blanc"
    legalMoves := whitePawn targetSquaresLegal: true.

    "Vérifie que le pion blanc peut capturer en diagonale"
    self assert: (legalMoves includes: (board at: 'c5')).
    self assert: (legalMoves includes: (board at: 'e5')).

]

{ #category : 'tests' }
MyPawnTest >> testInitialDoubleMove [
    | pawn board legalMoves |

    "Création d'un plateau et d'un pion blanc"
    board := MyChessBoard empty.
    pawn := Pawn white.

    "Place un pion blanc sur la case 'd2' (position initiale)"
    board at: 'd2' put: pawn.

    "Récupère les mouvements légaux du pion"
    legalMoves := pawn targetSquaresLegal: true.

    "Vérifie que le pion peut avancer de deux cases pour son premier mouvement"
    self assert: (legalMoves includes: (board at: 'd3')).
    self assert: (legalMoves includes: (board at: 'd4')).
]

{ #category : 'tests' }
MyPawnTest >> testIsAtStartingPosition [
| board whitePawn blackPawn |
    
    board := MyChessBoard empty.
    whitePawn := Pawn white.
    blackPawn := Pawn black.

    "Place un pion blanc en position initiale sur la case 'd2'"
    board at: 'd2' put: whitePawn.
    
    "Place un pion noir en position initiale sur la case 'd7'"
    board at: 'd7' put: blackPawn.
    
    "Vérifie que le pion blanc est en position initiale"
    self assert: whitePawn isAtStartingPosition.
    
    "Vérifie que le pion noir est en position initiale"
    self assert: blackPawn isAtStartingPosition.
]
