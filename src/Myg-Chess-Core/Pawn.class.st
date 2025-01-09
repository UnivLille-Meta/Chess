Class {
	#name : 'Pawn',
	#superclass : 'MyPiece',
	#instVars : [
		'captureState',
		'forwardState',
		'Square'
	],
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'accessing' }
Pawn >> id [

	^ 'P'
]

{ #category : 'initialization' }
Pawn >> initialize [ 
    super initialize.
    forwardState := InitialForwardState new.
    captureState := DiagonalCaptureState new.
]

{ #category : 'testing' }
Pawn >> isAtStartingPosition [

	^ self isWhite 
	ifTrue: [ square file = $2 ]
	ifFalse: [ square file = $7 ].
]

{ #category : 'as yet unclassified' }
Pawn >> legalMoves [
    | moves |
    moves := OrderedCollection new.
    
    "Ajoute les mouvements d'avance depuis l'état actuel"
    moves addAll: (forwardState legalMovesFor: self).

    "Ajoute les mouvements de capture depuis l'état actuel"
    moves addAll: (captureState legalMovesFor: self).

    ^ moves
]

{ #category : 'path commands' }
Pawn >> moveTo: aSquare [
"Vérifier si le déplacement vers aSquare est légal"
    (self legalTargetSquares includes: aSquare) ifFalse: [ ^ self ].

    "Si le pion quitte sa position initiale, passer à NormalForwardState"
    (self isAtStartingPosition and: [
        | delta |
        delta := (self isWhite ifTrue: [
                    (aSquare file asciiValue - square file asciiValue) 
                 ] ifFalse: [
                    (square file asciiValue - aSquare file asciiValue)
                 ]).
        delta > 0
    ]) ifTrue: [ self promoteToNormalForward ].

    "Mettre à jour le plateau : vider la case actuelle, déplacer le pion et mettre à jour la nouvelle case"
    square emptyContents.
    square := aSquare.
    aSquare contents: self.
]

{ #category : 'as yet unclassified' }
Pawn >> promoteToNormalForward [
forwardState := NormalForwardState new.
]

{ #category : 'rendering' }
Pawn >> renderPieceOn: aSquare [ 
	
	^ aSquare renderPawn: self
]

{ #category : 'initialization' }
Pawn >> resetCaptureState [
captureState := DiagonalCaptureState new.
]

{ #category : 'as yet unclassified' }
Pawn >> targetSquaresLegal: aBoolean [
	| moves |
    moves := OrderedCollection new.

    "Ajoute les mouvements en avant"
    moves addAll: (forwardState legalMovesFor: self).

    "Ajoute les captures"
    moves addAll: (captureState legalMovesFor: self).

    ^ moves
]
