Class {
	#name : 'InitialForwardState',
	#superclass : 'ForwardState',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'as yet unclassified' }
InitialForwardState >> legalMovesFor: aPawn [
	| legalMoves moveOne moveTwo |

    legalMoves := OrderedCollection new.

    moveOne := aPawn isWhite
        ifTrue: [ aPawn square up ]
        ifFalse: [ aPawn square down ].

    moveTwo := aPawn isWhite
        ifTrue: [ aPawn square up up ]
        ifFalse: [ aPawn square down down ].

    (moveOne notNil and: [ moveOne hasPiece not ])
        ifTrue: [ legalMoves addLast: moveOne ].

    (aPawn isAtStartingPosition and: [
        moveTwo notNil and: [
            moveOne hasPiece not and: [
                moveTwo hasPiece not
            ]
        ]
    ]) ifTrue: [ legalMoves addLast: moveTwo ].

    ^ legalMoves
]
