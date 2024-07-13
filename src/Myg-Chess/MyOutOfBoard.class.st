Class {
	#name : 'MyOutOfBoard',
	#superclass : 'Object',
	#category : 'Myg-Chess',
	#package : 'Myg-Chess'
}

{ #category : 'api - configuration' }
MyOutOfBoard >> down [

	^ self
]

{ #category : 'testing' }
MyOutOfBoard >> hasPiece [
	
	^ false
]

{ #category : 'highlighting' }
MyOutOfBoard >> highlightTarget [
	
	"Nothing :)"
]

{ #category : 'testing' }
MyOutOfBoard >> isInBoard [
	
	^ false
]

{ #category : 'accessing' }
MyOutOfBoard >> left [

	^ self
]

{ #category : 'accessing' }
MyOutOfBoard >> right [

	^ self
]

{ #category : 'highlighting' }
MyOutOfBoard >> unhighlightTarget [
	
	"Nothing :)"
]

{ #category : 'instance creation' }
MyOutOfBoard >> up [
	
	^ self
]
