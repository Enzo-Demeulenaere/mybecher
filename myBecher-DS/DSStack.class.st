Class {
	#name : #DSStack,
	#superclass : #Object,
	#instVars : [
		'contents'
	],
	#category : #'myBecher-DS-Stack'
}

{ #category : #initialization }
DSStack >> initialize [ 
	super initialize.
	contents := DSSingleLinkedList new.
]

{ #category : #testing }
DSStack >> isEmpty [
	^ contents isEmpty
]

{ #category : #operations }
DSStack >> pop [
	| first |
	first := contents first.
	contents removeFirst.
	^ first
]

{ #category : #operations }
DSStack >> push: anInteger [ 
	contents addFirst: anInteger
]

{ #category : #operations }
DSStack >> size [

	^ contents size
]

{ #category : #accessing }
DSStack >> top [
	^ contents first
]
