Class {
	#name : 'MyPieceTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyPieceTest >> testCanBlockThreatFromToOn [
    | board attacker king piece result |

    board := MyChessBoard empty.
    attacker := board at: 'e8'.
    king := board at: 'e1'.
    piece := MyPawn new.

    "Cas où la case est bien entre l'attaquant et le roi"
    result := piece canBlockThreatFrom: attacker to: king on: (board at: 'e3').
    self assert: result.

    "Cas où la case n'est PAS sur la ligne"
    result := piece canBlockThreatFrom: attacker to: king on: (board at: 'd3').
    self deny: result.
]

{ #category : 'tests' }
MyPieceTest >> testOwnKing [ [
    | board piece king whiteKing square |
    board := MyChessBoard basicNew.
    board initialize.

    "Créer le roi blanc et le placer"
    whiteKing := MyKing white.


    square := board at: 'e1'.


    square contents: whiteKing.


    whiteKing square: square.


    "Créer un pion blanc et le placer"


    piece := MyPawn white.


    square := board at: 'a2'.


    square contents: piece.


    piece square: square.





    "Tester ownKing"


    king := piece ownKing.


    self assert: king notNil.


    self assert: king isKing.


    self assert: king color = piece color.





]
]

{ #category : 'tests' }
MyPieceTest >> testSquaresBetween [
    | board square1 square2 betweenSquares piece |

    board := MyChessBoard empty.
    piece := MyPawn new.

    "=== Cas vertical ==="
    square1 := board at: 'e1'.
    square2 := board at: 'e8'.
    betweenSquares := piece squaresBetween: square1 and: square2.
    self assert: ((betweenSquares collect: [:sq | sq name]) asArray = #('e2' 'e3' 'e4' 'e5' 'e6' 'e7')).

    "=== Cas diagonale ==="
    square1 := board at: 'a1'.
    square2 := board at: 'c3'.
    betweenSquares := piece squaresBetween: square1 and: square2.
    self assert: ((betweenSquares collect: [:sq | sq name]) asArray = #('b2')).

    "=== Cas non alignées ==="
    square1 := board at: 'a1'.
    square2 := board at: 'c4'.
    betweenSquares := piece squaresBetween: square1 and: square2.
    self assert: betweenSquares isEmpty.
]
