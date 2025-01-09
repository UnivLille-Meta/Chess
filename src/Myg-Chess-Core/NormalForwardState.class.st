Class {
	#name : 'NormalForwardState',
	#superclass : 'ForwardState',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'as yet unclassified' }
NormalForwardState >> legalMovesFor: aPawn [
| moveOne legalMoves |

    legalMoves := OrderedCollection new.
    moveOne := aPawn isWhite ifTrue: [ aPawn square up ] ifFalse: [ aPawn square down ].

    (moveOne notNil and: [ moveOne hasPiece not ])
        ifTrue: [ legalMoves add: moveOne ].

    ^ legalMoves.
]
