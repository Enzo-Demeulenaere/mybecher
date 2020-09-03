Class {
	#name : #Project,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'NewTools-ProjectLoader'
}

{ #category : #'instance creation' }
Project class >> named: aString [

	^ self new name: aString; yourself
]

{ #category : #accessing }
Project >> name [
	^ name
]

{ #category : #accessing }
Project >> name: anObject [
	name := anObject
]
