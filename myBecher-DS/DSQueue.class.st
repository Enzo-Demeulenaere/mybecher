"
I'm a simple dynamically growing queue implementation with a minimal API.  
"
Class {
	#name : 'DSQueue',
	#superclass : 'Object',
	#instVars : [
		'contents'
	],
	#category : 'myBecher-DS-Queue',
	#package : 'myBecher-DS',
	#tag : 'Queue'
}

{ #category : 'actions' }
DSQueue >> dequeue [
	contents isEmpty ifTrue: [ DSEmptyError signal ].
	contents removeFirst
]

{ #category : 'actions' }
DSQueue >> enqueue: anObject [ 
		
	contents addLast: anObject
]

{ #category : 'accessing' }
DSQueue >> front [
	self isEmpty ifTrue: [ ^ DSEmptyError signal ].
	^ contents first
]

{ #category : 'initialization' }
DSQueue >> initialize [
	super initialize.
	contents := OrderedCollection new
]

{ #category : 'testing' }
DSQueue >> isEmpty [
	^ contents isEmpty
]

{ #category : 'initialization' }
DSQueue >> size [ 

	^ contents size
]
