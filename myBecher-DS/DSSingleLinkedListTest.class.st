Class {
	#name : #DSSingleLinkedListTest,
	#superclass : #TestCase,
	#category : #'myBecher-DS-SingleLinkedList'
}

{ #category : #'tests - value' }
DSSingleLinkedListTest >> testAddFirst [

	| ll |
	ll := DSSingleLinkedList new.
	ll addFirst: 33.
	self deny: ll isEmpty.
	self assert: ll head value equals: 33
	 
]

{ #category : #'tests - value' }
DSSingleLinkedListTest >> testAddFirstAddFirst [

	| ll |
	ll := DSSingleLinkedList new.
	ll addFirst: 33.
	ll addFirst: 11.
	self assert: ll head value equals: 11.
	self assert: ll head next value equals: 33
	 
]

{ #category : #'tests - node' }
DSSingleLinkedListTest >> testAddFirstNode [

	| ll node |
	ll := DSSingleLinkedList new.
	node := DSSingleLinkedNode new value: 33.
	ll addNodeFirst: node.
	self deny: ll isEmpty.
	self assert: ll head value equals: 33
	 
]

{ #category : #'tests - value' }
DSSingleLinkedListTest >> testFirst [

	| ll |
	ll := DSSingleLinkedList new.
	ll addFirst: 33.
	self assert: ll first equals: 33
	 
]

{ #category : #'tests - value' }
DSSingleLinkedListTest >> testFirstNode [

	| ll |
	ll := DSSingleLinkedList new.
	ll addFirst: 33.
	self assert: ll firstNode value equals: 33.
	self assert: ll firstNode next equals: nil.
	 
]

{ #category : #'tests - value' }
DSSingleLinkedListTest >> testFirstNodeWhenEmptyRaiseError [

	| ll |
	ll := DSSingleLinkedList new.
	self should: [ ll firstNode ] raise: DSEmptyError
	 
]

{ #category : #'tests - value' }
DSSingleLinkedListTest >> testFirstWhenEmptyRaiseError [

	| ll |
	ll := DSSingleLinkedList new.
	self should: [ ll first ] raise: DSEmptyError
	 
]

{ #category : #'tests - value' }
DSSingleLinkedListTest >> testIsEmpty [

	self assert: DSSingleLinkedList new isEmpty 
]

{ #category : #'tests - value' }
DSSingleLinkedListTest >> testRemoveFirst [

	| ll |
	ll := DSSingleLinkedList new.
	ll addFirst: 33.
	ll removeFirst.
	self assert: ll isEmpty
]

{ #category : #'tests - value' }
DSSingleLinkedListTest >> testRemoveFirstWhenEmptyRaisesAnException [

	| ll |
	ll := DSSingleLinkedList new.
	self should: [ ll removeFirst ] raise: DSEmptyError.
	
]
