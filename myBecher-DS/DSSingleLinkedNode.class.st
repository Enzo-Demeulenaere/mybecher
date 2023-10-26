Class {
	#name : 'DSSingleLinkedNode',
	#superclass : 'Object',
	#instVars : [
		'value',
		'next'
	],
	#category : 'myBecher-DS',
	#package : 'myBecher-DS'
}

{ #category : 'accessing' }
DSSingleLinkedNode >> next [
	^ next
]

{ #category : 'accessing' }
DSSingleLinkedNode >> next: anItem [
	next := anItem
]

{ #category : 'accessing' }
DSSingleLinkedNode >> value [
	^ value
]

{ #category : 'accessing' }
DSSingleLinkedNode >> value: anObject [ 
	value := anObject
]
