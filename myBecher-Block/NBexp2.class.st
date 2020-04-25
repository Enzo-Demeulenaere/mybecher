Class {
	#name : #NBexp2,
	#superclass : #Object,
	#instVars : [
		'x'
	],
	#category : #'myBecher-Block'
}

{ #category : #initialization }
NBexp2 >> executeBlockInAnotherInstance6: aBlock [
	aBlock value
]

{ #category : #initialization }
NBexp2 >> initialize [
	x := 69.
]
