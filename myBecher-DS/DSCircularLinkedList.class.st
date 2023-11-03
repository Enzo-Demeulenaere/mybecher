"
Basically a linked list but circular.
A circular linked list has a cursor.

- cursor next is the head (or front) of the linked list
- cursor is also the last element (or back) of the linked list.

A future version may try to refactor and share the logic with SingleLinkedList.

"
Class {
	#name : #DSCircularLinkedList,
	#superclass : #Object,
	#instVars : [
		'cursor'
	],
	#category : #'myBecher-DS-CircularLinkedList'
}

{ #category : #adding }
DSCircularLinkedList >> add: anObject [
	"Add insert a node after the cursor. Still making the list circular."

	| node |
	node := DSSingleLinkedNode new value: anObject; yourself.

	self isEmpty
		ifTrue: [ 
			node next: node. "yes we have a circular list"
			cursor := node ]
		ifFalse: [ 
			node next: cursor next.
			cursor next: node ]
]

{ #category : #'adding/removing' }
DSCircularLinkedList >> addFirst: anObject [ 
	
	| item |
	item := DSSingleLinkedNode new.
	item next: cursor.
	item value: anObject.
	cursor := item.
]

{ #category : #operations }
DSCircularLinkedList >> advance [
	cursor := cursor next
]

{ #category : #accessing }
DSCircularLinkedList >> cursor [
	^ cursor
]

{ #category : #accessing }
DSCircularLinkedList >> first [
	"Return the first element value based on the current cursor."
	
	^ self firstNode value
	
]

{ #category : #accessing }
DSCircularLinkedList >> firstNode [
	
	self isEmpty ifTrue: [ DSEmptyError signal ].
	^ cursor
]

{ #category : #testing }
DSCircularLinkedList >> isEmpty [

	^ cursor isNil
]
