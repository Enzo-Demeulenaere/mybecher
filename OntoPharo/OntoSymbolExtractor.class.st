Class {
	#name : #OntoSymbolExtractor,
	#superclass : #Object,
	#instVars : [
		'symbols'
	],
	#category : #'OntoPharo-Extractors'
}

{ #category : #initialize }
OntoSymbolExtractor >> initialize [ 

	super initialize.
	symbols := OrderedCollection new
]

{ #category : #initialize }
OntoSymbolExtractor >> symbols [

	^ symbols
]
