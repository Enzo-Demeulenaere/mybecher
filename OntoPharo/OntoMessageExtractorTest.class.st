Class {
	#name : #OntoMessageExtractorTest,
	#superclass : #TestCase,
	#instVars : [
		'x',
		'y'
	],
	#category : #'OntoPharo-Tests'
}

{ #category : #tests }
OntoMessageExtractorTest >> testExtractMethodSymbols [

	| symbols |
	symbols := (OntoMessageExtractor new extractSymbolOfMethod: (OntoClassResources >> #degrees)) symbols.
	#(#asFloat  #arcTan #radiansToDegrees #ifTrue:ifFalse:)
		do: [ :each |  
				self assert: (symbols includes: each) ]
]

{ #category : #tests }
OntoMessageExtractorTest >> testExtractMethodSymbols2 [

	| symbols extractor|
	extractor := OntoMessageExtractor new.
	extractor setDefaultConstructsAsFilter. 
	extractor extractSymbolOfMethod: (OntoClassResources >> #adhereTo:).
	symbols := extractor symbols.
	#(#containsPoint: #max: #left min: right bottom)
		do: [ :each |  
				self assert: (symbols includes: each) ]
]

{ #category : #tests }
OntoMessageExtractorTest >> testExtractMethodSymbolsDoesNotIncludeClassLiteral [

	| symbols |
	symbols := (OntoMessageExtractor new extractSymbolOfMethod: (OntoClassResources >> #degrees)) symbols.
	self deny: (symbols includes: #OntoClassResources)
]

{ #category : #tests }
OntoMessageExtractorTest >> testExtractMethodSymbolsFilterCommonsConstructs [

	| extractor | 
	extractor := OntoMessageExtractor new. 
	extractor setDefaultConstructsAsFilter.
	extractor extractSymbolOfMethod: (OntoClassResources >> #degrees).
	extractor filter.
	self deny: (extractor symbols includes: #ifTrue:ifFalse:).
]

{ #category : #tests }
OntoMessageExtractorTest >> testExtractMethodSymbolsFilterOneConstruct [

	| extractor | 
	extractor := OntoMessageExtractor new. 
	extractor setFilterConstructs: #(ifTrue:ifFalse:).
	extractor extractSymbolOfMethod: (OntoClassResources >> #degrees).
	extractor filter.
	self deny: (extractor symbols includes: #ifTrue:ifFalse:).
]

{ #category : #tests }
OntoMessageExtractorTest >> testExtractMethods [

	| symbols extractor|
	extractor := OntoMessageExtractor new.
	extractor setDefaultConstructsAsFilter. 

	extractor extractSymbolOfMethods: {(OntoClassResources >> #adhereTo:). (OntoClassResources >> #degrees)}.
	symbols := extractor symbols.
	#(#containsPoint: #max: #left min: right bottom #asFloat  #arcTan #radiansToDegrees)
		do: [ :each |  
				self assert: (symbols includes: each) ]
]
