Class {
	#name : 'DSQueueTest',
	#superclass : 'TestCase',
	#category : 'myBecher-DS-Queue',
	#package : 'myBecher-DS',
	#tag : 'Queue'
}

{ #category : 'tests' }
DSQueueTest >> testEmpty [

	^ self assert: DSQueue new isEmpty
]
