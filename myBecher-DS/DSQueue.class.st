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

{ #category : 'initialization' }
DSQueue >> initialize [

	contents := OrderedCollection new
]

{ #category : 'testing' }
DSQueue >> isEmpty [
	^ contents isEmpty
]
