Class {
	#name : #DSDoubleLinkedListTest,
	#superclass : #TestCase,
	#category : #'myBecher-DS-DoubleLinkedList'
}

{ #category : #tests }
DSDoubleLinkedListTest >> testAdd [

	| dl |
	dl := DSDoubleLinkedList new.
	dl addFirst: 33.
	dl addFirst: 11.
	self assert: dl firstNode value equals: 11.
	self assert: dl firstNode next value equals: 33.
	
	self assert: dl firstNode next previous equals: dl firstNode.
	self assert: dl lastNode value equals: 33.
]

{ #category : #tests }
DSDoubleLinkedListTest >> testFirst [

	| dl |
	dl := DSDoubleLinkedList new.
	dl addFirst: 33.
	self assert: dl first equals: 33.

]

{ #category : #'tests - nodes' }
DSDoubleLinkedListTest >> testFirstNode [

	| dl |
	dl := DSDoubleLinkedList new.
	dl addFirstNode: (DSDoubleNode new value: 33); yourself.
	self assert: dl firstNode value equals: 33.
	
]

{ #category : #'tests - nodes' }
DSDoubleLinkedListTest >> testFirstNodeOfAnEmptyListShouldRaiseError [

	| dl |
	dl := DSDoubleLinkedList new.
	self should: [ dl firstNode ] raise: DSEmptyError
]

{ #category : #tests }
DSDoubleLinkedListTest >> testFirstOfEmptyShouldRaiseError [

	| dl |
	dl := DSDoubleLinkedList new.
	self should: [ dl first ] raise: DSEmptyError
]

{ #category : #tests }
DSDoubleLinkedListTest >> testIsEmpty [

	| dl |
	dl := DSDoubleLinkedList new.
	self assert: dl isEmpty
]

{ #category : #'tests - nodes' }
DSDoubleLinkedListTest >> testLastNodeOfAnEmptyListShouldRaiseError [

	| dl |
	dl := DSDoubleLinkedList new.
	self should: [ dl lastNode ] raise: DSEmptyError
]
