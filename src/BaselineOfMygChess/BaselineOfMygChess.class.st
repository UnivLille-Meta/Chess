Class {
	#name : 'BaselineOfMygChess',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfMygChess',
	#package : 'BaselineOfMygChess'
}

{ #category : 'baselines' }
BaselineOfMygChess >> baseline: spec [

	<baseline>
	spec
		baseline: 'Myg'
		with: [ spec repository: 'github://Ducasse/Myg:v1.0.2/src' ].

	spec
		package: 'Myg-Chess-Core'
		with: [ spec requires: #( 'Myg-Chess-Importers' ) ];
		package: 'Myg-Chess-Importers';
		package: 'Myg-Chess-Tests'
		with: [ spec requires: #( 'Myg-Chess-Core' ) ]
]
