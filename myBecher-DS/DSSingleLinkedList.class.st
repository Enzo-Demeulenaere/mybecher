"
Pretty straighforward implementation of a linked-list.

Compared to the doubly linked list, this implementation expose head while the doublelinkedlist 
does not since it uses sentinels. This is a hint that may be head should not be part of the API of SingleLinkedList either.

It means that we should provide also `firstNode` too.
Now this implementation provides head as a lower-level API when the user does not want to rely on exception but using explicit nil checking.

- `first` is raising an exception on empty lists (because it has to access the value).
- `firstNode` is raising an exception on empty lists to expose the same behavior than `first`

"
Class {
	#name : #DSSingleLinkedList,
	#superclass : #Object,
	#instVars : [
		'head'
	],
	#category : #'myBecher-DS-SingleLinkedList'
}

{ #category : #adding }
DSSingleLinkedList >> addFirst: anObject [
	| item |
	item := DSSingleLinkedNode new.
	item next: head.
	item value: anObject.
	head := item.
]

{ #category : #adding }
DSSingleLinkedList >> addNodeFirst: aNode [ 

	aNode next: self head.
	head := aNode
]

{ #category : #accessing }
DSSingleLinkedList >> first [
	self isEmpty ifTrue: [ DSEmptyError signal ].
	^ head value
]

{ #category : #accessing }
DSSingleLinkedList >> firstNode [
	self isEmpty ifTrue: [ DSEmptyError signal ].
	^ head
]

{ #category : #accessing }
DSSingleLinkedList >> head [
	^ head
]

{ #category : #testing }
DSSingleLinkedList >> isEmpty [
	
	^ head isNil
]

{ #category : #adding }
DSSingleLinkedList >> removeFirst [
	self isEmpty ifTrue: [ DSEmptyError signal ].
	head := head next.
]

{ #category : #accessing }
DSSingleLinkedList >> size [ 

	| size current |
	self isEmpty ifTrue: [ ^ 0 ].
	size := 0.
	current := head. 
	[ current isNil ] whileFalse: [ current := current next. size := size + 1 ].
	^ size 
]
