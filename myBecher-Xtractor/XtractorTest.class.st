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

{ #category : #accessing }
XtractorTest >> testSelectorFromMessage [
	| ext |
	ext := Xtractor new.
	ext scripting.
	ext textArea: (RubEditingArea new setTextWith: '10 between: 0 and: 1000'; yourself).
	
	self assert: ext findSelectorFromAST equals: #between:and:
]

{ #category : #accessing }
XtractorTest >> testSelectorFromMessageCodeMode [
	| ext |
	ext := Xtractor new.
	ext textArea: (RubEditingArea new setTextWith: '10 between: 0 and: 1000'; yourself).
	
	self assert: ext findSelectorFromAST equals: #between:and:
]

{ #category : #accessing }
XtractorTest >> testSelectorFromMessageScriptingMode [
	| ext |
	ext := Xtractor new.
	ext scripting.
	ext textArea: (RubEditingArea new setTextWith: '10 between: 0 and: 1000'; yourself).
	
	self assert: ext findSelectorFromAST equals: #between:and:
]

{ #category : #accessing }
XtractorTest >> testSelectorFromSelectorOnly [ 
	| ext |
	ext := Xtractor new.
	ext scripting.
	ext textArea: (RubEditingArea new setTextWith: 'printString'; yourself).
	
	self assert: ext findSelectorFromAST equals: #printString
]
