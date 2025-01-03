Class {
	#name : 'MyPieceRenderingTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyPieceRenderingTest >> testMyBishopRendering [

    | whiteSquare blackSquare whiteBishop blackBishop |

    whiteSquare := MyWhiteChessSquare new.
    blackSquare := MyBlackChessSquare new.

    whiteBishop := MyWhiteBishop new.
    blackBishop := MyBlackBishop new.

    self assert: (whiteBishop renderPieceOn: whiteSquare) equals: 'B'.
    self assert: (whiteBishop renderPieceOn: blackSquare) equals: 'b'.
    self assert: (blackBishop renderPieceOn: whiteSquare) equals: 'V'.
    self assert: (blackBishop renderPieceOn: blackSquare) equals: 'v'.

]

{ #category : 'tests' }
MyPieceRenderingTest >> testMyKingRendering [

| whiteSquare blackSquare whiteKing blackKing |

    whiteSquare := MyWhiteChessSquare new.
    blackSquare := MyBlackChessSquare new.

    whiteKing := MyWhiteKing new.
    blackKing := MyBlackKing new.

    self assert: (whiteKing renderPieceOn: whiteSquare) equals: 'K'.
    self assert: (whiteKing renderPieceOn: blackSquare) equals: 'k'.
    self assert: (blackKing renderPieceOn: whiteSquare) equals: 'L'.
    self assert: (blackKing renderPieceOn: blackSquare) equals: 'l'.

]

{ #category : 'tests' }
MyPieceRenderingTest >> testMyKnightRendering [

    | whiteSquare blackSquare whiteKnight blackKnight |

    whiteSquare := MyWhiteChessSquare new.
    blackSquare := MyBlackChessSquare new.

    whiteKnight := MyWhiteKnight new.
    blackKnight := MyBlackKnight new.

    self assert: (whiteKnight renderPieceOn: whiteSquare) equals: 'N'.
    self assert: (whiteKnight renderPieceOn: blackSquare) equals: 'n'.
    self assert: (blackKnight renderPieceOn: whiteSquare) equals: 'M'.
    self assert: (blackKnight renderPieceOn: blackSquare) equals: 'm'.



]

{ #category : 'as yet unclassified' }
MyPieceRenderingTest >> testMyPawnRendering [

   | whiteSquare blackSquare whitePawn blackPawn |

    whiteSquare := MyWhiteChessSquare new.
    blackSquare := MyBlackChessSquare new.

    whitePawn := MyWhitePawn new.
    blackPawn := MyBlackPawn new.

    self assert: (whitePawn renderPieceOn: whiteSquare) equals: 'P'.
    self assert: (whitePawn renderPieceOn: blackSquare) equals: 'p'.
    self assert: (blackPawn renderPieceOn: whiteSquare) equals: 'O'.
    self assert: (blackPawn renderPieceOn: blackSquare) equals: 'o'.


]

{ #category : 'tests' }
MyPieceRenderingTest >> testMyQueenRendering [

    | whiteSquare blackSquare whiteQueen blackQueen |

    whiteSquare := MyWhiteChessSquare new.
    blackSquare := MyBlackChessSquare new.

    whiteQueen := MyWhiteQueen new.
    blackQueen := MyBlackQueen new.

    self assert: (whiteQueen renderPieceOn: whiteSquare) equals: 'Q'.
    self assert: (whiteQueen renderPieceOn: blackSquare) equals: 'q'.
    self assert: (blackQueen renderPieceOn: whiteSquare) equals: 'W'.
    self assert: (blackQueen renderPieceOn: blackSquare) equals: 'w'.



]

{ #category : 'tests' }
MyPieceRenderingTest >> testMyRookRendering [

    | whiteSquare blackSquare whiteRook blackRook |

    whiteSquare := MyWhiteChessSquare new.
    blackSquare := MyBlackChessSquare new.

    whiteRook := MyWhiteRook new.
    blackRook := MyBlackRook new.

    self assert: (whiteRook renderPieceOn: whiteSquare) equals: 'R'.
    self assert: (whiteRook renderPieceOn: blackSquare) equals: 'r'.
    self assert: (blackRook renderPieceOn: whiteSquare) equals: 'T'.
    self assert: (blackRook renderPieceOn: blackSquare) equals: 't'.

]
