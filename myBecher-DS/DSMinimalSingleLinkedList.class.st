"
Pretty minimalistic implementation of a linked-list.
It only offers to add/remove the first element.
This is quite limited because we could also have the possibility to insert nodes and more.  

Compared to the doubly linked list, this implementation exposes `head` while the doublelinkedlist 
does not since it uses sentinels. This is a hint that may be head should not be part of the API of SingleLinkedList either.

It means that we should provide also `firstNode` too.
Now this implementation provides head as a lower-level API when the user does not want to rely on exception but using explicit nil checking.

- `first` is raising an exception on empty lists (because it has to access the value).
- `firstNode` is raising an exception on empty lists to expose the same behavior than `first`

"
Class {
	#name : 'DSMinimalSingleLinkedList',
	#superclass : 'Object',
	#instVars : [
		'head'
	],
	#category : 'myBecher-DS-SingleLinkedList',
	#package : 'myBecher-DS',
	#tag : 'SingleLinkedList'
}

{ #category : 'adding' }
DSMinimalSingleLinkedList >> addFirst: anObject [
	| item |
	item := DSSingleLinkedNode new.
	item next: head.
	item value: anObject.
	head := item.
]

{ #category : 'adding' }
DSMinimalSingleLinkedList >> addNodeFirst: aNode [ 

	aNode next: self head.
	head := aNode
]

{ #category : 'accessing' }
DSMinimalSingleLinkedList >> first [
	self isEmpty ifTrue: [ DSEmptyError signal ].
	^ head value
]

{ #category : 'accessing' }
DSMinimalSingleLinkedList >> firstNode [
	self isEmpty ifTrue: [ DSEmptyError signal ].
	^ head
]

{ #category : 'accessing' }
DSMinimalSingleLinkedList >> head [
	^ head
]

{ #category : 'testing' }
DSMinimalSingleLinkedList >> isEmpty [
	
	^ head isNil
]

{ #category : 'adding' }
DSMinimalSingleLinkedList >> removeFirst [
	self isEmpty ifTrue: [ DSEmptyError signal ].
	head := head next.
]

{ #category : 'accessing' }
DSMinimalSingleLinkedList >> size [ 

	| size current |
	self isEmpty ifTrue: [ ^ 0 ].
	size := 0.
	current := head. 
	[ current isNil ] whileFalse: [ current := current next. size := size + 1 ].
	^ size 
]
