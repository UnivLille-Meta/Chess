Class {
	#name : 'MyRook',
	#superclass : 'MyPiece',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'accessing' }
MyRook >> id [
	^ 'R'
]

{ #category : 'rendering' }
MyRook >> renderPieceOn: aSquare [

	^ aSquare renderRook: self
]

{ #category : 'rendering' }
MyRook >> targetSquares [

	^ self upFile , self downFile , self leftFile , self rightFile
]

{ #category : 'rendering' }
MyRook >> targetSquaresLegal: aBoolean [

	^ (self upFileLegal: aBoolean) , (self downFileLegal: aBoolean)
	  , (self leftFileLegal: aBoolean) , (self rightFileLegal: aBoolean)
]

{ #category : 'rendering' }
MyRook >> targetSquaresLegalInCheck: aBoolean [
    "Retourne les cases légales pour la tour quand le roi est en échec.
     On part des moves normaux puis on garde seulement ceux qui
     capturent l'attaquant ou qui se placent sur le trajet attaquant=>roi."

    | king threats moves safeSquares up down left right |

    king := self ownKing.
    threats := king threateningPieces.

    threats isEmpty ifTrue: [ ^ self targetSquaresLegal: aBoolean ].
    (threats size > 1 and: [ self isKing not ]) ifTrue: [ ^ OrderedCollection new ].

    "Construction safe de moves"
    moves := OrderedCollection new.
    
    up := self upFileLegal: aBoolean.
    down := self downFileLegal: aBoolean. 
    left := self leftFileLegal: aBoolean.
    right := self rightFileLegal: aBoolean.
    
    up ifNotNil: [ moves addAll: up ].
    down ifNotNil: [ moves addAll: down ].
    left ifNotNil: [ moves addAll: left ].
    right ifNotNil: [ moves addAll: right ].

    "Filtrage"
    safeSquares := OrderedCollection new.
    moves do: [:sq |
        threats do: [:assoc |
            | attacker attackerSquare blocks captures |
            attacker := assoc key.
            attackerSquare := assoc value.
            blocks := self canBlockThreatFrom: attackerSquare to: king square on: sq.
            captures := sq = attackerSquare.
            
            (blocks or: [captures]) ifTrue: [
                safeSquares add: sq.
                Transcript show: 'AJOUT: ', sq name, 
                            ' (capture:', captures asString, 
                            ' block:', blocks asString, ')'; cr.
            ].
        ].
    ].

    Transcript show: 'Safe squares final: ', (safeSquares collect: [:sq | sq name]) asString; cr.
    ^ safeSquares
]
