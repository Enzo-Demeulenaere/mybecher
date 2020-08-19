Class {
	#name : #XtractorTest,
	#superclass : #TestCase,
	#category : #'myBecher-Xtractor'
}

{ #category : #accessing }
XtractorTest >> testSelector [ 
	| ext |
	ext := Xtractor new.
	ext scripting.
	ext textArea: (RubEditingArea new setTextWith: 'printString'; yourself).
	
	self assert: ext findSelectorFromAST equals: #printString
]
