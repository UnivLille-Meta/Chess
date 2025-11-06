Class {
	#name : 'MyKing',
	#superclass : 'MyPiece',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'as yet unclassified' }
MyKing >> attackingSquares [

	^ self basicTargetSquares
]

{ #category : 'rendering' }
MyKing >> basicTargetSquares [

	"The king can move one square on each direction including diagonals"
	^ {
		square ifNotNil: #right.
		square up ifNotNil: #right.
		square ifNotNil: #up.
		square up ifNotNil: #left.
		square ifNotNil: #left.
		square left ifNotNil: #down.
		square ifNotNil: #down.
		square down ifNotNil: #right
	}
]

{ #category : 'accessing' }
MyKing >> id [
	
	^ 'K'
]

{ #category : 'testing' }
MyKing >> isCheckMated [
	"We check if the opponent pieces target all my potential movements and myself"

	| threatenedSquares |
	threatenedSquares := self opponentPieces flatCollect: [ :e |
		                     e attackingSquares ].

	^ self legalTargetSquares isEmpty and: [
		  threatenedSquares includes: self square ]
]

{ #category : 'testing' }
MyKing >> isInCheck [
	"We check if the opponent pieces target all my potential movements and myself"

	| threatenedSquares |
	threatenedSquares := self opponentPieces flatCollect: [ :e |
		                     e attackingSquares ].

	^ threatenedSquares includes: self square
]

{ #category : 'testing' }
MyKing >> isKing [
	
	^ true
]

{ #category : 'accessing' }
MyKing >> opponentPieces [

	^ self board pieces select: [ :e |
		  e notNil and: [ e color = color negated ] ]
]

{ #category : 'rendering' }
MyKing >> renderPieceOn: aSquare [

	^ aSquare renderKing: self
]

{ #category : 'rendering' }
MyKing >> targetSquaresLegal: aBoolean [
	"The king cannot move to threatened squares"

	| threatenedSquares |
	threatenedSquares := self opponentPieces flatCollect: [ :e |
		                     e attackingSquares ].

	^ self basicTargetSquares select: [ :s |
		  s notNil and: [
			  (threatenedSquares includes: s) not and: [
				  s hasPiece not or: [ 
					"The square has an opponent piece"
					s contents color ~= color and: [ 
						"Let's hope the piece is not defended"
						threatenedSquares includes: s  ] ] ] ] ]
]

{ #category : 'rendering' }
MyKing >> targetSquaresLegalInCheck: aBoolean [

	| threatenedSquares attackers |
	threatenedSquares := self opponentPieces flatCollect: [ :e |
		                     e attackingSquares ].
	attackers := self threateningPieces collect: [ :pair | pair key ].

	"Le roi peut se deplacer dans une case :"
	"1. non occupée par un ennemi"
	"2. vide ou contenant une pièce ennemi non defendue"
	^ self basicTargetSquares select: [ :s |
			  s notNil and: [
					  (threatenedSquares includes: s) not and: [
							  s hasPiece not or: [ "la csae contient une pièce ennemi"
									  s contents color ~= color and: [ "vérifier si la pièce n'est pas defendue"
											  | squareThreats |
											  squareThreats := self opponentPieces select: [ :p |
												                   (p attackingSquares includes: s) and: [
													                   p ~= s contents ] ].
											  squareThreats isEmpty ] ] ] ] ]
]

{ #category : 'as yet unclassified' }
MyKing >> threateningPieces [
	"return collection of pairs piece and square of opponent"

	| threats mySquare |
	mySquare := self square.
	threats := OrderedCollection new.
	^ self opponentPieces
		  select: [ :piece | piece attackingSquares includes: mySquare ]
		  thenCollect: [ :piece | piece -> piece square ]
]
