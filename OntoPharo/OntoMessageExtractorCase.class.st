Class {
	#name : #OntoMessageExtractorCase,
	#superclass : #TestCase,
	#instVars : [
		'x',
		'y'
	],
	#category : #'OntoPharo-Extractors'
}

{ #category : #tests }
OntoMessageExtractorCase >> testExtractMethodSymbols [

	| symbols |
	symbols := (OntoMessageExtractor new extractSymbolOfMethod: (OntoClassResources >> #degrees)) symbols.
	#(#asFloat  #arcTan #radiansToDegrees #ifTrue:ifFalse: #degrees)
		do: [ :each |  
				self assert: (symbols includes: each) ]
]

{ #category : #tests }
OntoMessageExtractorCase >> testExtractMethodSymbols2 [

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
OntoMessageExtractorCase >> testExtractMethodSymbolsDoesNotIncludeClassLiteral [

	| symbols |
	symbols := (OntoMessageExtractor new extractSymbolOfMethod: (OntoClassResources >> #degrees)) symbols.
	self deny: (symbols includes: #OntoClassResources)
]

{ #category : #tests }
OntoMessageExtractorCase >> testExtractMethodSymbolsFilterCommonsConstructs [

	| extractor | 
	extractor := OntoMessageExtractor new. 
	extractor setDefaultConstructsAsFilter.
	extractor extractSymbolOfMethod: (OntoClassResources >> #degrees).
	extractor filter.
	self deny: (extractor symbols includes: #ifTrue:ifFalse:).
]

{ #category : #tests }
OntoMessageExtractorCase >> testExtractMethodSymbolsFilterOneConstruct [

	| extractor | 
	extractor := OntoMessageExtractor new. 
	extractor setFilterConstructs: #(ifTrue:ifFalse:).
	extractor extractSymbolOfMethod: (OntoClassResources >> #degrees).
	extractor filter.
	self deny: (extractor symbols includes: #ifTrue:ifFalse:).
]

{ #category : #tests }
OntoMessageExtractorCase >> testExtractMethods [

	| symbols extractor|
	extractor := OntoMessageExtractor new.
	extractor setDefaultConstructsAsFilter. 

	extractor extractSymbolOfMethods: {(OntoClassResources >> #adhereTo:). (OntoClassResources >> #degrees)}.
	symbols := extractor symbols.
	#(#containsPoint: #max: #left min: right bottom #asFloat  #arcTan #radiansToDegrees #degrees)
		do: [ :each |  
				self assert: (symbols includes: each) ]
]
