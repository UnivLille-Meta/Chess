Class {
	#name : 'BlackKing',
	#superclass : 'King',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'rendering' }
BlackKing >> renderPieceOnBlackSquare [

	^ 'l'.
]

{ #category : 'rendering' }
BlackKing >> renderPieceOnWhiteSquare [

	^ 'L'.
]
