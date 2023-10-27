Class {
	#name : #DSDoubleLinkedList,
	#superclass : #Object,
	#instVars : [
		'head',
		'trail'
	],
	#category : #'myBecher-DS-DoubleLinkedList'
}

{ #category : #accessing }
DSDoubleLinkedList >> firstNode [
	^ head
]

{ #category : #initialization }
DSDoubleLinkedList >> initialize [ 
	
	super initialize.
	head := DSDoubleNode new.
	trail := DSDoubleNode new.
	head next: trail.
	trail previous: head.
]

{ #category : #testing }
DSDoubleLinkedList >> isEmpty [
	^ head next == trail
]

{ #category : #accessing }
DSDoubleLinkedList >> lastNode [
	^ trail
]
