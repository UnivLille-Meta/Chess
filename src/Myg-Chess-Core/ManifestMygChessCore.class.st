"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : 'ManifestMygChessCore',
	#superclass : 'PackageManifest',
	#category : 'Myg-Chess-Core-Manifest',
	#package : 'Myg-Chess-Core',
	#tag : 'Manifest'
}

{ #category : 'code-critics' }
ManifestMygChessCore class >> ruleDeadBlockRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#MyPawn #forwardSquaresLegal #false)) #'2024-10-03T20:16:30.875+02:00') #(#(#RGMethodDefinition #(#MyPawn #targetSquaresLegal: #false)) #'2024-11-03T17:23:24.202+01:00') )
]

{ #category : 'code-critics' }
ManifestMygChessCore class >> ruleUnclassifiedMethodsRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#MyPawn #forwardSquaresLegal #false)) #'2024-10-03T20:16:38.195+02:00') #(#(#RGMethodDefinition #(#MyPawn #diagonalSquaresLegal #false)) #'2024-10-03T20:24:20.367+02:00') )
]
