Class {
	#name : #OntoTempVariableExtractorCase,
	#superclass : #TestCase,
	#category : #'OntoPharo-Extractors'
}

{ #category : #tests }
OntoTempVariableExtractorCase >> testExtractMethodSymbols [

	| symbols extractor|
	extractor := OntoTempVarExtractor new.
	extractor extractSymbolOfMethod: (OntoClassResources >> #degrees).
	symbols := extractor symbols.
	#(#tan theta)
		do: [ :each |  
				self assert: (symbols includes: each) ]
]
