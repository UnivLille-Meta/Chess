Class {
	#name : 'MyKnightTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyKnightTest >> testTargetSquaresLegalInCheck [
	| board king knight attacker squares |
	board := MyChessBoard empty.

	king := MyKing white.
	knight := MyKnight white.
	attacker := MyRook black.

	"Positionner les pièces"
	board at: 'e1' put: king.
	board at: 'e8' put: attacker.  "Attaque verticale depuis e8 (le roi est en échec)"
	board at: 'g2' put: knight.    "Cavalier en g2"

	squares := knight targetSquaresLegalInCheck: true.

	"Le cavalier ne peut pas bloquer, seulement capturer si possible"
	"Mais ici, le cavalier ne peut pas atteindre e8 → donc aucune case sûre"
	self assert: squares isEmpty.

	"Deuxième scénario : attaquant à portée de saut du cavalier"
	board := MyChessBoard empty.
	board at: 'e1' put: king.
	board at: 'f3' put: attacker.  "Le cavalier peut capturer f3"
	board at: 'd2' put: knight.

	squares := knight targetSquaresLegalInCheck: true.

	"Le cavalier peut capturer la pièce menaçante en f3"
	self assert: (squares anySatisfy: [ :sq | sq name = 'f3' ]).

]
