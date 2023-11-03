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

{ #category : #'adding/removing' }
DSCircularLinkedList >> addFirst: anObject [ 
	
	| item |
	item := DSSingleLinkedNode new.
	item next: cursor.
	item value: anObject.
	cursor := item.
]

{ #category : #accessing }
DSCircularLinkedList >> cursor [
	^ cursor
]

{ #category : #testing }
DSCircularLinkedList >> isEmpty [

	^ cursor isNil
]
