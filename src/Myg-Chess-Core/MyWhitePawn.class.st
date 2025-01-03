Class {
	#name : 'MyWhitePawn',
	#superclass : 'MyPawn',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'rendering' }
MyWhitePawn >> renderPieceOn: aSquare [

	^ aSquare renderWhitePawn
]

{ #category : 'rendering' }
MyWhitePawn >> targetSquaresLegal: aBoolean [ 

	| upSquare doubleUpSquare diagRightSquare diagLeftSquare leftSquare rightSquare possibleMoves downSquare|
	"Récupère les cases voisines"
	upSquare := self square up.
	doubleUpSquare := upSquare ifNotNil: [ upSquare up ].
	leftSquare := self square left.
	downSquare := self square down.
	rightSquare := self square right.
	diagRightSquare := rightSquare ifNotNil: [ self square right up ].
	diagLeftSquare := leftSquare ifNotNil: [ self square left up ].

	possibleMoves := OrderedCollection new.

	"Déplacement en avant d'une case"
	upSquare hasPiece ifFalse: [ possibleMoves add: upSquare ].
	"Déplacement en avant de deux cases"
	(self square file = $2 and: [
		 upSquare hasPiece not and: [ doubleUpSquare hasPiece not ] ]) ifTrue: [
		possibleMoves add: doubleUpSquare ].

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
	(self square file = $5 and: [
		 leftSquare notNil and: [
		 leftSquare hasPiece and: [
				 leftSquare contents color ~= self color ] ]]) ifTrue: [
		possibleMoves add: diagLeftSquare].
	   (possibleMoves includes: diagLeftSquare) ifTrue: [ downSquare contents: nil.].
	
	
	"Capture en passant à droite"
	(self square file = $5 and: [
		 rightSquare notNil and: [
		 rightSquare hasPiece and: [
				 rightSquare contents color ~= self color ] ]] ) ifTrue: [
		possibleMoves add: diagRightSquare ].
	   (possibleMoves includes: diagRightSquare) ifTrue: [ downSquare contents: nil.].
	
	
	^ possibleMoves

]
