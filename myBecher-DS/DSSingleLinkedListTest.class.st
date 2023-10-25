Class {
	#name : 'DSSingleLinkedListTest',
	#superclass : 'TestCase',
	#category : 'myBecher-DS',
	#package : 'myBecher-DS'
}

{ #category : 'tests' }
DSSingleLinkedListTest >> testAddFirst [

	| ll |
	ll := DSSingleLinkedList new.
	ll addFirst: 33.
	self deny: ll isEmpty.
	self assert: ll head value equals: 33
	 
]

{ #category : 'tests' }
DSSingleLinkedListTest >> testAddFirstAddFirst [

	| ll |
	ll := DSSingleLinkedList new.
	ll addFirst: 33.
	ll addFirst: 11.
	self assert: ll head value equals: 11.
	self assert: ll head next value equals: 33
	 
]

{ #category : 'tests' }
DSSingleLinkedListTest >> testFirst [

	| ll |
	ll := DSSingleLinkedList new.
	ll addFirst: 33.
	self assert: ll first equals: 33
	 
]

{ #category : 'tests' }
DSSingleLinkedListTest >> testFirstWhenEmptyRaiseError [

	| ll |
	ll := DSSingleLinkedList new.
	self should: [ ll first ] raise: DSEmptyError
	 
]

{ #category : 'tests' }
DSSingleLinkedListTest >> testIsEmpty [

	self assert: DSSingleLinkedList new isEmpty 
]

{ #category : 'tests' }
DSSingleLinkedListTest >> testRemoveFirst [

	| ll |
	ll := DSSingleLinkedList new.
	ll addFirst: 33.
	ll removeFirst.
	self assert: ll isEmpty
]

{ #category : 'tests' }
DSSingleLinkedListTest >> testRemoveFirstWhenEmptyRaisesAnException [

	| ll |
	ll := DSSingleLinkedList new.
	self should: [ ll removeFirst ] raise: DSEmptyError.
	
]
