Class {
	#name : 'BlackChessSquare',
	#superclass : 'ChessSquare',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'instance creation' }
BlackChessSquare class >> new [
^ self basicNew
		  color: Color black;
		  initialize;
		  yourself
]

{ #category : 'accessing' }
BlackChessSquare >> contents: aPiece [

	| text |
	contents := aPiece.

	text := contents
		        ifNil: [
			        color isBlack
				        ifFalse: [ 'z' ]
				        ifTrue: [ 'x' ] ]
		        ifNotNil: [ contents renderPieceOnBlackSquare ].
	piece text: (text asRopedText
			 fontSize: 48;
			 foreground: self foreground;
			 fontName: MyOpenChessDownloadedFont new familyName)
]

{ #category : 'rendering' }
BlackChessSquare >> renderBishop: aPiece [
	aPiece renderPieceOnBlackSquare .
]

{ #category : 'rendering' }
BlackChessSquare >> renderKing: aPiece [

	aPiece renderPieceOnBlackSquare .
]

{ #category : 'rendering' }
BlackChessSquare >> renderKnight: aPiece [

	^ aPiece renderPieceOnBlackSquare .
]

{ #category : 'rendering' }
BlackChessSquare >> renderPawn: aPiece [
	^ aPiece renderPieceOnBlackSquare .
]

{ #category : 'rendering' }
BlackChessSquare >> renderQueen: aPiece [

	^ aPiece renderPieceOnBlackSquare .
]

{ #category : 'rendering' }
BlackChessSquare >> renderRook: aPiece [

	^ aPiece renderPieceOnBlackSquare .
]
