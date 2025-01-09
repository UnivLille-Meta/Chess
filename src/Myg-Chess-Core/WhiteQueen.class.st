Class {
	#name : 'WhiteQueen',
	#superclass : 'Queen',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'rendering' }
WhiteQueen >> renderPieceOnBlackSquare [

	^ 'q'.
]

{ #category : 'rendering' }
WhiteQueen >> renderPieceOnWhiteSquare [

	^ 'Q'.
]
