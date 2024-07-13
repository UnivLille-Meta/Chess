Class {
	#name : 'MyNoPiece',
	#superclass : 'Object',
	#instVars : [
		'board'
	],
	#category : 'Myg-Chess',
	#package : 'Myg-Chess'
}

{ #category : 'accessing' }
MyNoPiece >> board: aMyChessSquare [

	board := aMyChessSquare
]

{ #category : 'accessing' }
MyNoPiece >> color [

	^ nil
]

{ #category : 'testing' }
MyNoPiece >> isPiece [
	
	^ false
]

{ #category : 'path commands' }
MyNoPiece >> moveTo: aMyChessSquare [
	"Nothing, unselect!"

	^ MyUnselectedState board: aMyChessSquare board
]

{ #category : 'rendering' }
MyNoPiece >> renderPieceOn: aSquare [
	
	^ aSquare renderEmptySquare
]

{ #category : 'rendering' }
MyNoPiece >> targetSquares [

	^ #(  )
]
