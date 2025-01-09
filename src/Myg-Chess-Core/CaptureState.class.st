Class {
	#name : 'CaptureState',
	#superclass : 'Object',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'as yet unclassified' }
CaptureState >> legalMovesFor: aPawn [
^ self subclassResponsibility.
]
