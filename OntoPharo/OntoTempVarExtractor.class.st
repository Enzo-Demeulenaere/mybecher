Class {
	#name : #OntoTempVarExtractor,
	#superclass : #OntoSymbolExtractor,
	#instVars : [
		'variables'
	],
	#category : #'OntoPharo-Extractors'
}

{ #category : #operations }
OntoTempVarExtractor >> extractSymbolOfMethod: aCompiledMethod [

	| visitor |
	visitor := OntoTempVarExtractorVisitor new.
	aCompiledMethod ast acceptVisitor: visitor.
	symbols addAll: visitor variables
]
