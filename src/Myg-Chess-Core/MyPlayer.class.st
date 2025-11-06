Class {
	#name : 'MyPlayer',
	#superclass : 'Object',
	#instVars : [
		'color',
		'game'
	],
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'constants' }
MyPlayer >> black [

	self color: Color black
]

{ #category : 'accessing' }
MyPlayer >> color [

	^ color
]

{ #category : 'accessing' }
MyPlayer >> color: anObject [

	color := anObject
]

{ #category : 'accessing' }
MyPlayer >> game [

	^ game
]

{ #category : 'accessing' }
MyPlayer >> game: anObject [

	game := anObject
]

{ #category : 'testing' }
MyPlayer >> isWhite [
	
	^ color = Color white
]

{ #category : 'accessing' }
MyPlayer >> king [
	
	^ self pieces detect: [ :p | p isKing ]
]

{ #category : 'accessing' }
MyPlayer >> pieces [

	^ game pieces select: [ :p | p notNil and: [ p color = self color ] ]
]

{ #category : 'constants' }
MyPlayer >> piecesThatCanSaveKing [
    "Retourne toutes les pièces qui peuvent sauver le roi en échec"
    | saviors |
    
    saviors := OrderedCollection new.
    
    self pieces do: [ :piece |
        (piece legalTargetSquaresInCheck notEmpty) ifTrue: [
            saviors add: piece
        ]
    ].
    
    "Si aucune pièce ne peut sauver le roi, on retourne seulement le roi (échec et mat)"
    ^ saviors ifEmpty: [ OrderedCollection with: self king ]
]

{ #category : 'playing' }
MyPlayer >> play [

	| pieces |
	pieces := self king isInCheck
		          ifTrue: [ OrderedCollection with: self king ]
		          ifFalse: [ self pieces copy asOrderedCollection ].


	[ pieces notEmpty ] whileTrue: [
		| piece legalMoves |
		piece := pieces atRandom.
		pieces remove: piece.
		legalMoves := piece legalTargetSquares.
		legalMoves ifNotEmpty: [
			game move: piece to: legalMoves atRandom.
			^ self ] ].

	self halt: 'NO MOVES AVAILABLE!'
]

{ #category : 'playing' }
MyPlayer >> play2 [
	| pieces sauveurs piece legalMoves |

	(self king isInCheck)
		ifTrue: [
			"Récupérer les pièces qui peuvent sauver le roi"
			sauveurs := self piecesThatCanSaveKing.
			[ sauveurs notEmpty ] whileTrue: [
				piece := sauveurs atRandom.
				sauveurs remove: piece.
				"Récupérer les coups qui sortent de l’échec"
				legalMoves := piece legalTargetSquaresInCheck.

				"Si cette pièce a un coup légal pour sauver le roi"
				legalMoves ifNotEmpty: [
					game move: piece to: legalMoves atRandom.
					^ self
				].
			].
		]

		"Sinon, jouer normalement"
		ifFalse: [
			pieces := self pieces copy asOrderedCollection.

			[ pieces notEmpty ] whileTrue: [
				piece := pieces atRandom.
				pieces remove: piece.
				legalMoves := piece legalTargetSquares.
				legalMoves ifNotEmpty: [
					game move: piece to: legalMoves atRandom.
					^ self
				].
			].
		].
]

{ #category : 'constants' }
MyPlayer >> white [

	self color: Color white
]
