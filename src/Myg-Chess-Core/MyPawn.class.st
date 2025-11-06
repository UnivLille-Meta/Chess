Class {
	#name : 'MyPawn',
	#superclass : 'MyPiece',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'rendering' }
MyPawn >> diagonalCaptureSquares [
    "Retourne les cases de capture diagonale du pion selon sa position actuelle"
    | board currentSquare captures col fileNumber |
    
    board := self board.
    currentSquare := self square.
    captures := OrderedCollection new.
    
    col := currentSquare column.
    fileNumber := currentSquare file asString asInteger.  
    
    self isWhite 
        ifTrue: [
            "Capture en haut à gauche"
            (board at: ((col asciiValue - 1) asCharacter asString , (fileNumber + 1) asString) ifAbsent: nil) ifNotNil: [ :sq | captures add: sq ].
            "Capture en haut à droite" 
            (board at: ((col asciiValue + 1) asCharacter asString , (fileNumber + 1) asString) ifAbsent: nil) ifNotNil: [ :sq | captures add: sq ].
        ]
        ifFalse: [
            "Capture en bas à gauche"
            (board at: ((col asciiValue - 1) asCharacter asString , (fileNumber - 1) asString) ifAbsent: nil) ifNotNil: [ :sq | captures add: sq ].
            "Capture en bas à droite"
            (board at: ((col asciiValue + 1) asCharacter asString , (fileNumber - 1) asString) ifAbsent: nil) ifNotNil: [ :sq | captures add: sq ].
        ].
    
    ^ captures
]

{ #category : 'accessing' }
MyPawn >> id [

	^ 'P'
]

{ #category : 'rendering' }
MyPawn >> renderPieceOn: aSquare [ 
	
	^ aSquare renderPawn: self
]

{ #category : 'rendering' }
MyPawn >> targetSquaresLegal: aBoolean [

	^ (self isWhite
		   ifTrue: [ { square up } ]
		   ifFalse: [ { square down } ]) select: [ :s |
		  s notNil and: [
			  s hasPiece not or: [ s contents color ~= color ] ] ]
]

{ #category : 'rendering' }
MyPawn >> targetSquaresLegalInCheck: aBoolean [
    | king threats moves safeSquares |

    king := self ownKing.
    threats := king threateningPieces.

    "Pas d'échec => mouvements normaux"
    threats isEmpty ifTrue: [ ^ self targetSquaresLegal: aBoolean ].
    
    "Double échec => seul le roi peut bouger"
    (threats size > 1 and: [ self isKing not ]) ifTrue: [ ^ OrderedCollection new ].

    "Moves normaux + captures diagonales"
    moves := OrderedCollection new.
    (self targetSquaresLegal: aBoolean) ifNotNil: [ moves addAll: (self targetSquaresLegal: aBoolean) ].
    (self diagonalCaptureSquares) ifNotNil: [ moves addAll: (self diagonalCaptureSquares) ].

    "Un pion ne peut que capturer l'attaquant, pas bloquer"
    safeSquares := moves select: [:sq |
        threats anySatisfy: [:assoc |
            | attacker attackerSquare |
            attacker := assoc key.
            attackerSquare := assoc value.
            sq = attackerSquare  "Seulement la capture directe"
        ]
    ].

    ^ safeSquares
]
