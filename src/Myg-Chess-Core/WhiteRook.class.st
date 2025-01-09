Class {
	#name : 'WhiteRook',
	#superclass : 'Rook',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'rendering' }
WhiteRook >> renderPieceOnBlackSquare [

	^ 'r' .
]

{ #category : 'rendering' }
WhiteRook >> renderPieceOnWhiteSquare [

	^ 'R' .
]
