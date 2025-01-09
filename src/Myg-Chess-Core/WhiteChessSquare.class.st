Class {
	#name : 'WhiteChessSquare',
	#superclass : 'ChessSquare',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'instance creation' }
WhiteChessSquare class >> new [
^ self basicNew
		  color: Color white ;
		  initialize;
		  yourself
]

{ #category : 'accessing' }
WhiteChessSquare >> contents: aPiece [

	| text |
	contents := aPiece.

	text := contents
		        ifNil: [
			        color isBlack
				        ifFalse: [ 'z' ]
				        ifTrue: [ 'x' ] ]
		        ifNotNil: [ contents renderPieceOnWhiteSquare ].
	piece text: (text asRopedText
			 fontSize: 48;
			 foreground: self foreground;
			 fontName: MyOpenChessDownloadedFont new familyName)
]

{ #category : 'rendering' }
WhiteChessSquare >> renderBishop: aPiece [
	^ aPiece renderPieceOnWhiteSquare .
]

{ #category : 'rendering' }
WhiteChessSquare >> renderKing: aPiece [
	^ aPiece renderPieceOnWhiteSquare .
]

{ #category : 'rendering' }
WhiteChessSquare >> renderKnight: aPiece [

	^ aPiece renderPieceOnWhiteSquare .
]

{ #category : 'rendering' }
WhiteChessSquare >> renderPawn: aPiece [
	^ aPiece renderPieceOnWhiteSquare .
]

{ #category : 'rendering' }
WhiteChessSquare >> renderQueen: aPiece [

	^aPiece renderPieceOnWhiteSquare .
]

{ #category : 'rendering' }
WhiteChessSquare >> renderRook: aPiece [

	^ aPiece renderPieceOnWhiteSquare .
]
