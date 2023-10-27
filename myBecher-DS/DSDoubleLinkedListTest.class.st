Class {
	#name : #DSDoubleLinkedListTest,
	#superclass : #TestCase,
	#category : #'myBecher-DS-DoubleLinkedList'
}

{ #category : #tests }
DSDoubleLinkedListTest >> testInitialize [

	| dl |
	dl := DSDoubleLinkedList new.
	self assert: dl firstNode next equals: dl lastNode.
	self assert: dl lastNode previous equals: dl firstNode.
]

{ #category : #tests }
DSDoubleLinkedListTest >> testIsEmpty [

	| dl |
	dl := DSDoubleLinkedList new.
	self assert: dl isEmpty
]
