Class {
	#name : 'BlackKnight',
	#superclass : 'Knight',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'rendering' }
BlackKnight >> renderPieceOnBlackSquare [

	^ 'm' .
]

{ #category : 'rendering' }
BlackKnight >> renderPieceOnWhiteSquare [

	^ 'M'.
]
