Class {
	#name : 'MyPawn',
	#superclass : 'MyPiece',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'accessing' }
MyPawn >> id [

	^ 'P'
]

{ #category : 'as yet unclassified' }
MyPawn >> renderingSquareBlackPieceBlack [

	^ 'O'
]

{ #category : 'as yet unclassified' }
MyPawn >> renderingSquareBlackPieceWhite [

	^ 'o'
]

{ #category : 'as yet unclassified' }
MyPawn >> renderingSquareWhitePieceBlack [

	^ 'P'
]

{ #category : 'as yet unclassified' }
MyPawn >> renderingSquareWhitePieceWhite [

	^ 'p'
]

{ #category : 'rendering' }
MyPawn >> targetSquaresLegal: aBoolean [

	^ (self isWhite
		   ifTrue: [ { square up } ]
		   ifFalse: [ { square down } ]) select: [ :s |
		  s notNil and: [
			  s hasPiece not or: [ s contents color ~= color ] ] ]
]
