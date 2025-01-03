Class {
	#name : 'PromotionDialog',
	#superclass : 'Object',
	#instVars : [
		'okButton',
		'cancelButton',
		'queenButton',
		'knightButton',
		'dialogWindow',
		'rookButton',
		'kingButton'
	],
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'as yet unclassified' }
PromotionDialog >> showPromotionDialog [
    | window chosenPiece buttons |
    chosenPiece := nil.
    
    window := SystemWindow new.
    window setLabel: 'Choose promotion piece'.
    
    buttons := #('Queen' 'Rook' 'Bishop' 'Knight') collect: [ :pieceName |
        ToButton new
            label: pieceName;
            color: Color lightGray;
            borderColor: Color black;
            borderWidth: 2;
            on: #mouseUp 
            send: #value:
            to: [ :evt | 
                chosenPiece := pieceName.
                window delete.
            ]
    ].
    
    window addMorph: (buttons 
        inject: AlignmentMorph newColumn
        into: [ :column :button |
            column addMorph: button.
            column
        ]).
    
    window openCenteredInWorld.
    
    [ chosenPiece isNil ] whileTrue: [ 
        window world doOneCycle.
        (Delay forMilliseconds: 50) wait.
    ].
    
    ^ chosenPiece
]
