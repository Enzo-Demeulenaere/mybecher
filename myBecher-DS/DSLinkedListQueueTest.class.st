Class {
	#name : 'DSLinkedListQueueTest',
	#superclass : 'TestCase',
	#category : 'myBecher-DS-Queue',
	#package : 'myBecher-DS',
	#tag : 'Queue'
}

{ #category : 'tests' }
DSLinkedListQueueTest >> queueClass [

	^ DSLinkedListQueue
]

{ #category : 'tests' }
DSLinkedListQueueTest >> testDequeue [
	
	| q |
	q := self queueClass new.
	q enqueue: 5.
	q enqueue: 3.
	q dequeue.  
	self assert: q size equals: 1.
	self assert: q front equals: 3
]

{ #category : 'tests' }
DSLinkedListQueueTest >> testDequeue2 [
	
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
DSLinkedListQueueTest >> testDequeueRaiseAnError [
	
	| q |
	q := self queueClass new.
	self should: [ q dequeue ] raise: DSEmptyError  
	
]

{ #category : 'tests' }
DSLinkedListQueueTest >> testEnqueue [
	
	| q |
	q := self queueClass new.
	q enqueue: 5.
	self assert: q size equals: 1.
	q enqueue: 3. 
	self assert: q size equals: 2
]

{ #category : 'tests' }
DSLinkedListQueueTest >> testFront [
	
	| q |
	q := self queueClass new.
	q enqueue: 5.
	q enqueue: 3.  
	^ self assert: q front equals: 5
]

{ #category : 'tests' }
DSLinkedListQueueTest >> testFrontOnEmpty [
	
	| q |
	q := self queueClass new.
	self should: [ q front ] raise: DSEmptyError 
]

{ #category : 'tests' }
DSLinkedListQueueTest >> testIsEmpty [

	^ self assert: self queueClass new isEmpty
]

{ #category : 'tests' }
DSLinkedListQueueTest >> testSize [

	^ self assert: self queueClass new size equals: 0
]
