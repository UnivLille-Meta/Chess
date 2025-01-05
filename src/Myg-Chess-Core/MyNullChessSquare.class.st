Class {
	#name : 'MyNullChessSquare',
	#superclass : 'MyChessSquare',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'api - configuration' }
MyNullChessSquare >> down [  
    ^ self
]

{ #category : 'api - configuration' }
MyNullChessSquare >> hasPiece [  
    ^ false
]

{ #category : 'api - configuration' }
MyNullChessSquare >> highlightTarget [  
    ^''

]

{ #category : 'api - configuration' }
MyNullChessSquare >> isNullChessSquare [
	^true
]

{ #category : 'api - configuration' }
MyNullChessSquare >> left [
    ^ self
]

{ #category : 'api - configuration' }
MyNullChessSquare >> name [ 
    ^ 'Empty Square'
]

{ #category : 'api - configuration' }
MyNullChessSquare >> right [
    ^ self
]

{ #category : 'api - configuration' }
MyNullChessSquare >> unhighlightTarget [  
    ^''

]

{ #category : 'api - configuration' }
MyNullChessSquare >> up [  
    ^ self
]
