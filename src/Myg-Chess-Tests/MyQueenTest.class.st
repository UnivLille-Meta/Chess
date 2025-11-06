Class {
	#name : 'MyQueenTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyQueenTest >> testTargetSquaresLegalInCheck [
    | board king queen attacker squares |

    board := MyChessBoard empty.

    king := MyKing white.
    queen := MyQueen white.
    attacker := MyRook black.

    board at: 'e1' put: king.
    board at: 'a1' put: attacker.  "Attaque horizontale depuis a1 (accessible depuis d1)"
    board at: 'd1' put: queen.     "Reine en d1"

    squares := queen targetSquaresLegalInCheck: true.

    "La reine peut :"
    "1. Capturer l'attaquant en a1 (même rangée)"
    "2. Bloquer en allant sur b1 ou c1 (entre a1 et e1)"
    self assert: (squares anySatisfy: [:sq | sq name = 'a1']).
    self assert: (squares anySatisfy: [:sq | sq name = 'b1']).
    self assert: (squares anySatisfy: [:sq | sq name = 'c1']).
]
