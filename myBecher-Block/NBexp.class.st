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
		'block'
	],
	#category : #'myBecher-Block'
}

{ #category : #initialization }
NBexp >> executeBlock: aBlock [
	| t |
	t := nil.
	^ aBlock value
]

{ #category : #initialization }
NBexp >> setVariableAndDefineBlock [
	| t |
	t := 42.
	^ self executeBlock: [ t traceCr ]
]

{ #category : #initialization }
NBexp >> setVariableAndDefineBlock2 [
	| t |
	t := 42.
	^ self executeBlock: [ t := 33. t traceCr ]
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
NBexp >> setVariableAndDefineBlock3b [
	| t |
	^ String streamContents: [ :st |  
		t := 42.
		self executeBlock: [ st print: t. st cr. t := 33. st print: t. st cr ].
		self executeBlock: [ st print: t. st cr. t := 66. st print: t. st cr. ].
		self executeBlock: [ st print: t. st cr. ]
		 ]
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

{ #category : #tests }
NBexp >> testSetVariableAndDefineBlock [

	self assert: self setVariableAndDefineBlock equals: 42
]

{ #category : #tests }
NBexp >> testSetVariableAndDefineBlock2 [

	self assert: self setVariableAndDefineBlock2 equals: 33
]

{ #category : #tests }
NBexp >> testSetVariableAndDefineBlock3b [

	self assert: self setVariableAndDefineBlock3b equals: '42
33
33
66
66
'
]

{ #category : #tests }
NBexp >> testSetVariableAndDefineBlock4 [

	self assert: self setVariableAndDefineBlock4 equals: '69'
]
