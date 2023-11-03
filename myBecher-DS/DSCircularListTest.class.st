Class {
	#name : #DSCircularListTest,
	#superclass : #TestCase,
	#category : #'myBecher-DS-CircularLinkedList'
}

{ #category : #tests }
DSCircularListTest >> testAddFirst [

	| ll |
	ll := DSCircularLinkedList new.
	ll addFirst: 33.
	self deny: ll isEmpty.
	self assert: ll head value equals: 33
	 
]
