Class {
	#name : 'WhiteKnight',
	#superclass : 'Knight',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'rendering' }
WhiteKnight >> renderPieceOnBlackSquare [
	^ 'n'.
]

{ #category : 'rendering' }
WhiteKnight >> renderPieceOnWhiteSquare [

	^ 'N'.
]
