Class {
	#name : 'DSCircularLinkedListTest',
	#superclass : 'TestCase',
	#category : 'myBecher-DS-CircularLinkedList',
	#package : 'myBecher-DS',
	#tag : 'CircularLinkedList'
}

{ #category : 'tests' }
DSCircularLinkedListTest >> testAdd [

	| ll |
	ll := DSCircularLinkedList new.
	ll add: 66.
	self assert: ll first equals: 66
]

{ #category : 'tests' }
DSCircularLinkedListTest >> testAddMore [

	| ll |
	ll := DSCircularLinkedList new.
	ll add: 66.
	self assert: ll first equals: 66.
	ll add: 77.
	self assert: ll first equals: 77.
	ll add: 88.
	self assert: ll first equals: 88.

]

{ #category : 'tests' }
DSCircularLinkedListTest >> testAddOnEmpty [

	| ll |
	ll := DSCircularLinkedList new.
	ll add: 66.
	self assert: ll first equals: 66.
	self assert: ll firstNode next value equals: 66.
]

{ #category : 'tests' }
DSCircularLinkedListTest >> testAdvance [

	| ll |
	ll := DSCircularLinkedList new.
	ll add: 66.
	ll add: 33.
	ll add: 11.
	self assert: ll first  equals: 11.
	ll advance.
	self assert: ll first equals: 33.
	ll add: 22.
	self assert: ll first equals: 22.
	self assert: ll firstNode next value equals: 33
	 
]

{ #category : 'tests' }
DSCircularLinkedListTest >> testFirstOnEmptyShouldBark [

	| ll |
	ll := DSCircularLinkedList new.
	self should: [ ll first ] raise: DSEmptyError
 
]

{ #category : 'tests' }
DSCircularLinkedListTest >> testIsEmpty [

	| ll |
	ll := DSCircularLinkedList new.
	self assert: ll isEmpty.
	ll add: 11.
	self deny: ll isEmpty.
]

{ #category : 'tests' }
DSCircularLinkedListTest >> testLast [

	| ll |
	ll := DSCircularLinkedList new.
	ll add: 66.
	ll add: 33.
	ll add: 11.
	self assert: ll firstNode value equals: 11.
	self assert: ll last equals: 66
 
]

{ #category : 'tests' }
DSCircularLinkedListTest >> testRemoveFirstMore [

	| ll |
	ll := DSCircularLinkedList new.
	ll add: 66.
	ll add: 33.
	ll add: 11.
	self assert: ll first equals: 11.
	self assert: ll firstNode next value equals: 33.
	self assert: ll firstNode next next value equals: 66.
	ll remove.
	
	self assert: ll first value equals: 33.
	self assert: ll firstNode next value equals: 66.
	
]
