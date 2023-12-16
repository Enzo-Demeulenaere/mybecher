Class {
	#name : 'DSDoubleLinkedListQueueTest',
	#superclass : 'TestCase',
	#category : 'myBecher-DS-Queue',
	#package : 'myBecher-DS',
	#tag : 'Queue'
}

{ #category : 'tests' }
DSDoubleLinkedListQueueTest >> queueClass [

	^ DSDoubleLinkedListQueue
]

{ #category : 'tests' }
DSDoubleLinkedListQueueTest >> testDequeue [
	
	| q |
	q := self queueClass new.
	q enqueue: 5.
	q enqueue: 3.
	q dequeue.  
	self assert: q size equals: 1.
	self assert: q front equals: 3
]

{ #category : 'tests' }
DSDoubleLinkedListQueueTest >> testDequeue2 [
	
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
DSDoubleLinkedListQueueTest >> testDequeueRaiseAnError [
	
	| q |
	q := self queueClass new.
	self should: [ q dequeue ] raise: DSEmptyError  
	
]

{ #category : 'tests' }
DSDoubleLinkedListQueueTest >> testEnqueue [
	
	| q |
	q := self queueClass new.
	q enqueue: 5.
	self assert: q size equals: 1.
	q enqueue: 3. 
	self assert: q size equals: 2
]

{ #category : 'tests' }
DSDoubleLinkedListQueueTest >> testFront [
	
	| q |
	q := self queueClass new.
	q enqueue: 5.
	q enqueue: 3.  
	^ self assert: q front equals: 5
]

{ #category : 'tests' }
DSDoubleLinkedListQueueTest >> testFrontOnEmpty [
	
	| q |
	q := self queueClass new.
	self should: [ q front ] raise: DSEmptyError 
]

{ #category : 'tests' }
DSDoubleLinkedListQueueTest >> testIsEmpty [

	^ self assert: self queueClass new isEmpty
]

{ #category : 'tests' }
DSDoubleLinkedListQueueTest >> testSize [

	^ self assert: self queueClass new size equals: 0
]
