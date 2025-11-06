Class {
	#name : 'MyBishop',
	#superclass : 'MyPiece',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'accessing' }
MyBishop >> id [
	
	^ 'B'
]

{ #category : 'rendering' }
MyBishop >> renderPieceOn: aSquare [

	^ aSquare renderBishop: self
]

{ #category : 'rendering' }
MyBishop >> targetSquaresLegal: aBoolean [

	^ (self upRightDiagonalLegal: aBoolean)
	  , (self upLeftDiagonalLegal: aBoolean)
	  , (self downRightDiagonalLegal: aBoolean)
	  , (self downLeftDiagonalLegal: aBoolean)
]

{ #category : 'rendering' }
MyBishop >> targetSquaresLegalInCheck: aBoolean [
	| king threats moves safeSquares |
	
	king := self ownKing.
	threats := king threateningPieces.
	
	threats isEmpty ifTrue: [ ^ self targetSquaresLegal: aBoolean ].
	
	(threats size > 1 and: [ self isKing not ]) ifTrue: [
		^ OrderedCollection new
	].

	"Récupérer tous les mouvements possibles du fou"
	moves := OrderedCollection new.

	moves addAll: (self upRightDiagonalLegal: aBoolean).
	moves addAll: (self upLeftDiagonalLegal: aBoolean).
	moves addAll: (self downRightDiagonalLegal: aBoolean).
	moves addAll: (self downLeftDiagonalLegal: aBoolean).

	"Ne garder que les cases qui permettent de capturer ou bloquer la menace"
	safeSquares := moves select: [ :sq |
		threats anySatisfy: [ :assoc |
			| attacker attackerSquare |
			attacker := assoc key.
			attackerSquare := assoc value.

			sq = attackerSquare or: [
				self
					canBlockThreatFrom: attackerSquare
					to: king square
					on: sq
			]
		]
	].

	^ safeSquares

]
