Class {
	#name : #OntoClassExtractor,
	#superclass : #OntoSymbolExtractor,
	#instVars : [
		'classes'
	],
	#category : #'OntoPharo-Extractors'
}

{ #category : #operations }
OntoClassExtractor >> extractSymbolOfClass: aCompiledClass [

	| visitor |
	visitor := OntoTempVarExtractorVisitor new.
	aCompiledClass ast acceptVisitor: visitor.
	symbols addAll: visitor variables
]
