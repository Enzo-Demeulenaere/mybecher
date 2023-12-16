Class {
	#name : 'DSQueueTest',
	#superclass : 'TestCase',
	#category : 'myBecher-DS-Queue',
	#package : 'myBecher-DS',
	#tag : 'Queue'
}

{ #category : 'tests' }
DSQueueTest >> queueClass [

	^ DSQueue
]

{ #category : 'tests' }
DSQueueTest >> testDequeue [
	
	| q |
	q := self queueClass new.
	q enqueue: 5.
	q enqueue: 3.
	q dequeue.  
	self assert: q size equals: 1.
	self assert: q front equals: 3
]

{ #category : 'tests' }
DSQueueTest >> testDequeue2 [
	
	| q |
	q := self queueClass new.
	q enqueue: 5.
	q enqueue: 3.
	q dequeue.  
	q enqueue: 7.
	self assert: q size equals: 2.
	self assert: q front equals: 3.
	q dequeue.
	self assert: q front equals: 7.
]

{ #category : 'tests' }
DSQueueTest >> testDequeueRaiseAnError [
	
	| q |
	q := self queueClass new.
	self should: [ q dequeue ] raise: DSEmptyError  
	
]

{ #category : 'tests' }
DSQueueTest >> testEnqueue [
	
	| q |
	q := self queueClass new.
	q enqueue: 5.
	self assert: q size equals: 1.
	q enqueue: 3. 
	self assert: q size equals: 2
]

{ #category : 'tests' }
DSQueueTest >> testFront [
	
	| q |
	q := self queueClass new.
	q enqueue: 5.
	q enqueue: 3.  
	^ self assert: q front equals: 5
]

{ #category : 'tests' }
DSQueueTest >> testFrontOnEmpty [
	
	| q |
	q := self queueClass new.
	self should: [ q front ] raise: DSEmptyError 
]

{ #category : 'tests' }
DSQueueTest >> testIsEmpty [

	^ self assert: self queueClass new isEmpty
]

{ #category : 'tests' }
DSQueueTest >> testSize [

	^ self assert: self queueClass new size equals: 0
]
