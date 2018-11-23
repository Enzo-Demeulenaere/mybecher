Class {
	#name : #OntoMessageExtractor,
	#superclass : #OntoSymbolExtractor,
	#instVars : [
		'filteredConstructs'
	],
	#classVars : [
		'DefaultContructs'
	],
	#category : #'OntoPharo-Extractors'
}

{ #category : #initialization }
OntoMessageExtractor class >> initialize [
	
	self setDefaultContructs
]

{ #category : #initialization }
OntoMessageExtractor class >> setDefaultContructs [
	"self setDefaultContructs"

	DefaultContructs := #(ifTrue: ifFalse: do: select: ifTrue:ifFalse: ifFalse:ifTrue: whileTrue: whileFalse: to:do: add: to:by:do:).
]

{ #category : #operations }
OntoMessageExtractor >> extractSymbolOfMethod: aCompiledMethod [
	
	| mClassSymbol literals|
	mClassSymbol := aCompiledMethod methodClass name asSymbol. 
	literals := aCompiledMethod literals reject: [ :each | each = mClassSymbol ].
	symbols addAll: (literals select: [ :each | each isSymbol ])
	
]

{ #category : #operations }
OntoMessageExtractor >> extractSymbolOfMethods: aCollection [
	
	aCollection do: [ :each | self extractSymbolOfMethod: each ]
	
]

{ #category : #operations }
OntoMessageExtractor >> filter [

	| res |
	res := OrderedCollection new. 
	symbols do: [ :each |  
		(filteredConstructs includes: each)
			ifFalse: [ res add: each ]]. 
	symbols := res.
	
]

{ #category : #accessing }
OntoMessageExtractor >> setDefaultConstructsAsFilter [

	self setFilterConstructs: DefaultContructs
]

{ #category : #accessing }
OntoMessageExtractor >> setFilterConstructs: aCollection [ 
	filteredConstructs := aCollection
]
