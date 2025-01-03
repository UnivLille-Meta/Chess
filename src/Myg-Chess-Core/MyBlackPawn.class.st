Class {
	#name : 'MyBlackPawn',
	#superclass : 'MyPawn',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'rendering' }
MyBlackPawn >> renderPieceOn: aSquare [

	^ aSquare renderBlackPawn
]

{ #category : 'rendering' }
MyBlackPawn >> targetSquaresLegal: aBoolean [

	| down1 down2 diagRightBlack diagLeftBlack leftSquare rightSquare targetSquares |
	"Récupère les cases voisines"
	down1 := self square down.
	down2 := down1 down .
	diagRightBlack := self square right ifNotNil: [ self square right down ].
	diagLeftBlack := self square left ifNotNil: [ self square left down ].
	leftSquare := self square left.
	rightSquare := self square right.

	targetSquares := OrderedCollection new.

	"Déplacement en avant d'une case"
	down1 hasPiece ifFalse: [ targetSquares add: down1 ].
		
	"Déplacement en avant de deux cases"
	(self square file = $7 and: [
		down1 hasPiece not and: [ down2 hasPiece not ] ])
		ifTrue: [ targetSquares add: down2 ].

	"Capture en diagonale gauche"
	(diagLeftBlack hasPiece and: [
			 diagLeftBlack contents color ~= self color ] ) ifTrue: [
		targetSquares add: diagLeftBlack ].

	"Capture en diagonale droite"
	(diagRightBlack hasPiece and: [
			 diagRightBlack contents color ~= self color ] ) ifTrue: [
		targetSquares add: diagRightBlack ].

	"Capture en passant à gauche"
	(self square file = $4 and: [
		 leftSquare hasPiece and: [
				 leftSquare contents color ~= self color ] ]) ifTrue: [
		targetSquares add: diagLeftBlack ].

	"Capture en passant à droite"
	(self square file = $4 and: [
		 rightSquare hasPiece and: [
				 rightSquare contents color ~= self color ] ] ) ifTrue: [
		targetSquares add: diagRightBlack ].

	^ targetSquares
]

{ #category : 'rendering' }
MyBlackPawn >> targetSquaresLegalBlack: aBoolean [ 

	| downSquare doubleDownSquare diagRightSquare diagLeftSquare leftSquare rightSquare possibleMoves upSquare|
	"Récupère les cases voisines"
	downSquare := self square down.
	doubleDownSquare := downSquare down .
	diagRightSquare := self square right ifNotNil: [ self square right down ].
	diagLeftSquare := self square left ifNotNil: [ self square left down ].
	leftSquare := self square left.
	rightSquare := self square right.
	upSquare := self square up.
	possibleMoves := OrderedCollection new.

	"Déplacement en avant d'une case"
	downSquare hasPiece ifFalse: [ possibleMoves add: downSquare ].
	
	"Déplacement en avant de deux cases"
	(self square file = $7 and: [
		downSquare hasPiece not and: [ doubleDownSquare hasPiece not ] ])
		ifTrue: [ possibleMoves add: doubleDownSquare ].

	"Capture en diagonale gauche"
    (diagLeftSquare notNil and: [
        diagLeftSquare hasPiece and: [
        diagLeftSquare contents color ~= self color ]])
        ifTrue: [ possibleMoves add: diagLeftSquare ].


	"Capture en diagonale droite"
    (diagRightSquare notNil and: [
        diagRightSquare hasPiece and: [
        diagRightSquare contents color ~= self color ]])
        ifTrue: [ possibleMoves add: diagRightSquare ].

	"Capture en passant à gauche"
	(self square file = $4 and: [
		 leftSquare notNil and: [
		 leftSquare hasPiece and: [
		 leftSquare contents color ~= self color ] ]]) ifTrue: [possibleMoves add: diagLeftSquare].
       (possibleMoves includes: diagLeftSquare) ifTrue: [ upSquare contents: nil. ].

	"Capture en passant à droite"
	(self square file = $4 and: [
		 rightSquare notNil and: [
		 rightSquare hasPiece and: [
		 rightSquare contents color ~= self color ] ]] ) ifTrue: [possibleMoves add: diagRightSquare].
       (possibleMoves includes: diagRightSquare) ifTrue: [ upSquare contents: nil. ].

	^ possibleMoves 
]
