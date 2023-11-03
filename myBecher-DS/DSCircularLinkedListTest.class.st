Class {
	#name : #DSCircularLinkedListTest,
	#superclass : #TestCase,
	#category : #'myBecher-DS-CircularLinkedList'
}

{ #category : #tests }
DSCircularLinkedListTest >> testAdd [

	| ll |
	ll := DSCircularLinkedList new.
	ll add: 66.
	self assert: ll first equals: 66
]

{ #category : #tests }
DSCircularLinkedListTest >> testAddFirst [

	| ll |
	ll := DSCircularLinkedList new.
	ll addFirst: 33.
	self deny: ll isEmpty.
	self assert: ll cursor value equals: 33
	 
]

{ #category : #tests }
DSCircularLinkedListTest >> testAddFirstMore [

	| ll |
	ll := DSCircularLinkedList new.
	ll addFirst: 33.
	ll addFirst: 11.
	self deny: ll isEmpty.
	self assert: ll cursor value equals: 11
	 
]

{ #category : #tests }
DSCircularLinkedListTest >> testAddMore [

	| ll |
	ll := DSCircularLinkedList new.
	ll add: 66.
	self assert: ll first equals: 66.
	ll add: 77.
	self assert: ll first equals: 66.
	self assert: ll cursor next value equals: 77.
	ll add: 88.
	self assert: ll first equals: 66.
	self assert: ll cursor next value equals: 88.
	self assert: ll cursor next next value equals: 77.
	
]

{ #category : #tests }
DSCircularLinkedListTest >> testAddOnEmpty [

	| ll |
	ll := DSCircularLinkedList new.
	ll add: 66.
	self assert: ll first equals: 66.
	self assert: ll firstNode next value equals: 66.
]

{ #category : #tests }
DSCircularLinkedListTest >> testAdvance [

	| ll |
	ll := DSCircularLinkedList new.
	ll addFirst: 66.
	ll addFirst: 33.
	ll addFirst: 11.
	self assert: ll first  equals: 11.
	ll advance.
	self assert: ll first equals: 33.
	ll addFirst: 22.
	self assert: ll first equals: 22.
	self assert: ll firstNode next value equals: 33
	 
]

{ #category : #tests }
DSCircularLinkedListTest >> testFirst [

	| ll |
	ll := DSCircularLinkedList new.
	ll addFirst: 33.
	ll addFirst: 11.
	self assert: ll first equals: 11.
 
]

{ #category : #tests }
DSCircularLinkedListTest >> testFirstNode [

	| ll |
	ll := DSCircularLinkedList new.
	ll addFirst: 33.
	ll addFirst: 11.
	self assert: ll firstNode value equals: 11.
 
]

{ #category : #tests }
DSCircularLinkedListTest >> testFirstOnEmptyShouldBark [

	| ll |
	ll := DSCircularLinkedList new.
	self should: [ ll first ] raise: DSEmptyError
 
]

{ #category : #tests }
DSCircularLinkedListTest >> testIsEmpty [

	| ll |
	ll := DSCircularLinkedList new.
	self assert: ll isEmpty.
	
]
