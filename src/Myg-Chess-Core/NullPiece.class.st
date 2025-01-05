"
New Class to remove the nil checks from MyChessBoard class
"
Class {
	#name : 'NullPiece',
	#superclass : 'MyPiece',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'testing' }
NullPiece >> isNullPiece [
	^ true.
]

{ #category : 'accessing' }
NullPiece >> nullPieceColor [
    ^ Color transparent
]

{ #category : 'rendering' }
NullPiece >> renderPieceOn: aSquare [
    ^ aSquare color isBlack
        ifTrue: [ 'x' ]
        ifFalse: [ 'z' ]
]

{ #category : 'rendering' }
NullPiece >> targetSquaresLegal: aBoolean [
    ^ #()
]
