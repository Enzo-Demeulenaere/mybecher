Class {
	#name : #XtractorTest,
	#superclass : #TestCase,
	#category : #'myBecher-Xtractor'
}

{ #category : #'tests - selected' }
XtractorTest >> testSelector [
	| ext |
	ext := Xtractor new.
	ext scripting.
	ext textArea: (RubEditingArea new setTextWith: 'printString'; yourself).
	
	self assert: ext selector equals: #printString
]

{ #category : #'tests - selected' }
XtractorTest >> testSelectorFromComplexMessage [
	| ext |
	ext := Xtractor new.
	ext scripting.
	ext textArea: (RubEditingArea new setTextWith: '(1 + 2) printString'; yourself).
	
	self assert: ext selector equals: #+
]

{ #category : #'tests - selected' }
XtractorTest >> testSelectorFromComplexMessage2 [
	| ext |
	ext := Xtractor new.
	ext scripting.
	ext textArea: (RubEditingArea new 
						setTextWith: '(1 + 2) printString';
						selectFrom: 9 to: 9; yourself).
	
	self assert: ext selector equals: #printString
]

{ #category : #'tests - selected' }
XtractorTest >> testSelectorFromMessage [
	| ext |
	ext := Xtractor new.
	ext scripting.
	ext textArea: (RubEditingArea new setTextWith: '1 printString'; yourself).
	
	self assert: ext selector equals: #printString
]

{ #category : #'tests - find selector from AST' }
XtractorTest >> testSelectorFromMessageCodeMode [
	| ext |
	ext := Xtractor new.
	ext textArea: (RubEditingArea new setTextWith: '10 between: 0 and: 1000'; yourself).
	
	self assert: ext findSelectorFromAST equals: #between:and:
]

{ #category : #'tests - find selector from AST' }
XtractorTest >> testSelectorFromMessageScriptingMode [
	| ext |
	ext := Xtractor new.
	ext scripting.
	ext textArea: (RubEditingArea new setTextWith: '10 between: 0 and: 1000'; yourself).
	
	self assert: ext findSelectorFromAST equals: #between:and:
]

{ #category : #'tests - find selector from AST' }
XtractorTest >> testSelectorFromSelectorOnly [ 
	| ext |
	ext := Xtractor new.
	ext scripting.
	ext textArea: (RubEditingArea new setTextWith: 'printString'; yourself).
	
	self assert: ext findSelectorFromAST equals: #printString
]
