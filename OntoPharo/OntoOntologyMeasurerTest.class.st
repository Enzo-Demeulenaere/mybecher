Class {
	#name : #OntoOntologyMeasurerTest,
	#superclass : #TestCase,
	#category : #'OntoPharo-Ontology'
}

{ #category : #tests }
OntoOntologyMeasurerTest >> testHammingDistanceOf [

	 |var test|
	
	test := OntoOntologyMeasurer new.
	var := test hammingDistanceOf: '1011101' with: '1001001'.
	
	self assert:  var equals: 2 
	
]

{ #category : #tests }
OntoOntologyMeasurerTest >> testLevenshteinDistanceOf [

	 |var test|
	
	test := OntoOntologyMeasurer new.
	var := test levenshteinDistanceOf: 'test' with: 'tent'.
	
	self assert:  var equals: 1 
	
]
