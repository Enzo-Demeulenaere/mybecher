Class {
	#name : #OntoTempVariableExtractorTest,
	#superclass : #TestCase,
	#category : #'OntoPharo-Tests'
}

{ #category : #tests }
OntoTempVariableExtractorTest >> testExtractMethodSymbols [

	| symbols extractor|
	extractor := OntoTempVarExtractor new.
	extractor extractSymbolOfMethod: (OntoClassResources >> #degrees).
	symbols := extractor symbols.
	#(#tan theta)
		do: [ :each |  
				self assert: (symbols includes: each) ]
]
