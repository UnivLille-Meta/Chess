Class {
	#name : 'MyPawnTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyPawnTest >> testPawnAdvancesOneSquare [ 
	" Avancée simple d'une case vers l'avant"
	| game pawn |
	game := MyChessGame freshGame.
	pawn := game pieces detect: [ :p | p class = MyPawn and: [ p square name = 'e2' ] ].
	
	game move: pawn to: pawn square up.
	
	self assert: pawn square name equals: 'e3'.
	self deny: (game board at: 'e2') hasPiece.

]

{ #category : 'tests' }
MyPawnTest >> testEnPassantWhiteCapturesAfterBlackDoubleStep [ 

	| game whitePawn blackPawn |
	game := MyChessGame freshGame.

	whitePawn := game pieces detect: [ :p | p class = MyPawn and: [ p square name = 'e2' ] ].
	game move: whitePawn to: whitePawn square up up. "e2 -> e4"
	game move: whitePawn to: whitePawn square up.     "e4 -> e5"

	blackPawn := game pieces detect: [ :p | p class = MyPawn and: [ p square name = 'd7' ] ].
	game move: blackPawn to: blackPawn square down down.

	game move: whitePawn to: (game board at: 'd6').

	self assert: whitePawn square name equals: 'd6'.
	self deny: (game board at: 'd5') hasPiece.
]

{ #category : 'tests' }
MyPawnTest >> testEnPassantExpiresAfterOtherMove [ 

	| game whitePawn blackPawn someWhiteKnight initialWhitePos |
	game := MyChessGame freshGame.

	
	whitePawn := game pieces detect: [ :p | p class = MyPawn and: [ p square name = 'e2' ] ].
	game move: whitePawn to: whitePawn square up up.
	game move: whitePawn to: whitePawn square up.
	initialWhitePos := whitePawn square.

	blackPawn := game pieces detect: [ :p | p class = MyPawn and: [ p square name = 'd7' ] ].
	game move: blackPawn to: blackPawn square down down.

	
	someWhiteKnight := game pieces detect: [ :p | p notNil and: [ p class = MyKnight and: [ p color = Color white ] ] ].
	game move: someWhiteKnight to: (game board at: 'c3').


	game move: whitePawn to: (game board at: 'd6').
	self assert: whitePawn square equals: initialWhitePos.
	self assert: (game board at: 'd5') hasPiece.
]

{ #category : 'tests' }
MyPawnTest >> testPawnBlockedCannotMove [ 
	| game whitePawn blackPawn  initialSquare |
	game := MyChessGame freshGame.
	whitePawn := game pieces detect: [ :p | p class = MyPawn and: [ p square name = 'e2' ] ].
	blackPawn := game pieces detect: [ :p | p class = MyPawn and: [ p square name = 'e7' ] ].
	
	"Déplacer les pions pour qu'ils se bloquent"
	game move: whitePawn to: whitePawn square up up.
	game play.
	game move: blackPawn to: blackPawn square down down.
	game play.
	
	"Essayer d'avancer le pion blanc, il doit être bloqué"
	
	initialSquare := whitePawn square.
	game move: whitePawn to: whitePawn square up.
	
	self assert: whitePawn square equals: initialSquare.

]

{ #category : 'tests' }
MyPawnTest >> testPawnCanCaptureDiagonallyLeft [ 
	| game whitePawn enemyPawn targetSquare startSquare |
	game := MyChessGame freshGame.
	
	"Trouver un pion blanc sur e2"
	whitePawn := game pieces detect: [ :p | p class = MyPawn and: [ p square name = 'e2' ] ] .
	"Trouver un pion noir ennemi"
	enemyPawn := game pieces detect: [ :p | p class = MyPawn and: [ p square name = 'd7' ] ] .
	
	startSquare := whitePawn square.
	
	"Déplacer le pion blanc en e4"
	game move: whitePawn to: whitePawn square up up.
	game play.
	
	"Déplacer le pion ennemi en d5 (diagonale avant-gauche du pion blanc)"
	game move: enemyPawn to: enemyPawn square down down.
	game play.
	
	targetSquare := enemyPawn square.
	
	"Capturer le pion ennemi en diagonale"
	game move: whitePawn to: targetSquare.
	
	"Vérifications"
	self assert: whitePawn square equals: targetSquare.
	self deny: startSquare hasPiece.
	self assert: enemyPawn square equals: targetSquare.

]

{ #category : 'tests' }
MyPawnTest >> testPawnCanCaptureDiagonallyRight [ 
	" le pion blanc peut capturer en diagonale avant-droite"
	| game whitePawn enemyPawn targetSquare startSquare |
	game := MyChessGame freshGame.
	
	whitePawn := game pieces detect: [ :p | p class = MyPawn and: [ p square name = 'e2' ] ] .
	enemyPawn := game pieces detect: [ :p | p class = MyPawn and: [ p square name = 'f7' ] ] .
	
	startSquare := whitePawn square.
	
	game move: whitePawn to: whitePawn square up up.
	game play.
	game move: enemyPawn to: enemyPawn square down down.
	game play.
	
	targetSquare := enemyPawn square.
	
	game move: whitePawn to: targetSquare.
	
	self assert: whitePawn square equals: targetSquare.
	self deny: startSquare hasPiece.

]

{ #category : 'tests' }
MyPawnTest >> testPawnCanMakeInitialDoubleMove [ 
	| game pawn |
	game := MyChessGame freshGame.
	pawn := game pieces detect: [ :p | p class = MyPawn and: [ p square name = 'a2' ] ].
	
	game move: pawn to: (pawn square up up).
	
	self assert: pawn square name equals: 'a4'.
	self deny: (game board at: 'a2') hasPiece.

]

{ #category : 'tests' }
MyPawnTest >> testPawnCannotCaptureDiagonallyOnEmptySquare [ 
	| game pawn initialSquare target |
	game := MyChessGame freshGame.
	pawn := game pieces detect: [ :p | p class = MyPawn and: [ p square name = 'e2' ] ].
	
	game move: pawn to: pawn square up up.
	initialSquare := pawn square.
	target := (initialSquare up) ifNotNil: [ :sq | sq right ].
	
	game move: pawn to: target.
	self assert: pawn square equals: initialSquare.

]

{ #category : 'tests' }
MyPawnTest >> testPawnCannotDoubleMoveFromNonInitialRank [ 
	| game pawn start |
	game := MyChessGame freshGame.
	pawn := game pieces detect: [ :p | p class = MyPawn and: [ p square name = 'e2' ] ].

	game move: pawn to: pawn square up.
	start := pawn square.
	
	game move: pawn to: (start up up).
	self assert: pawn square equals: start.

]

{ #category : 'tests' }
MyPawnTest >> testPawnCannotJumpOverObstacleForDoubleMove [ 
	"le pion ne peut pas sauter par-dessus une pièce pour le double mouvement"

	| game pawn obstacle initialSquare legalMoves |
	game := MyChessGame freshGame.
	pawn := game pieces detect: [ :p | p class = MyPawn and: [ p square name = 'b2' ] ] .
	obstacle := game pieces detect: [ :p | p class = MyPawn and: [ p square name = 'b7' ] ].
	
	"Déplacer l'obstacle sur b4 pour bloquer le double mouvement (mais pas b3)"
	game move: obstacle to: obstacle square down down.
	game play.
	game move: obstacle to: obstacle square down.
	game play.
	
	"Vérifier que le pion sur b2 ne peut pas faire de double mouvement vers b4"
	legalMoves := pawn legalTargetSquares.
	self deny: (legalMoves anySatisfy: [ :sq | sq name = 'b4' ]).
	
	"Vérifier que b3 est accessible (une case devant, vide)"
	self assert: (legalMoves anySatisfy: [ :sq | sq name = 'b3' ]).
	
	"Le pion peut avancer d'une case vers b3"
	initialSquare := pawn square.
	game move: pawn to: (pawn square up).
	
	"Le pion doit être sur b3"
	self assert: pawn square name equals: 'b3'.
	self deny: initialSquare hasPiece.

]
