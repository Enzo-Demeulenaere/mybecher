Class {
	#name : #Bexp,
	#superclass : #Object,
	#category : #'myBecher-Block'
}

{ #category : #initialization }
Bexp >> executeBlock: aBlock [
	| t |
	t := nil.
	aBlock value
]

{ #category : #initialization }
Bexp >> setVariableAndDefineBlock [
	"Bexp new setVariableAndDefineBlock >>> 42"

	| t |
	t := 42.
	self executeBlock: [ t traceCr ]
	
]

{ #category : #initialization }
Bexp >> setVariableAndDefineBlock2 [
	"Bexp new setVariableAndDefineBlock2 >>> 33"
	| t |
	t := 42.
	self executeBlock: [ t := 33. t traceCr ]
]
