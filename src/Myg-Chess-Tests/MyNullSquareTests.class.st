Class {
	#name : 'MyNullSquareTests',
	#superclass : 'TestCase',
	#classVars : [
		'MyChessPiece'
	],
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyNullSquareTests >> testDown [ 
    | nullSquare |
    nullSquare := MyNullChessSquare new.

    self assert: (nullSquare down = nullSquare).
    
]

{ #category : 'tests' }
MyNullSquareTests >> testHasPiece [ 
    | nullSquare |
    nullSquare := MyNullChessSquare new.
    self deny: nullSquare hasPiece.
]

{ #category : 'tests' }
MyNullSquareTests >> testHighlightMethods [ 
    | nullSquare |
    nullSquare := MyNullChessSquare new.

    self assert: (nullSquare highlightTarget isEmpty).
    self assert: (nullSquare unhighlightTarget isEmpty).
]

{ #category : 'tests' }
MyNullSquareTests >> testIsNullChessSquare [ 
    | nullSquare |
    nullSquare := MyNullChessSquare new.
    self assert: nullSquare isNullChessSquare.
]

{ #category : 'tests' }
MyNullSquareTests >> testLeft [ 
    | nullSquare |
    nullSquare := MyNullChessSquare new.

    self assert: (nullSquare left = nullSquare).
    
]

{ #category : 'tests' }
MyNullSquareTests >> testName [ 
    | nullSquare |
    nullSquare := MyNullChessSquare new.
    self assert: (nullSquare name = 'Empty Square').
]

{ #category : 'tests' }
MyNullSquareTests >> testRight [ 
    | nullSquare |
    nullSquare := MyNullChessSquare new.

    self assert: (nullSquare right = nullSquare).
    
]

{ #category : 'tests' }
MyNullSquareTests >> testUp [ 
    | nullSquare |
    nullSquare := MyNullChessSquare new.

    self assert: (nullSquare up = nullSquare).
    
]
