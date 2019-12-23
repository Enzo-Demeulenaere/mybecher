Class {
	#name : #MyPromiseTest,
	#superclass : #TestCase,
	#category : #'myBecher-Concurrent-promise'
}

{ #category : #tests }
MyPromiseTest >> testPromise [

	| promise |
	promise := [ 1 + 2 ] promise.
	self assert: promise value equals: 3
]

{ #category : #tests }
MyPromiseTest >> testPromiseBlockingAndUnblocking [

	| controllingPromiseSemaphore promise |
	controllingPromiseSemaphore := Semaphore new.
	
	[ (Delay forSeconds: 1) wait.
	controllingPromiseSemaphore signal ] fork.
	
	promise := [ controllingPromiseSemaphore wait. 
				1 + 3 ] promise. 			
	self deny: promise hasValue.
	
	(Delay forSeconds: 3) wait. 
	self assert: promise hasValue.
	self assert: promise value equals: 4
]

{ #category : #tests }
MyPromiseTest >> testPromiseCreation [

	| promise |
	promise := [ 1 + 2 ] promise.
	self deny: promise hasValue.
	self deny: promise equals: 3
]
