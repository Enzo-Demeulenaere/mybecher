Class {
	#name : #DSDoubleNodeTest,
	#superclass : #TestCase,
	#category : #'myBecher-DS-DoubleLinkedList'
}

{ #category : #tests }
DSDoubleNodeTest >> testPrintNil [

	| node | 
	node := DSDoubleNode new.
	node value: 33.
	
	self assert: node printString equals: 'a DSDoubleNode~33~'
]
