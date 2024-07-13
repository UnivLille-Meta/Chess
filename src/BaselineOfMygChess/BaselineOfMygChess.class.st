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
		package: 'MygChess'
		with: [ spec requires: #( 'MygChess-Importers' ) ];
		package: 'MygChess-Importers'
]
