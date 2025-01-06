Class {
	#name : 'MyPieceVisitor',
	#superclass : 'Object',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'visiting' }
MyPieceVisitor >> visit: piece [
	^piece acceptVisitor: self
]
