Class {
	#name : 'MyPGNParser',
	#superclass : 'Object',
	#instVars : [
		'stream'
	],
	#category : 'Myg-Chess-Importers',
	#package : 'Myg-Chess-Importers'
}

{ #category : 'parsing' }
MyPGNParser class >> forString: aString [

	^ self new
		  stream: aString readStream;
		  yourself
]

{ #category : 'parsing' }
MyPGNParser class >> parse: aString [

	^ (self forString: aString readStream) parse
]

{ #category : 'as yet unclassified' }
MyPGNParser >> nextToken [

	| token specialSymbols |
	specialSymbols := #( $* $( $) $< $> $  $[ $] ).
	
	stream peek ifNil: [ ^ nil ].

	(#( $* $( $) $< $> ) includes: stream peek) ifTrue: [
		self notYetImplemented ].

	stream peek = $[ ifTrue: [ ^ stream next: 1 ].

	stream peek = $. ifTrue: [ ^ stream next: 1 ].

	stream peek = $" ifTrue: [
		stream next.
		^ stream upTo: $" ].

	token := stream upToAny: {
			         Character space.
			         Character tab.
			         Character cr.
			         $. }.

	stream position: stream position - 1.
	stream peek = $. ifFalse: [ stream skip: 1 ].
	token isEmpty ifTrue: [ ^ self nextToken ].
	^ token
]

{ #category : 'parsing' }
MyPGNParser >> parse [

	^ {
		  self parseTagPairs.
		  self parseMoveSection.
		  self nextToken }
]

{ #category : 'as yet unclassified' }
MyPGNParser >> parseMoveNumber [

	| number dotCount |
	number := self nextToken.

	dotCount := 0.
	[ self peekToken = '.' ] whileTrue: [
		dotCount := dotCount + 1.
		self nextToken ].
	^ {
		  number.
		  dotCount }
]

{ #category : 'as yet unclassified' }
MyPGNParser >> parseMoveSection [

	| movement movements |
	movements := OrderedCollection new.
	[ (movement := self parseMovement) notNil ] whileTrue: [
		movements add: movement ].

	^ movements
]

{ #category : 'as yet unclassified' }
MyPGNParser >> parseMovement [

	| nextToken moveNumber firstMovement |
	nextToken := self peekToken.
	(#( '1-0' '0-1' '1/2-1/2' '*' ) includes: nextToken) ifTrue: [ ^ nil ].

	moveNumber := self parseMoveNumber.
	nextToken := self peekToken.
	(nextToken first isDigit or: [
		 #( '1-0' '0-1' '1/2-1/2' '*' ) includes: nextToken ]) ifTrue: [
		^ { moveNumber } ].

	firstMovement := self nextToken.
	nextToken := self peekToken.
	(nextToken first isDigit or: [
		 #( '1-0' '0-1' '1/2-1/2' '*' ) includes: nextToken ]) ifTrue: [
		^ {
			  moveNumber.
			  firstMovement } ].

	^ {
		  moveNumber.
		  firstMovement.
		  self nextToken }
]

{ #category : 'as yet unclassified' }
MyPGNParser >> parseTag [

	| tag |
	(self nextToken = '[') ifFalse: [ ^ nil ].
	
	tag := MyPGNTag new
		tagName: self nextToken;
		value: self nextToken;
		yourself.

	"Consume closing bracket"
	self nextToken.
	^ tag
]

{ #category : 'as yet unclassified' }
MyPGNParser >> parseTagPairs [

	| tag tags |
	tags := OrderedCollection new.
	[ (tag := self parseTag) notNil ] whileTrue: [ tags add: tag ].

	"Consume separator line"
	stream skip: 1.
	
	^ tags
]

{ #category : 'as yet unclassified' }
MyPGNParser >> peekToken [

	| before token |
	before := stream position.
	token := self nextToken.
	stream position: before.
	^ token
]

{ #category : 'accessing' }
MyPGNParser >> stream: aReadStream [ 
	stream := aReadStream
]
