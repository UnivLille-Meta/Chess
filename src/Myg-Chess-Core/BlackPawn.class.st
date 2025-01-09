Class {
	#name : 'BlackPawn',
	#superclass : 'Pawn',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'rendering' }
BlackPawn >> renderPieceOnBlackSquare [

	^ 'o'.
]

{ #category : 'rendering' }
BlackPawn >> renderPieceOnWhiteSquare [

	^ 'O'.
]
