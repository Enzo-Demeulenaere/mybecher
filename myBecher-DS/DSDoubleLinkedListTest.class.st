Class {
	#name : #DSDoubleLinkedListTest,
	#superclass : #TestCase,
	#category : #'myBecher-DS-DoubleLinkedList'
}

{ #category : #'tests - adding' }
DSDoubleLinkedListTest >> testAddBeforeNode [

	| dl  |
	dl := DSDoubleLinkedList new.
	dl addFirst: 66.
	dl add: 33 beforeNode: dl firstNode.
	self assert: dl firstNode value equals: 33.
	self assert: dl firstNode next value equals: 66.
	self assert: dl firstNode next previous value equals: 33.
	self assert: dl lastNode value equals: 66.
	self assert: dl lastNode previous value equals: 33.
	
	
]

{ #category : #'tests - adding' }
DSDoubleLinkedListTest >> testAddFirst [

	| dl |
	dl := DSDoubleLinkedList new.
	dl addFirst: 33.
	dl addFirst: 11.
	self assert: dl firstNode value equals: 11.
	self assert: dl firstNode next value equals: 33.
	
	self assert: dl firstNode next previous equals: dl firstNode.
	self assert: dl lastNode value equals: 33.
]

{ #category : #'tests - adding' }
DSDoubleLinkedListTest >> testAddFirst2 [

	| dl |
	dl := DSDoubleLinkedList new.
	dl addFirst2: 33.
	dl addFirst2: 11.
	self assert: dl firstNode value equals: 11.
	self assert: dl firstNode next value equals: 33.
	
	self assert: dl firstNode next previous equals: dl firstNode.
	self assert: dl lastNode value equals: 33.
]

{ #category : #'tests - adding' }
DSDoubleLinkedListTest >> testAddFirstNode [

	| dl node node1 |
	dl := DSDoubleLinkedList new.
	node := DSDoubleNode new value: 33.
	node1 := DSDoubleNode new value: 11. 
	dl addFirstNode: node.
	dl addFirstNode: node1 .
	self assert: dl firstNode value equals: 11.
	self assert: dl firstNode next value equals: 33.
	
	self assert: dl firstNode next previous equals: dl firstNode.
	self assert: dl lastNode value equals: 33.
]

{ #category : #'tests - adding' }
DSDoubleLinkedListTest >> testAddLast [

	| dl |
	dl := DSDoubleLinkedList new.
	dl addLast: 66.
	self assert: dl lastNode value equals: 66.
	self assert: dl lastNode previous next value equals: 66.

]

{ #category : #'tests - adding' }
DSDoubleLinkedListTest >> testAddLastNode [

	| dl node node1 |
	dl := DSDoubleLinkedList new.
	node := DSDoubleNode new value: 33.
	node1 := DSDoubleNode new value: 11. 
	dl addLastNode: node.
	self assert: dl firstNode value equals: 33.
	self assert: dl lastNode value equals: 33.
	
	dl addLastNode: node1.
	self assert: dl lastNode value equals: 11.
	self assert: dl lastNode == node1.
	
	self assert: dl firstNode value equals: 33.
	self assert: dl firstNode next value equals: 11.
	
	
	
	self assert: dl firstNode next previous equals: dl firstNode.
	self assert: dl lastNode value equals: 11.
]

{ #category : #'tests - adding' }
DSDoubleLinkedListTest >> testAddLastWithExistingNode [

	| dl |
	dl := DSDoubleLinkedList new.
	dl addFirst: 33.
	dl addFirst: 11.
	
	dl addLast: 66.
	self assert: dl lastNode value equals: 66.
	self assert: dl lastNode previous next value equals: 66.
	self assert: dl lastNode previous value equals: 33.
	
]

{ #category : #'tests - accessing' }
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

{ #category : #'tests - accessing' }
DSDoubleLinkedListTest >> testFirstOfEmptyShouldRaiseError [

	| dl |
	dl := DSDoubleLinkedList new.
	self should: [ dl first ] raise: DSEmptyError
]

{ #category : #'tests - accessing' }
DSDoubleLinkedListTest >> testIsEmpty [

	| dl |
	dl := DSDoubleLinkedList new.
	self assert: dl isEmpty
]

{ #category : #'tests - accessing' }
DSDoubleLinkedListTest >> testLast [

	| dl |
	dl := DSDoubleLinkedList new.
	dl addFirst: 33.
	self assert: dl last equals: 33.

]

{ #category : #'tests - nodes' }
DSDoubleLinkedListTest >> testLastNodeOfAnEmptyListShouldRaiseError [

	| dl |
	dl := DSDoubleLinkedList new.
	self should: [ dl lastNode ] raise: DSEmptyError
]

{ #category : #'tests - accessing' }
DSDoubleLinkedListTest >> testLastOfEmptyShouldRaiseError [

	| dl |
	dl := DSDoubleLinkedList new.
	self should: [ dl last ] raise: DSEmptyError
]

{ #category : #'tests - removing' }
DSDoubleLinkedListTest >> testRemoveFirst [

	| dl |
	dl := DSDoubleLinkedList new.
	dl addFirst: 99.
	dl addFirst: 66.
	dl addFirst: 33.
	dl removeFirst.
	
	self assert: dl firstNode value equals: 66.
	self assert: dl firstNode next value equals: 99.
]

{ #category : #'tests - removing' }
DSDoubleLinkedListTest >> testRemoveFirstOnEmptyShouldBark [

	| dl |
	dl := DSDoubleLinkedList new.
	self should: [ dl removeFirst ] raise: DSEmptyError.
	
]

{ #category : #'tests - removing' }
DSDoubleLinkedListTest >> testRemoveLast [

	| dl |
	dl := DSDoubleLinkedList new.
	dl addFirst: 99.
	dl addFirst: 66.
	dl addFirst: 33.
	dl removeLast.
	self assert: dl size equals: 2.
	self assert: dl firstNode value equals: 33.
	self assert: dl firstNode next value equals: 66.
]

{ #category : #'tests - removing' }
DSDoubleLinkedListTest >> testRemoveLastOnEmptyShouldBark [

	| dl |
	dl := DSDoubleLinkedList new.
	self should: [ dl removeLast ] raise: DSEmptyError 
]

{ #category : #'tests - removing' }
DSDoubleLinkedListTest >> testRemoveNode [

	| dl |
	dl := DSDoubleLinkedList new.
	dl addFirst: 99.
	dl addFirst: 66.
	dl addFirst: 33.
	self assert: dl size equals: 3.
	self assert: dl firstNode next value equals: 66.
	dl removeNode: dl firstNode next. 
	self assert: dl size equals: 2.
	
	self assert: dl firstNode value equals: 33.
	self assert: dl firstNode next value equals: 99.
]

{ #category : #'tests - adding' }
DSDoubleLinkedListTest >> testSize [

	| dl |
	dl := DSDoubleLinkedList new.
	self assert: dl size equals: 0
	

]

{ #category : #'tests - adding' }
DSDoubleLinkedListTest >> testSizeNonEmpty [

	| dl |
	dl := DSDoubleLinkedList new.
	dl addFirst: 33.
	dl addFirst: 11.
	self assert: dl size equals: 2
]
