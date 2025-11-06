Class {
	#name : 'MyPawnTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyPawnTest >> testPawnDiagonalCaptureSquares [
    | board pawn captures |

    board := MyChessBoard empty.
    pawn := MyPawn white.
    board at: 'e2' put: pawn.

    captures := pawn diagonalCaptureSquares.
    
    "Doit trouver d3 et f3"
    self assert: captures size equals: 2.
    self assert: (captures anySatisfy: [:sq | sq name = 'd3']).
    self assert: (captures anySatisfy: [:sq | sq name = 'f3']).
]

{ #category : 'tests' }
MyPawnTest >> testPawnTargetSquaresLegalInCheck [
    | board king pawn attacker squares |

    board := MyChessBoard empty.

    king := MyKing white.
    pawn := MyPawn white.
    attacker := MyRook black.

    board at: 'e1' put: king.
    board at: 'e3' put: attacker.  "Attaquant sur e3 (case de capture diagonale)"
    board at: 'd2' put: pawn.      "Pion en d2"

    squares := pawn targetSquaresLegalInCheck: true.

    "Le pion en d2 peut capturer l'attaquant en e3"
    self assert: (squares anySatisfy: [:sq | sq name = 'e3']).
]
