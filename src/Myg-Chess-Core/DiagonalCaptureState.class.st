Class {
	#name : 'DiagonalCaptureState',
	#superclass : 'CaptureState',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'as yet unclassified' }
DiagonalCaptureState >> legalMovesFor: aPawn [
| legalMoves captureLeft captureRight |

    legalMoves := OrderedCollection new.
    captureLeft := aPawn isWhite ifTrue: [ aPawn square up left ] ifFalse: [ aPawn square down left ].
    captureRight := aPawn isWhite ifTrue: [ aPawn square up right ] ifFalse: [ aPawn square down right ].

    (captureLeft notNil and: [ captureLeft hasPiece and: [ captureLeft contents color ~= aPawn color ] ])
        ifTrue: [ legalMoves addLast: captureLeft ].
    (captureRight notNil and: [ captureRight hasPiece and: [ captureRight contents color ~= aPawn color ] ])
        ifTrue: [ legalMoves addLast: captureRight ].

    ^legalMoves.
]
