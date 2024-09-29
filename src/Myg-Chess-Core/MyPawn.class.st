Class {
	#name : 'MyPawn',
	#superclass : 'MyPiece',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'testing' }
MyPawn >> canCaptureDiagonally: aSquare [
	^ aSquare notNil and: [ aSquare hasPiece and: [ aSquare contents color ~= self color ] ].

]

{ #category : 'testing' }
MyPawn >> canMoveForward: aSquare [
	^ aSquare notNil and: [ aSquare hasPiece not ].

]

{ #category : 'as yet unclassified' }
MyPawn >> captureMoves [
	| leftDiagonal rightDiagonal |
	leftDiagonal := self isWhite ifTrue: [ square up left ] ifFalse: [ square down left ].
	rightDiagonal := self isWhite ifTrue: [ square up right ] ifFalse: [ square down right ].
	
	^ { leftDiagonal. rightDiagonal }
		select: [ :s | s notNil and: [ s hasPiece and: [ s contents color ~= self color ] ] ].

]

{ #category : 'accessing' }
MyPawn >> id [

	^ 'P'
]

{ #category : 'testing' }
MyPawn >> isInInitialPosition [
	| initialPositions currentPosition |
	
	"Définir les positions initiales pour les pions blancs et noirs"
	initialPositions := self isWhite
		ifTrue: [ #('a2' 'b2' 'c2' 'd2' 'e2' 'f2' 'g2' 'h2') ]
		ifFalse: [ #('a7' 'b7' 'c7' 'd7' 'e7' 'f7' 'g7' 'h7') ].

	"Obtenir la position actuelle du pion sous forme de chaîne de caractères"
	currentPosition := square name.

	"Vérifier si la position actuelle est dans les positions initiales"
	^ initialPositions includes: currentPosition.


]

{ #category : 'rendering' }
MyPawn >> renderPieceOn: aSquare [ 
	
	^ aSquare renderPawn: self
]

{ #category : 'rendering' }
MyPawn >> targetSquaresLegal: aBoolean [
	| forwardSquare doubleForwardSquare leftDiagonal rightDiagonal forwardMoves|
	"Calculer les cases directement devant, deux cases devant (pour le premier mouvement) et en diagonale"
	forwardSquare := self isWhite ifTrue: [ square up ] ifFalse: [ square down ].
	doubleForwardSquare := self isWhite ifTrue: [ forwardSquare up ] ifFalse: [ forwardSquare down ] .
	forwardMoves := (self isInInitialPosition ifTrue: [ { forwardSquare. doubleForwardSquare } ] ifFalse: [ { forwardSquare } ]).
	^ (forwardMoves
		select: [ :s | s notNil and: [ self canMoveForward: s ] ])
		, (self captureMoves).






]
