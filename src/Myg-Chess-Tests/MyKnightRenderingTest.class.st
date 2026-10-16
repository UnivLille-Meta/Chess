Class {
	#name : 'MyKnightRenderingTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyKnightRenderingTest >> testRenderBlackKnightOnBlackSquare [

    | board knight square |
    board := MyChessBoard empty.
    knight := MyKnight black.

    board at: 'd5' put: knight.
    square := knight square.

    self assert: (square renderKnight: knight) equals: 'm'
]

{ #category : 'tests' }
MyKnightRenderingTest >> testRenderBlackKnightOnWhiteSquare [

    | board knight square |
    board := MyChessBoard empty.
    knight := MyKnight black.

    board at: 'e4' put: knight.
    square := knight square.

    self assert: (square renderKnight: knight) equals: 'M'
]

{ #category : 'tests' }
MyKnightRenderingTest >> testRenderWhiteKnightOnBlackSquare [

    | board knight square |
    board := MyChessBoard empty.
    knight := MyKnight white.

    board at: 'd5' put: knight.
    square := knight square.

    self assert: (square color isBlack).
    self assert: (square renderKnight: knight) equals: 'n'
]

{ #category : 'tests' }
MyKnightRenderingTest >> testRenderWhiteKnightOnWhiteSquare [

    | board knight square |
    board := MyChessBoard empty.
    knight := MyKnight white.

    board at: 'e4' put: knight.
    square := knight square.

    self assert: (square renderKnight: knight) equals: 'N' .
    self deny: square color isBlack
]
