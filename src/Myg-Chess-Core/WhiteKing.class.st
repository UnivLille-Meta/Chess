Class {
	#name : 'WhiteKing',
	#superclass : 'King',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'rendering' }
WhiteKing >> renderPieceOnBlackSquare [

	^ 'k'.
]

{ #category : 'rendering' }
WhiteKing >> renderPieceOnWhiteSquare [

	^ 'K'.
]
