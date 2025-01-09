Class {
	#name : 'WhiteBishop',
	#superclass : 'Bishop',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'rendering' }
WhiteBishop >> renderPieceOnBlackSquare [
	^ 'b' .
]

{ #category : 'rendering' }
WhiteBishop >> renderPieceOnWhiteSquare [
	^ 'B' .
]
