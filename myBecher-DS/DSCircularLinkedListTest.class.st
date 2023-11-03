Class {
	#name : #DSCircularLinkedListTest,
	#superclass : #TestCase,
	#category : #'myBecher-DS-CircularLinkedList'
}

{ #category : #tests }
DSCircularLinkedListTest >> testAddFirst [

	| ll |
	ll := DSCircularLinkedList new.
	ll addFirst: 33.
	self deny: ll isEmpty.
	self assert: ll cursor value equals: 33
	 
]

{ #category : #tests }
DSCircularLinkedListTest >> testIsEmpty [

	| ll |
	ll := DSCircularLinkedList new.
	self assert: ll isEmpty.
	
]
