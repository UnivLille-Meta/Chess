Class {
	#name : 'MyKnight',
	#superclass : 'MyPiece',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'accessing' }
MyKnight >> id [
	
	^ 'N'
]

{ #category : 'rendering' }
MyKnight >> renderPieceOn: aSquare [

	^ aSquare renderKnight: self
]

{ #category : 'rendering' }
MyKnight >> targetSquaresLegal: aBoolean [

	^ {
		  (square right ifNotNil: [ :p | p right ifNotNil: #up ]).
		  (square right ifNotNil: [ :p | p right ifNotNil: #down ]).
		  (square left ifNotNil: [ :p | p left ifNotNil: #up ]).
		  (square left ifNotNil: [ :p | p left ifNotNil: #down ]).
		  (square up ifNotNil: [ :p | p up ifNotNil: #left ]).
		  (square up ifNotNil: [ :p | p up ifNotNil: #right ]).
		  (square down ifNotNil: [ :p | p down ifNotNil: #left ]).
		  (square down ifNotNil: [ :p | p down ifNotNil: #right ]) }
		  select: [ :s |
			  s notNil and: [ s hasPiece not or: [ s contents color ~= color ] ] ]
]

{ #category : 'rendering' }
MyKnight >> targetSquaresLegalInCheck: aBoolean [
	| king threats moves safeSquares |

	king := self ownKing.
	threats := king threateningPieces.

	threats isEmpty ifTrue: [ ^ self targetSquaresLegal: aBoolean ].

	(threats size > 1 and: [ self isKing not ]) ifTrue: [
		^ OrderedCollection new
	].

	"Tous les mouvements légaux possibles du cavalier"
	moves := self targetSquaresLegal: aBoolean.

	"Ne garder que les cases où il capture la pièce menaçante"
	safeSquares := moves select: [ :sq |
		threats anySatisfy: [ :assoc |
			| attacker attackerSquare |
			attacker := assoc key.
			attackerSquare := assoc value.
			sq = attackerSquare
		]
	].

	^ safeSquares

]
