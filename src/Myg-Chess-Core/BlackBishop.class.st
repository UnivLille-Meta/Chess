Class {
	#name : 'BlackBishop',
	#superclass : 'Bishop',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'rendering' }
BlackBishop >> renderPieceOnBlackSquare [
	^ 'v' .
]

{ #category : 'rendering' }
BlackBishop >> renderPieceOnWhiteSquare [
	^ 'V' .
]
