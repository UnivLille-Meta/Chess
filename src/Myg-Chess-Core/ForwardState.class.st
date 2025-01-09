Class {
	#name : 'ForwardState',
	#superclass : 'Object',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'as yet unclassified' }
ForwardState >> legalMovesFor: aPawn [
	self subclassResponsibility.
]
