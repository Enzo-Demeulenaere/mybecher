"
An OntoMessageSeparatorTest is a test class for testing the behavior of OntoMessageSeparator
"
Class {
	#name : #OntoMessageSeparatorTest,
	#superclass : #TestCase,
	#category : #'OntoPharo-Extractors'
}

{ #category : #'tests-operations' }
OntoMessageSeparatorTest >> testSplitPrefix [

	|test aWord res|
	
	aWord := 'testMessage'.
	test := OntoMessageSeparator  new.
	res := test splitPrefix: aWord.
	
	self assert: 'test' equals: res.
	
]

{ #category : #'tests-operations' }
OntoMessageSeparatorTest >> testSplitSuffix [


	|test aWord res|
	
	aWord := 'testMessage'.
	test := OntoMessageSeparator  new.
	res := test splitSuffix: aWord.
	
	self assert: 'Message' equals: res.
	
]

{ #category : #'tests-operations' }
OntoMessageSeparatorTest >> testUpperCasePositions [

	|test result|
	
	test := OntoMessageSeparator new.
	
	result := test upperCasePositions:  'helloWorld'.
	
	self assert: 6 equals: (result at: 1).
	
	
	
]
