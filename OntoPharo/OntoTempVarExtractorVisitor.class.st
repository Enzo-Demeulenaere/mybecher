Class {
	#name : #OntoTempVarExtractorVisitor,
	#superclass : #RBProgramNodeVisitor,
	#instVars : [
		'variables'
	],
	#category : #'OntoPharo-Extractors'
}

{ #category : #initialization }
OntoTempVarExtractorVisitor >> initialize [

	super initialize.
	variables := OrderedCollection new
]

{ #category : #accessing }
OntoTempVarExtractorVisitor >> variables [

	^ variables
]

{ #category : #visiting }
OntoTempVarExtractorVisitor >> visitTemporaryNode: aNode [ 


	variables add: aNode name 
]
