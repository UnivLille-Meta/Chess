Class {
	#name : 'MyPawn',
	#superclass : 'MyPiece',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'as yet unclassified' }
MyPawn >> captureOpponent [

       ^ { self moveLeft. self moveRight }
        select: [ :square |
            square notNil
                and: [ square hasPiece
                    and: [ square contents color ~= self color ] ]
        ]
]

{ #category : 'accessing' }
MyPawn >> id [

	^ 'P'
]

{ #category : 'accessing' }
MyPawn >> id2 [

	^ 'P'
]

{ #category : 'testing' }
MyPawn >> isEmptySquare: aSquare [
    ^ aSquare notNil and: [ aSquare hasPiece not ]
]

{ #category : 'testing' }
MyPawn >> isTheFirstMove [

^self isWhite 
       ifTrue: [ self square file = $2 ]
       ifFalse: [ self square file = $7 ]
]

{ #category : 'api - configuration' }
MyPawn >> moveLeft [

^ self isWhite
        ifTrue: [ self square up left ]
        ifFalse: [ self square down left ]
]

{ #category : 'api - configuration' }
MyPawn >> moveRight [ 

^ self isWhite
        ifTrue: [ self square up right]
        ifFalse: [ self square down right ]
]

{ #category : 'as yet unclassified' }
MyPawn >> moveToOneSquare [

    ^ self isWhite
        ifTrue: [ self square up ]
        ifFalse: [ self square down ]
]

{ #category : 'as yet unclassified' }
MyPawn >> moveToTwoSquare [

    | firstSquare |

    firstSquare := self moveToOneSquare .
    firstSquare ifNil: [ ^ nil ].

    ^ self isWhite
        ifTrue: [ firstSquare up ]
        ifFalse: [ firstSquare down ]
]

{ #category : 'rendering' }
MyPawn >> renderPieceOn: aSquare [ 
	
	^ aSquare renderPawn: self
]

{ #category : 'rendering' }
MyPawn >> targetSquaresLegal: aBoolean [

   | firstSquare secondSquare captureSquares |

    firstSquare := self moveToOneSquare.
    captureSquares := self captureOpponent.

    (self isEmptySquare: firstSquare)
        ifFalse: [ ^ captureSquares ].

    self isTheFirstMove
        ifFalse: [ ^ { firstSquare } , captureSquares ].

    secondSquare := self moveToTwoSquare.

    (self isEmptySquare: secondSquare)
        ifTrue: [
            ^ { firstSquare. secondSquare } , captureSquares
        ].

    ^ { firstSquare } , captureSquares
]
