Class {
	#name : #MyCounter,
	#superclass : #Object,
	#instVars : [
		'count'
	],
	#category : #'myBecher-Concurrent'
}

{ #category : #accessing }
MyCounter >> decrement [ 

	count := count - 1
]

{ #category : #accessing }
MyCounter >> increment [ 

	count := count + 1
]
