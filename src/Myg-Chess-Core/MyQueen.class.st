Class {
	#name : 'MyQueen',
	#superclass : 'MyPiece',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'rendering' }
MyQueen >> renderPieceOn: aSquare [

	^ aSquare renderQueen: self
]

{ #category : 'rendering' }
MyQueen >> targetSquaresLegal: aBoolean [

	| likeABishop likeARook |
	likeABishop := (self upRightDiagonalLegal: aBoolean)
	               , (self upLeftDiagonalLegal: aBoolean)
	               , (self downRightDiagonalLegal: aBoolean)
	               , (self downLeftDiagonalLegal: aBoolean).
	likeARook := (self upFileLegal: aBoolean)
	             , (self downFileLegal: aBoolean)
	             , (self leftFileLegal: aBoolean)
	             , (self rightFileLegal: aBoolean).
	^ likeABishop , likeARook
]

{ #category : 'rendering' }
MyQueen >> targetSquaresLegalInCheck: aBoolean [
    | king threats moves safeSquares likeBishop likeRook |

    king := self ownKing.
    threats := king threateningPieces.

    threats isEmpty ifTrue: [ ^ self targetSquaresLegal: aBoolean ].
    (threats size > 1 and: [ self isKing not ]) ifTrue: [ ^ OrderedCollection new ].

    "Récupérer tous les moves de la reine"
    moves := OrderedCollection new.
    
    "Moves comme un fou (diagonales)"
    likeBishop := (self upRightDiagonalLegal: aBoolean) 
        , (self upLeftDiagonalLegal: aBoolean)
        , (self downRightDiagonalLegal: aBoolean) 
        , (self downLeftDiagonalLegal: aBoolean).
    likeBishop ifNotNil: [ moves addAll: likeBishop ].
    
    "Moves comme une tour (lignes droites)"
    likeRook := (self upFileLegal: aBoolean)
        , (self downFileLegal: aBoolean)
        , (self leftFileLegal: aBoolean)
        , (self rightFileLegal: aBoolean).
    likeRook ifNotNil: [ moves addAll: likeRook ].

    safeSquares := moves select: [:sq |
        threats anySatisfy: [:assoc |
            | attacker attackerSquare |
            attacker := assoc key.
            attackerSquare := assoc value.
            
            sq = attackerSquare
            or: [ self canBlockThreatFrom: attackerSquare to: king square on: sq ]
        ]
    ].

    ^ safeSquares
]
