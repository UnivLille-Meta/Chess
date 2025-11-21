Class {
	#name : 'MyRook',
	#superclass : 'MyPiece',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'accessing' }
MyRook >> id [
	^ 'R'
]

{ #category : 'as yet unclassified' }
MyRook >> renderingSquareBlackPieceBlack [ 

	^ 'T'
]

{ #category : 'as yet unclassified' }
MyRook >> renderingSquareBlackPieceWhite [ 

	^ 't'
]

{ #category : 'as yet unclassified' }
MyRook >> renderingSquareWhitePieceBlack [

	^ 'R'
]

{ #category : 'as yet unclassified' }
MyRook >> renderingSquareWhitePieceWhite [ 

	^ 'r'
]

{ #category : 'rendering' }
MyRook >> targetSquares [

	^ self upFile , self downFile , self leftFile , self rightFile
]

{ #category : 'rendering' }
MyRook >> targetSquaresLegal: aBoolean [

	^ (self upFileLegal: aBoolean) , (self downFileLegal: aBoolean)
	  , (self leftFileLegal: aBoolean) , (self rightFileLegal: aBoolean)
]
