Class {
	#name : 'DSSingleLinkedListItem',
	#superclass : 'Object',
	#instVars : [
		'value',
		'next'
	],
	#category : 'myBecher-DS',
	#package : 'myBecher-DS'
}

{ #category : 'accessing' }
DSSingleLinkedListItem >> next [
	^ next
]

{ #category : 'accessing' }
DSSingleLinkedListItem >> next: anItem [
	next := anItem
]

{ #category : 'accessing' }
DSSingleLinkedListItem >> value [
	^ value
]

{ #category : 'accessing' }
DSSingleLinkedListItem >> value: anObject [ 
	value := anObject
]
