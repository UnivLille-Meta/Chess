Class {
	#name : 'BlackRook',
	#superclass : 'Rook',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'rendering' }
BlackRook >> renderPieceOnBlackSquare [

	^ 't'  .
]

{ #category : 'rendering' }
BlackRook >> renderPieceOnWhiteSquare [

	^ 'T' .
]
