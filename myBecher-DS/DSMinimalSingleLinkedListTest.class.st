Class {
	#name : 'DSMinimalSingleLinkedListTest',
	#superclass : 'TestCase',
	#category : 'myBecher-DS-SingleLinkedList',
	#package : 'myBecher-DS',
	#tag : 'SingleLinkedList'
}

{ #category : 'tests - value' }
DSMinimalSingleLinkedListTest >> testAddFirst [

	| ll |
	ll := DSMinimalSingleLinkedList new.
	ll addFirst: 33.
	self deny: ll isEmpty.
	self assert: ll head value equals: 33
	 
]

{ #category : 'tests - value' }
DSMinimalSingleLinkedListTest >> testAddFirstAddFirst [

	| ll |
	ll := DSMinimalSingleLinkedList new.
	ll addFirst: 33.
	ll addFirst: 11.
	self assert: ll head value equals: 11.
	self assert: ll head next value equals: 33
	 
]

{ #category : 'tests - node' }
DSMinimalSingleLinkedListTest >> testAddFirstNode [

	| ll node |
	ll := DSMinimalSingleLinkedList new.
	node := DSSingleLinkedNode new value: 33.
	ll addNodeFirst: node.
	self deny: ll isEmpty.
	self assert: ll head value equals: 33
	 
]

{ #category : 'tests - value' }
DSMinimalSingleLinkedListTest >> testFirst [

	| ll |
	ll := DSMinimalSingleLinkedList new.
	ll addFirst: 33.
	self assert: ll first equals: 33
	 
]

{ #category : 'tests - value' }
DSMinimalSingleLinkedListTest >> testFirstNode [

	| ll |
	ll := DSMinimalSingleLinkedList new.
	ll addFirst: 33.
	self assert: ll firstNode value equals: 33.
	self assert: ll firstNode next equals: nil.
	 
]

{ #category : 'tests - value' }
DSMinimalSingleLinkedListTest >> testFirstNodeWhenEmptyRaiseError [

	| ll |
	ll := DSMinimalSingleLinkedList new.
	self should: [ ll firstNode ] raise: DSEmptyError
	 
]

{ #category : 'tests - value' }
DSMinimalSingleLinkedListTest >> testFirstWhenEmptyRaiseError [

	| ll |
	ll := DSMinimalSingleLinkedList new.
	self should: [ ll first ] raise: DSEmptyError
	 
]

{ #category : 'tests - value' }
DSMinimalSingleLinkedListTest >> testIsEmpty [

	self assert: DSMinimalSingleLinkedList new isEmpty 
]

{ #category : 'tests - value' }
DSMinimalSingleLinkedListTest >> testRemoveFirst [

	| ll |
	ll := DSMinimalSingleLinkedList new.
	ll addFirst: 33.
	ll removeFirst.
	self assert: ll isEmpty
]

{ #category : 'tests - value' }
DSMinimalSingleLinkedListTest >> testRemoveFirstWhenEmptyRaisesAnException [

	| ll |
	ll := DSMinimalSingleLinkedList new.
	self should: [ ll removeFirst ] raise: DSEmptyError.
	
]

{ #category : 'tests - value' }
DSMinimalSingleLinkedListTest >> testSize [

	| ll |
	ll := DSMinimalSingleLinkedList new.
	self assert: ll size equals: 0.
	ll addFirst: 33.
	self assert: ll size equals: 1.
	ll addFirst: 33.
	self assert: ll size equals: 2.
	 
]
