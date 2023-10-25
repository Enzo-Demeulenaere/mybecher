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
DSSingleLinkedListTest >> testIsEmpty [

	self assert: DSSingleLinkedList new isEmpty 
]
