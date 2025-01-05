Class {
	#name : 'MyPawn',
	#superclass : 'MyPiece',
	#instVars : [
		'hasMoved'
	],
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'as yet unclassified' }
MyPawn >> captureMovesFor: aPawn [

	| captureMoves |
	"Déterminer les cases diagonales/ -1@1 est gauche diagonale/ 1@1 est droite diagonale"
	captureMoves := {
		                (aPawn square + (-1 @ (aPawn isWhite
			                   ifTrue: [ 1 ]
			                   ifFalse: [ -1 ]))).
		                (aPawn square + (1 @ (aPawn isWhite
			                   ifTrue: [ 1 ]
			                   ifFalse: [ -1 ]))) }. "on remplace par -1 dans l'axe y pour le black"

	captureMoves := captureMoves select: [ :s |
		                s notNil and: [
			                s hasPiece and: [ s contents color ~= aPawn color ] ] ].
	^ captureMoves
]

{ #category : 'as yet unclassified' }
MyPawn >> forwardMovesFor: aPawn [

	| forwardMoves nextSquare |
	forwardMoves := OrderedCollection new.

	"Determine the first square"
	nextSquare := aPawn isWhite
		              ifTrue: [ aPawn square up ]
		              ifFalse: [ aPawn square down ].

	"Check the first square"
	nextSquare notNil and: [
		nextSquare hasPiece ifFalse: [
			forwardMoves add: nextSquare.

			"Determine the second square only if the first square is empty and the pawn has not moved"
			aPawn hasMoved ifFalse: [ "voir si le pion a déja fait un move ou pas"
				nextSquare := aPawn isWhite
					              ifTrue: [ nextSquare up ]
					              ifFalse: [ nextSquare down ].
				"check une autre fois"
				nextSquare notNil and: [
					nextSquare hasPiece ifFalse: [ forwardMoves add: nextSquare ] ] ] ] ].

	^ forwardMoves
]

{ #category : 'accessing' }
MyPawn >> hasMoved [
	^ hasMoved 
]

{ #category : 'accessing' }
MyPawn >> hasMoved: aBoolean [
	hasMoved := aBoolean 
]

{ #category : 'accessing' }
MyPawn >> id [

	^ 'P'
]

{ #category : 'initialization' }
MyPawn >> initialize [ 
	super initialize.
	hasMoved := false
]

{ #category : 'path commands' }
MyPawn >> moveTo: aSquare [
	super moveTo: aSquare.
	hasMoved := true
]

{ #category : 'rendering' }
MyPawn >> renderPieceOn: aSquare [ 
	
	^ aSquare renderPawn: self
]

{ #category : 'rendering' }
MyPawn >> targetSquaresLegal: aBoolean [ 
    | forwardMoves captureMoves |

    "Get forward moves"
    forwardMoves := self forwardMovesFor: self.
    
    "Get capture moves"
    captureMoves := self captureMovesFor: self.
    
    "Combine both types of moves"
    ^ captureMoves, forwardMoves

]
