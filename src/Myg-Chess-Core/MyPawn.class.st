Class {
	#name : 'MyPawn',
	#superclass : 'MyPiece',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'accessing' }
MyPawn >> id [

	^ 'P'
]

{ #category : 'rendering' }
MyPawn >> renderPieceOn: aSquare [ 
	
	^ aSquare renderPawn: self
]

{ #category : 'rendering' }
MyPawn >> targetSquaresLegal: aBoolean [
    | targets forward leftDiagonal rightDiagonal startingRank |
    targets := OrderedCollection new.

    startingRank := self isWhite
        ifTrue: [ $2 ]
        ifFalse: [ $7 ].

    forward := self isWhite
        ifTrue: [ square up ]
        ifFalse: [ square down ].

    leftDiagonal := self isWhite
        ifTrue: [ square up ifNotNil: #left ]
        ifFalse: [ square down ifNotNil: #left ].

    rightDiagonal := self isWhite
        ifTrue: [ square up ifNotNil: #right ]
        ifFalse: [ square down ifNotNil: #right ].

    aBoolean ifFalse: [
    	leftDiagonal ifNotNil: [ :s | targets add: s ].
    	rightDiagonal ifNotNil: [ :s | targets add: s ].
    	^ targets
	].

    forward ifNotNil: [ :s |
        s hasPiece ifFalse: [
            targets add: s.

            square file = startingRank ifTrue: [
                (self isWhite
                    ifTrue: [ s up ]
                    ifFalse: [ s down ])
                    ifNotNil: [ :doubleForward |
                        doubleForward hasPiece ifFalse: [
                            targets add: doubleForward ] ]
            ]
        ]
    ].

    leftDiagonal ifNotNil: [ :s |
        (s hasPiece and: [
            s contents color ~= color
        ]) ifTrue: [
            targets add: s
        ]
    ].

    rightDiagonal ifNotNil: [ :s |
        (s hasPiece and: [
            s contents color ~= color
        ]) ifTrue: [
            targets add: s
        ]
    ].

    ^ targets

]
