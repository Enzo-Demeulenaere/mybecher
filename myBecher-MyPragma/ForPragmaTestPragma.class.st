"
ForPragmaTestPragma initialize
"
Class {
	#name : #ForPragmaTestPragma,
	#superclass : #AnnotationPragmaType,
	#category : #'myBecher-MyPragma-Test'
}

{ #category : #'as yet unclassified' }
ForPragmaTestPragma class >> declaredSelector [

	^ #forPragmaTest:withArg2:andArg3:
]
