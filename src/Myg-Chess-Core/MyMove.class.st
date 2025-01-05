Class {
	#name : 'MyMove',
	#superclass : 'Object',
	#instVars : [
		'piece',
		'startSquare',
		'endSquare'
	],
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'accessing' }
MyMove >> endSquare [
	^ endSquare
]

{ #category : 'accessing' }
MyMove >> endSquare: aSquare [
	endSquare := aSquare 
]

{ #category : 'accessing' }
MyMove >> piece [ 
	^ piece
]

{ #category : 'accessing' }
MyMove >> piece: aPiece [
	piece := aPiece 
]

{ #category : 'accessing' }
MyMove >> startSquare [
	^ startSquare
]

{ #category : 'accessing' }
MyMove >> startSquare: aSquare [
	startSquare:= aSquare 
]
