Class {
	#name : 'DSSingleLinkedList',
	#superclass : 'Object',
	#instVars : [
		'head'
	],
	#category : 'myBecher-DS',
	#package : 'myBecher-DS'
}

{ #category : 'adding' }
DSSingleLinkedList >> addFirst: anObject [
	| item |
	item := DSSingleLinkedListItem new.
	item next: head.
	item value: anObject.
	head := item.
]

{ #category : 'accessing' }
DSSingleLinkedList >> first [
	self isEmpty ifTrue: [ DSEmptyError signal ].
	^ head value
]

{ #category : 'accessing' }
DSSingleLinkedList >> head [
	^ head
]

{ #category : 'testing' }
DSSingleLinkedList >> isEmpty [
	
	^ head isNil
]

{ #category : 'accessing' }
DSSingleLinkedList >> next [
	self shouldBeImplemented.
]

{ #category : 'adding' }
DSSingleLinkedList >> removeFirst [
	self isEmpty ifTrue: [ DSEmptyError signal ].
	head := head next.
]
