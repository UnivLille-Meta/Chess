Class {
	#name : 'WhitePawn',
	#superclass : 'Pawn',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'rendering' }
WhitePawn >> renderPieceOnBlackSquare [

	^ 'p'.
]

{ #category : 'rendering' }
WhitePawn >> renderPieceOnWhiteSquare [

	^ 'P'.
]
