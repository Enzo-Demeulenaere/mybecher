Class {
	#name : 'DSSingleLinkedList',
	#superclass : 'Object',
	#instVars : [
		'head'
	],
	#category : 'myBecher-DS-SingleLinkedList',
	#package : 'myBecher-DS',
	#tag : 'SingleLinkedList'
}

{ #category : 'adding' }
DSSingleLinkedList >> addFirst: anObject [
	| item |
	item := DSSingleLinkedNode new.
	item next: head.
	item value: anObject.
	head := item.
]

{ #category : 'adding' }
DSSingleLinkedList >> addNodeFirst: aNode [ 

	aNode next: self head.
	head := aNode
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

{ #category : 'adding' }
DSSingleLinkedList >> removeFirst [
	self isEmpty ifTrue: [ DSEmptyError signal ].
	head := head next.
]
