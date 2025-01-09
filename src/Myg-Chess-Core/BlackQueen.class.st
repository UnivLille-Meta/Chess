Class {
	#name : 'BlackQueen',
	#superclass : 'Queen',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'rendering' }
BlackQueen >> renderPieceOnBlackSquare [

	^ 'w' .
]

{ #category : 'rendering' }
BlackQueen >> renderPieceOnWhiteSquare [

	^ 'W' .
]
