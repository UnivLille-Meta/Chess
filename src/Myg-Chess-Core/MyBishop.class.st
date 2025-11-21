Class {
	#name : 'MyBishop',
	#superclass : 'MyPiece',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'accessing' }
MyBishop >> id [
	
	^ 'B'
]

{ #category : 'as yet unclassified' }
MyBishop >> renderingSquareBlackPieceBlack [

	^ 'V'
]

{ #category : 'as yet unclassified' }
MyBishop >> renderingSquareBlackPieceWhite [ 

	^ 'v'
]

{ #category : 'as yet unclassified' }
MyBishop >> renderingSquareWhitePieceBlack [

	^ 'B'
]

{ #category : 'as yet unclassified' }
MyBishop >> renderingSquareWhitePieceWhite [

	^ 'b'
]

{ #category : 'rendering' }
MyBishop >> targetSquaresLegal: aBoolean [

	^ (self upRightDiagonalLegal: aBoolean)
	  , (self upLeftDiagonalLegal: aBoolean)
	  , (self downRightDiagonalLegal: aBoolean)
	  , (self downLeftDiagonalLegal: aBoolean)
]
