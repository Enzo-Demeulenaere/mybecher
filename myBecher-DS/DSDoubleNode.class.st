Class {
	#name : #DSDoubleNode,
	#superclass : #Object,
	#instVars : [
		'next',
		'previous',
		'value'
	],
	#category : #'myBecher-DS-DoubleLinkedList'
}

{ #category : #accessing }
DSDoubleNode >> next [

	^ next
]

{ #category : #accessing }
DSDoubleNode >> next: anObject [

	next := anObject
]

{ #category : #accessing }
DSDoubleNode >> previous [

	^ previous
]

{ #category : #accessing }
DSDoubleNode >> previous: anObject [

	previous := anObject
]

{ #category : #printing }
DSDoubleNode >> printOn: aStream [

	super printOn: aStream.
	previous isNil ifTrue: [ aStream nextPutAll: '~' ].
	aStream print: value.
	next isNil ifTrue: [ aStream nextPutAll: '~' ].
	
]

{ #category : #accessing }
DSDoubleNode >> value [

	^ value
]

{ #category : #accessing }
DSDoubleNode >> value: anObject [

	value := anObject
]
