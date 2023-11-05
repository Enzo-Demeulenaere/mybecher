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

{ #category : #operations }
DSStack >> push: anInteger [ 
	contents addFirst: anInteger
]

{ #category : #operations }
DSStack >> size [

	^ contents size
]
