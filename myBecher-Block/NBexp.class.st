"
NBexp >> #blockLocalTemp


CompilationContext bytecodeBackend: EncoderForSistaV1.
CompilationContext optionFullBlockClosure: true.
NBexp recompile: #blockLocalTemp.
(NBexp >> #blockLocalTemp) inspect


blockLocalTemp
	| collection |
	collection := OrderedCollection new.
	#(1 2 3) do: [ :index |
		| temp |
		temp := index.
		collection add: [ temp ] ].
	^ collection collect: [ :each | each value ]
"
Class {
	#name : #NBexp,
	#superclass : #TestCase,
	#instVars : [
		'block',
		'x'
	],
	#category : #'myBecher-Block'
}

{ #category : #'3-accessing shared variables' }
NBexp >> accessingSharedVariables [
	| t |
	^ String streamContents: [ :st |  
		t := 42.
		self executeBlock: [ st print: t. st cr. t := 99. st print: t. st cr ].
		self executeBlock: [ st print: t. st cr. t := 66. st print: t. st cr. ].
		self executeBlock: [ st print: t. st cr. ]
		 ]
]

{ #category : #'7-block allocation' }
NBexp >> blockLocalTemp [
	| collection |
	collection := OrderedCollection new.
	#(1 2 3) do: [ :index |
		| temp |
		temp := index.
		collection add: [ temp ] ].
	^ collection collect: [ :each | each value ]
]

{ #category : #'7-block allocation' }
NBexp >> blockLocalTemp2 [
	"self new blockLocalTemp2"
	| collection |
	collection := OrderedCollection new.
	#(1 2 3) do: [ :index |
		| temp bloc context |
		temp := index.
		bloc := [ temp ].
		index = 2 ifTrue: [ context := thisContext copy. self halt. ].
		"why when I look at the context it is nil?
		It should not be the context of the [temp] definition because we are a bit after 
		but I do not get why it is nil."
		collection add: [ temp ] ].
	^ collection collect: [ :each | each value ]
]

{ #category : #'7-block allocation' }
NBexp >> blockOutsideTemp [
	| collection temp |
	collection := OrderedCollection new.
	#(1 2 3) do: [ :index | 
		temp := index.
		collection add: [ temp ] ].
	^ collection collect: [ :each | each value ]
]

{ #category : #'1-variable lookup' }
NBexp >> executeBlock: aBlock [
	| t |
	t := 33.
	^ aBlock value
]

{ #category : #'5-arguments' }
NBexp >> executeBlockAndIgnoreArgument: arg [
	^ block value
]

{ #category : #'6-self binding' }
NBexp >> executeBlockInAnotherInstance6: aBlock [
	^ NBexp2 new executeBlockInAnotherInstance6: aBlock
]

{ #category : #initialization }
NBexp >> initialize [
	x := 123.
]

{ #category : #'6-self binding' }
NBexp >> selfIsCapturedToo [
	^ String 	
			streamContents: [ :st | 
					self executeBlockInAnotherInstance6: [ st print: self ; print: x ] ]
]

{ #category : #'2-changing value' }
NBexp >> setVariableAndChangingVariableBlock [
	| t |
	t := 42.
	^ self executeBlock: [ t := 2008. t ]
]

{ #category : #'1-variable lookup' }
NBexp >> setVariableAndDefineBlock [
	| t |
	t := 42.
	^ self executeBlock: [ t ]
]

{ #category : #'3-accessing shared variables' }
NBexp >> testAccessingSharedVariables [

	self assert: self accessingSharedVariables equals: '42
99
99
66
66
'
]

{ #category : #'5-arguments' }
NBexp >> testArg5 [

	self assert: (self testArg5: 'foo') equals: 'foo'
]

{ #category : #'5-arguments' }
NBexp >> testArg5: arg [
	^ String streamContents: [ :st |  
		block := [ st << arg ].
		self executeBlockAndIgnoreArgument: 'zork']
]

{ #category : #'7-block allocation' }
NBexp >> testBlockLocalTemp [
	
	self assert: self blockLocalTemp asArray equals: #(1 2 3)
]

{ #category : #'7-block allocation' }
NBexp >> testBlockOutsideTemp [
	
	self assert: self blockOutsideTemp asArray equals: #(3 3 3)
]

{ #category : #'6-self binding' }
NBexp >> testSelfIsCapturedToo [
	
	self assert: self selfIsCapturedToo equals: 'NBexp>>#testSelfIsCapturedToo123'
]

{ #category : #'2-changing value' }
NBexp >> testSetVariableAndChangingVariableBlock [

	self assert: self setVariableAndChangingVariableBlock equals: 2008
]

{ #category : #'1-variable lookup' }
NBexp >> testSetVariableAndDefineBlock [

	self assert: self setVariableAndDefineBlock equals: 42
]

{ #category : #'4-lookup at execution time' }
NBexp >> testVariableLookupIsDoneAtExecution [

	self assert: self variableLookupIsDoneAtExecution equals: '69'
]

{ #category : #'4-lookup at execution time' }
NBexp >> variableLookupIsDoneAtExecution [
	
	^ String streamContents: [ :st |  
		| t |
		t := 42.
		block := [ st print: t ].
		t := 69.
		self executeBlock: block ]
]
