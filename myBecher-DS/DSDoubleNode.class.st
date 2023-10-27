Class {
	#name : #DSDoubleNode,
	#superclass : #Object,
	#instVars : [
		'next',
		'previous'
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
