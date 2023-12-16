"
I'm a queue implementation based on a single linked list. 
Now since enqueuing is from the back, it means that the complete list should be walked through
because there is no direct access to the last element in the default minimal DSLinkedList. 
Such feature could be added.
"
Class {
	#name : 'DSLinkedListQueue',
	#superclass : 'Object',
	#instVars : [
		'contents'
	],
	#category : 'myBecher-DS-Queue',
	#package : 'myBecher-DS',
	#tag : 'Queue'
}

{ #category : 'accessing' }
DSLinkedListQueue >> dequeue [ 
	
	contents removeFirst
]

{ #category : 'accessing' }
DSLinkedListQueue >> enqueue: anObject [ 
	"this is not nice because it is not the client to have the responsibility to add a node.
	A solution because adding last in DSSingleLinkedList could be to have the possible to add: to the current element."
	
	| current node |
	current := contents head.	
	current isNil 
		ifTrue: [ contents addFirst: anObject. ^ self ].
	[ current next isNil ] whileFalse: [ current := current next ].
	node := DSSingleLinkedNode new.
	node value: anObject.
	current next: node. 
	
]

{ #category : 'accessing' }
DSLinkedListQueue >> front [
	self isEmpty ifTrue: [ ^ DSEmptyError signal ].
	^ contents first
]

{ #category : 'initialization' }
DSLinkedListQueue >> initialize [
	super initialize.
	contents := DSMinimalSingleLinkedList new
]

{ #category : 'initialization' }
DSLinkedListQueue >> isEmpty [
	^ contents isEmpty
]

{ #category : 'initialization' }
DSLinkedListQueue >> size [
	^ contents size
]
