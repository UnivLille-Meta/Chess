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
ManifestMygChessCore class >> ruleLongMethodsRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGClassDefinition #(#MyPawn)) #'2024-10-04T09:52:35.393+01:00') )
]

{ #category : 'code-critics' }
ManifestMygChessCore class >> ruleReInstanceSideInitializeMethodProtocolRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#MyPawn #initialize #false)) #'2025-01-04T23:03:26.217+01:00') )
]

{ #category : 'code-critics' }
ManifestMygChessCore class >> ruleReNoNilAssignationInInitializeRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#MyPawn #initialize #false)) #'2025-01-04T23:03:22.762+01:00') )
]

{ #category : 'code-critics' }
ManifestMygChessCore class >> ruleSentNotImplementedRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#MyPawn #enPassantTargetSquares #false)) #'2025-01-04T23:04:38.408+01:00') )
]

{ #category : 'code-critics' }
ManifestMygChessCore class >> ruleStringConcatenationRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#MyChessGame #recordMovementOf:to: #false)) #'2025-01-04T23:02:08.183+01:00') )
]

{ #category : 'code-critics' }
ManifestMygChessCore class >> ruleUnaryAccessingMethodWithoutReturnRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#MyPawn #initialize #false)) #'2025-01-04T23:03:29.183+01:00') )
]

{ #category : 'code-critics' }
ManifestMygChessCore class >> ruleUnclassifiedMethodsRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#MyChessSquare #columnDifference: #false)) #'2025-01-04T23:06:08.098+01:00') )
]
