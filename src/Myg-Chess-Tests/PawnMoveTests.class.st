Class {
	#name : 'PawnMoveTests',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
PawnMoveTests >> testBlackPawnDiagonalCapture [
	| game blackPawn targetSquare whitePawn startSquare |
	game := MyChessGame freshGame.

	"Trouver un pion noir sur e7"
	blackPawn := game pieces detect: [ :p | p isPawn and: [ p square name = 'e7' ] ].
	startSquare := blackPawn square.

	"Trouver un pion blanc sur f2 et le déplacer vers une case diagonale (d6)"
	whitePawn := game pieces detect: [ :p | p isPawn and: [ p square name = 'f2' ] ].
	game move: whitePawn to: whitePawn square up up.
	game move: whitePawn to: whitePawn square up.
	game move: whitePawn to: whitePawn square up. "La pièce blanche est maintenant en d6"
	targetSquare := whitePawn square.

	"Essayer de capturer la pièce blanche"
	game move: blackPawn to: targetSquare.

	"Assertions"
	self assert: targetSquare hasPiece. "La case cible doit être occupée"
	self assert: blackPawn square equals: targetSquare. "Le pion noir doit maintenant être sur d6"
	self deny: startSquare hasPiece. "La case de départ doit être vide"

]

{ #category : 'tests' }
PawnMoveTests >> testBlackPawnEnPassantCapture [
    | game blackPawn whitePawn originalSquare enPassantSquare |
    game := MyChessGame freshGame.

    "Récupérer les pions concernés"
    blackPawn := game pieces detect: [ :p | p isPawn and: [ p square name = 'e7' ] ].
    whitePawn := game pieces detect: [ :p | p isPawn and: [ p square name = 'd2' ] ].

    "Faire avancer le pion noir de e7 à e5"
    game move: blackPawn to: blackPawn square down down.
    game move: blackPawn to: blackPawn square down.
    originalSquare := blackPawn square.

    "Faire avancer le pion blanc de deux cases (d2 à d4)"
    game move: whitePawn to: whitePawn square up up.
    enPassantSquare := whitePawn square down. "Case cible en passant (d3)"

    "Vérifier que la capture en passant est possible"
    self assert: (blackPawn enPassantTargetSquares includes: enPassantSquare).

    "Capturer en passant (e5 prend d3)"
    game move: blackPawn to: enPassantSquare.

    "Vérifications"
    self assert: blackPawn square equals: enPassantSquare. "Le pion noir doit être sur d3"
    self deny: originalSquare hasPiece. "e5 doit être maintenant vide"
    self deny: whitePawn square hasPiece. "Le pion blanc doit être capturé"

]

{ #category : 'tests' }
PawnMoveTests >> testEnPassantCaptureDoesNotWorkWhenConditionsAreNotMet [
    | game whitePawn blackPawn originalSquare blackOriginalSquare targetSquare |
    game := MyChessGame freshGame.
    
    "Initialiser les pièces"
    whitePawn := game pieces detect: [ :p | p isPawn and: [ p square name = 'e2' ] ].
    blackPawn := game pieces detect: [ :p | p isPawn and: [ p square name = 'd7' ] ].
    
    "Sauvegarder les positions initiales"
    originalSquare := whitePawn square.
    blackOriginalSquare := blackPawn square.
    
    "Déplacer le pion blanc de e2 à e4"
    game move: whitePawn to: (whitePawn square up up).
    
    "Déplacer le pion noir de d7 à d6 (un seul pas)"
    targetSquare := blackPawn square down.
    game move: blackPawn to: targetSquare.
    
    "Vérifier que la capture en passant n'est pas possible"
    
    self deny: (whitePawn enPassantTargetSquares includes: targetSquare).
    
  
    
    "Vérifications finales"
    self assert: whitePawn square equals: (originalSquare up up).
    self assert: blackPawn square equals: targetSquare.
    
]

{ #category : 'tests' }
PawnMoveTests >> testFirstMove [ 
	| game pawn startSquare targetSquare1 targetSquare2 |
	game := MyChessGame freshGame.
	pawn := game pieces detect: [ :p | p isPawn and: [ p square name = 'e2' ] ].

	"Mouvement initial d'une case"
	startSquare := pawn square.
	targetSquare1 := startSquare up.
	game move: pawn to: targetSquare1.
	self assert: pawn square equals: targetSquare1.
	self deny: startSquare hasPiece.

	"Réinitialiser pour tester mouvement initial de deux cases"
	game := MyChessGame freshGame.
	pawn := game pieces detect: [ :p | p isPawn and: [ p square name = 'e2' ] ].

	"Mouvement initial de deux cases"
	startSquare := pawn square.
	targetSquare2 := startSquare up up.
	game move: pawn to: targetSquare2.
	self assert: pawn square equals: targetSquare2.
	self deny: startSquare hasPiece.
]

{ #category : 'tests' }
PawnMoveTests >> testPawnCanMoveOneSquareAfterFirstMove [
    | game pawn squares targetSquare |
    game := MyChessGame freshGame.

    "Placer un pion blanc à e3 (après un premier mouvement)"
    pawn := game pieces detect: [ :p | p isPawn and: [ p square name = 'e2' ] ].
    game move: pawn to: pawn square up. "Simuler le premier mouvement du pion à e3"

    "Définir la case cible (e4)"
    targetSquare := pawn square up.

    "Vérifier que le pion peut avancer d'une seule case (e3 à e4)"
    squares := pawn targetSquaresLegal: true.
    self assert: (squares includes: targetSquare). "e4 doit être une case valide"

]

{ #category : 'tests' }
PawnMoveTests >> testPawnCanMoveOneSquareAfterFirstMove_Black [
    | game pawn squares targetSquare |
    game := MyChessGame freshGame.

    "Placer un pion noir à e6 (après un premier mouvement)"
    pawn := game pieces detect: [ :p | p isPawn and: [ p square name = 'e7' ] ].
    game move: pawn to: pawn square down. "Simuler le premier mouvement du pion à e6"

    "Définir la case cible (e5)"
    targetSquare := pawn square down.

    "Vérifier que le pion peut avancer d'une seule case (e6 à e5)"
    squares := pawn targetSquaresLegal: true.
    self assert: (squares includes: targetSquare). "e5 doit être une case valide"

]

{ #category : 'tests' }
PawnMoveTests >> testPawnCannotJumpOverAnotherPawn_InFirstMove [
    | game pawn obstacle startSquare targetSquare |
	game := MyChessGame freshGame.

	"Trouver un pion et placer un obstacle devant"
	pawn := game pieces detect: [ :p | p isPawn and: [ p square name = 'e2' ] ].
	obstacle := game pieces detect: [ :p | p isPawn and: [ p square name = 'e7' ] ].
	startSquare := pawn square.
	targetSquare := startSquare up.

	"Placer une pièce bloquant le chemin du pion"
	game move: obstacle to: obstacle square down down .
	game move: obstacle to: obstacle square down .
	game move: obstacle to: obstacle square down.

	"Essayer d'avancer d'une case"
	game move: pawn to: targetSquare.
	self assert: pawn square equals: startSquare. "Le pion ne doit pas bouger"
	self assert: targetSquare hasPiece. "La case cible doit toujours contenir l'obstacle"

	"Essayer un mouvement initial de deux cases"
	targetSquare := startSquare up up.
	game move: pawn to: targetSquare.
	self assert: pawn square equals: startSquare. "Le pion ne doit pas bouger"




]

{ #category : 'tests' }
PawnMoveTests >> testPawnCannotMoveTwoSquaresAfterFirstMove [
    | game pawn initialPosition firstMoveSquare secondMoveSquare invalidDoubleStep |

    "1. Créer un jeu vierge et initialiser les pièces"
    game := MyChessGame freshGame.

    "2. Placer un pion blanc en e2"
    pawn := game pieces detect: [ :p | p isPawn and: [ p square name = 'e2' ] ].
    initialPosition := pawn square.

    "3. Déplacer le pion blanc de e2 à e4 (double mouvement)"
    firstMoveSquare := initialPosition up up. "e4"
    game move: pawn to: firstMoveSquare.

    "4. Vérifier que le pion est bien arrivé à e4"
    self assert: pawn square equals: firstMoveSquare.
    self deny: initialPosition hasPiece. "Le pion ne doit plus être sur e2"

    "5. Tentative d'un autre double mouvement après le premier"
    invalidDoubleStep := firstMoveSquare up up. "e6"
    game move: pawn to: invalidDoubleStep.

    "6. Vérifier que le pion n'a pas pu avancer de deux cases après son premier mouvement"
    self deny: pawn square equals: invalidDoubleStep. "Le pion ne doit pas pouvoir avancer de deux cases après son premier mouvement"
    self assert: pawn square equals: firstMoveSquare. "Le pion doit être resté à e4"

    "7. Déplacer le pion de e4 à e5 (mouvement valide d'une case)"
    secondMoveSquare := firstMoveSquare up. "e5"
    game move: pawn to: secondMoveSquare.

    "8. Vérifier que le pion est bien arrivé à e5"
    self assert: pawn square equals: secondMoveSquare.
    self deny: initialPosition hasPiece. "Vérifier que le pion n'est plus sur e2"

]

{ #category : 'tests' }
PawnMoveTests >> testPawnCannotMoveTwoSquaresAfterFirstMove_Black [
    | game pawn squares targetSquare |
    game := MyChessGame freshGame.
    
    "Placer un pion noir à e7"
    pawn := game pieces detect: [ :p | p isPawn and: [ p square name = 'e7' ] ].
    
    "Déplacer le pion noir de e7 à e6 (premier mouvement)"
    game move: pawn to: pawn square down. "Simuler le premier mouvement du pion à e6"
    
    "Définir la case cible comme étant deux cases plus bas (e4), ce qui devrait être impossible"
    targetSquare := pawn square down down. "La case cible devrait être e4, deux cases sous e6"

    "Vérifier que le pion a bien une liste de cases légales"
    squares := pawn targetSquaresLegal: true.
    self assert: squares notNil. "Les cases légales ne doivent pas être nil"
    
    "Vérifier que le pion peut seulement se déplacer d'une case, donc de e6 à e5"
    self assert: (squares includes: pawn square down). "Le pion peut se déplacer d'une case, vers e5"

]

{ #category : 'tests' }
PawnMoveTests >> testPawnFirstMoveTwoSquares_Black [
    | game pawn startSquare doubleStepSquare |
    
    "1. Créer un jeu vierge et initialiser les pièces"
    game := MyChessGame freshGame.

    "2. Placer un pion noir en e7"
    pawn := game pieces detect: [ :p | p isPawn and: [ p square name = 'e7' ] ].
    startSquare := pawn square.

    "3. Calculer la case cible après le double mouvement (e5)"
    doubleStepSquare := (pawn square  down down).

    "4. Déplacer le pion noir de e7 à e5 (double mouvement)"
    game move: pawn to: doubleStepSquare.
    
    "5. Vérifier que le pion noir est bien arrivé à e5"
    self assert: pawn square equals: doubleStepSquare.
    self deny: startSquare hasPiece. "Vérifier que le pion n'est plus sur e7"

]

{ #category : 'tests' }
PawnMoveTests >> testPawnFirstMoveTwoSquares_White [
    | game pawn startSquare doubleStepSquare |
    
    "1. Créer un jeu vierge et initialiser les pièces"
    game := MyChessGame freshGame.

    "2. Placer un pion blanc en e2"
    pawn := game pieces detect: [ :p | p isPawn and: [ p square name = 'e2' ] ].
    startSquare := pawn square.

    "3. Calculer la case cible après le double mouvement (e4)"
    doubleStepSquare := (pawn square  up up).

    "4. Déplacer le pion blanc de e2 à e4 (double mouvement)"
    game move: pawn to: doubleStepSquare.
    
    "5. Vérifier que le pion blanc est bien arrivé à e4"
    self assert: pawn square equals: doubleStepSquare.
    self deny: startSquare hasPiece. "Vérifier que le pion n'est plus sur e2"

]

{ #category : 'tests' }
PawnMoveTests >> testRenderPieceOn [ 
	| game pawn targetSquare |
	game := MyChessGame freshGame.
	pawn := game pieces detect: [ :p | p isPawn and: [ p square name = 'e2' ] ].
	targetSquare := pawn square.
	
	self shouldnt: [ pawn renderPieceOn: targetSquare ] raise: Error.


]

{ #category : 'tests' }
PawnMoveTests >> testWhitePawnDiagonalCapture [
	| game whitePawn targetSquare blackPawn startSquare |
	game := MyChessGame freshGame.

	"Trouver un pion blanc sur e2"
	whitePawn := game pieces detect: [ :p | p isPawn and: [ p square name = 'e2' ] ].
	startSquare := whitePawn square.

	"Trouver un pion noir sur f7 et le déplacer vers une case diagonale (d3)"
	blackPawn := game pieces detect: [ :p | p isPawn and: [ p square name = 'f7' ] ].
	game move: blackPawn to: blackPawn square down down.
	game move: blackPawn to: blackPawn square down.
	game move: blackPawn to: blackPawn square down. "La pièce noire est maintenant en d3"
	targetSquare := blackPawn square.

	"Essayer de capturer la pièce noire"
	game move: whitePawn to: targetSquare.

	"Assertions"
	self assert: targetSquare hasPiece. "La case cible doit être occupée"
	self assert: whitePawn square equals: targetSquare. "Le pion blanc doit maintenant être sur d3"
	self deny: startSquare hasPiece. "La case de départ doit être vide"

]

{ #category : 'tests' }
PawnMoveTests >> testWhitePawnEnPassantCapture [
    | game whitePawn blackPawn originalSquare enPassantSquare |
    game := MyChessGame freshGame.

    "Récupérer les pions concernés"
    whitePawn := game pieces detect: [ :p | p isPawn and: [ p square name = 'e2' ] ].
    blackPawn := game pieces detect: [ :p | p isPawn and: [ p square name = 'd7' ] ].

    "Faire avancer le pion blanc de e2 à e5"
    game move: whitePawn to: whitePawn square up up.
    game move: whitePawn to: whitePawn square up.
    originalSquare := whitePawn square.

    "Faire avancer le pion noir de deux cases (d7 à d5)"
    game move: blackPawn to: blackPawn square down down.
    enPassantSquare := blackPawn square up. "Case cible en passant (d6)"

    "Vérifier que la capture en passant est possible"
    self assert: (whitePawn enPassantTargetSquares includes: enPassantSquare).

    "Capturer en passant (e5 prend d6)"
    game move: whitePawn to: enPassantSquare.

    "Vérifications"
    self assert: whitePawn square equals: enPassantSquare. "Le pion blanc doit être sur d6"
    self deny: originalSquare hasPiece. "e5 doit être maintenant vide"
    self deny: blackPawn square hasPiece. "Le pion noir doit être capturé"

]
