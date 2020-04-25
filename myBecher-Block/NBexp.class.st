"
executeBlock: aBlock
	| t |
	t := nil.
	^ aBlock value
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

{ #category : #'6-self binding' }
NBexp >> executeBlock6 [
	^ String 	
			streamContents: [ :st | 
					self executeBlockInAnotherInstance6: [ st print: self ; print: x ].
					 ]
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

{ #category : #'1-variable lookup' }
NBexp >> setVariableAndDefineBlock [
	| t |
	t := 42.
	^ self executeBlock: [ t ]
]

{ #category : #'2-changing value' }
NBexp >> setVariableAndDefineBlock2 [
	| t |
	t := 42.
	^ self executeBlock: [ t := 2008. t ]
]

{ #category : #initialization }
NBexp >> setVariableAndDefineBlock3 [
	| t |
	t := 42.
	self executeBlock: [ t traceCr. t := 33. t traceCr ].
	self executeBlock: [ t traceCr. t := 66. t traceCr ].
	self executeBlock: [ t traceCr ]
]

{ #category : #initialization }
NBexp >> setVariableAndDefineBlock4 [
	
	^ String streamContents: [ :st |  
		| t |
		t := 42.
		block := [ st print: t ].
		t := 69.
		self executeBlock: block
]
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

{ #category : #'6-self binding' }
NBexp >> testExecuteBlockInAnotherInstance6 [
	
	self assert: self executeBlock6 equals: 'NBexp>>#testExecuteBlockInAnotherInstance6123'
]

{ #category : #'1-variable lookup' }
NBexp >> testSetVariableAndDefineBlock [

	self assert: self setVariableAndDefineBlock equals: 42
]

{ #category : #'2-changing value' }
NBexp >> testSetVariableAndDefineBlock2 [

	self assert: self setVariableAndDefineBlock2 equals: 2008
]

{ #category : #tests }
NBexp >> testSetVariableAndDefineBlock4 [

	self assert: self setVariableAndDefineBlock4 equals: '69'
]
