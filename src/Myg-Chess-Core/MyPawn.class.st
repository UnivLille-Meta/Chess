Class {
	#name : 'MyPawn',
	#superclass : 'MyPiece',
	#instVars : [
		'hasMoved',
		'enPassantTarget'
	],
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'accessing' }
MyPawn >> captureMoves [ 
    | forwardDirection captureMoves |

    forwardDirection := self forwardDirection.

    "Calcul des cases diagonales pour les captures"
    captureMoves := {
        (self square + (-1 @ forwardDirection)).
        (self square + (1 @ forwardDirection)) }.

    "Filtrer uniquement les cases capturables"
    captureMoves := captureMoves select: [ :s |
        s isNullChessSquare not and: [
            s hasPiece and: [ s contents color ~= self color ] ] ].

    ^ captureMoves

]

{ #category : 'initialization' }
MyPawn >> enPassantTargetSquares [
	| enPassantMoves lastMove enemySquare targetSquare |
    
	"Obtain the last move and handle cases where it might be nil"
    lastMove := square board game lastMove ifNil: [ MyNullChessSquare new ].

	 "Check if enPassantTarget is valid"
    (enPassantTarget isNullChessSquare) ifFalse: [ ^ OrderedCollection with: enPassantTarget ].

    enPassantMoves := OrderedCollection new.

    lastMove := square board game lastMove.

   ((lastMove isKindOf: MyMove) and: [ lastMove endSquare isNullChessSquare not ]) ifTrue: [
        (lastMove piece isPawn
            and: ([ (lastMove startSquare file asInteger - lastMove endSquare file asInteger) abs = 2 ]))
					ifTrue: [
						self isInTheGoodLineForEnPassant 
						ifTrue: [  
                enemySquare := lastMove endSquare.
                (self square columnDifference: enemySquare) abs = 1
                    ifTrue: [
                        targetSquare := (self isWhite
                            ifTrue: [ enemySquare up ]
                            ifFalse: [ enemySquare down ]).
                        enPassantTarget := targetSquare. "Stocker la case pour un accès ultérieur"
                        enPassantMoves add: targetSquare.
                    ].
					].
            ].
    ].
    ^ enPassantMoves
]

{ #category : 'accessing' }
MyPawn >> forwardDirection [ 
    ^ self isWhite
        ifTrue: [ 1 ]
        ifFalse: [ -1 ]

]

{ #category : 'accessing' }
MyPawn >> forwardMoves [ 
    | forwardMoves nextSquare |

    forwardMoves := OrderedCollection new.

    "Vérifie la case directement devant"
    nextSquare := self isWhite
                      ifTrue: [ self square up ]
                      ifFalse: [ self square down ].

    "Ajoute la première case si elle est libre"
    (nextSquare isNullChessSquare not and: [ nextSquare hasPiece not ]) ifTrue: [
        forwardMoves add: nextSquare.

        "Vérifie le double mouvement initial seulement si la première case est libre"
        self hasMoved ifFalse: [
            nextSquare := self isWhite
                              ifTrue: [ nextSquare up ]
                              ifFalse: [ nextSquare down ].
            (nextSquare isNullChessSquare not and: [ nextSquare hasPiece not ]) ifTrue: [
                forwardMoves add: nextSquare ] ] ].

    ^ forwardMoves

]

{ #category : 'accessing' }
MyPawn >> hasMoved [ 
	^ hasMoved 
]

{ #category : 'accessing' }
MyPawn >> hasMoved: aBoolean [ 
	hasMoved := aBoolean 
]

{ #category : 'accessing' }
MyPawn >> id [

	^ 'P'
]

{ #category : 'initialization' }
MyPawn >> initialize [ 
	super initialize.
	hasMoved := false.
	enPassantTarget := MyNullChessSquare new.
]

{ #category : 'initialization' }
MyPawn >> isInTheGoodLineForEnPassant [ 
	^ self isWhite 
		ifTrue: [ square file = $5 ] 
		ifFalse: [ square file = $4 ] 
]

{ #category : 'initialization' }
MyPawn >> isPawn [ 
    ^ true

]

{ #category : 'accessing' }
MyPawn >> moveTo: aSquare [
    | enPassantTargetSquare |

    "Vérifie si le mouvement est légal avant de procéder"
    ((self targetSquaresLegal: true) includes: aSquare) ifFalse: [ ^ self ].

    "Détermine si le déplacement correspond à une capture en passant"
    enPassantTargetSquare := (self enPassantTargetSquares includes: aSquare)
        ifTrue: [
            "Si la capture en passant est possible, détermine la nouvelle position"
            self isWhite
                ifTrue: [aSquare down] 
                ifFalse: [aSquare up].
        ].

    "Effectue la capture en passant si une cible a été déterminée"
    enPassantTargetSquare := enPassantTargetSquare ifNil: [ MyNullChessSquare new ].
    enPassantTargetSquare isNullChessSquare ifFalse: [
        enPassantTargetSquare emptyContents. "Vide le contenu de la case capturée"
    ].

    "Effectue le déplacement du pion vers la case cible"
    super moveTo: aSquare.

    "Réinitialise la cible de capture en passant après le déplacement"
    enPassantTarget := MyNullChessSquare new.
    hasMoved := true.


]

{ #category : 'rendering' }
MyPawn >> renderPieceOn: aSquare [ 
	
	^ aSquare renderPawn: self
]

{ #category : 'rendering' }
MyPawn >> targetSquaresLegal: aBoolean [
    | forwardMoves captureMoves enPassant |

    "Obtenir les mouvements en avant"
    forwardMoves := self forwardMoves.

    "Obtenir les mouvements de capture"
    captureMoves := self captureMoves.

	enPassant := MyNullChessSquare new.

    "Obtenir les mouvements en passant, calculé une seule fois si nécessaire"
    enPassant := enPassant isNullChessSquare 
    ifTrue: [ self enPassantTargetSquares ].


    "Combiner les trois types de mouvements"
    ^ captureMoves , forwardMoves , enPassant

]
