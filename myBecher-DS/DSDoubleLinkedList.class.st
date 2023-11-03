"
I'm double linked list implemented with sentinels.
	head and trail instance variables are pointing to private nodes that are not be considered during the treatment. They play the role of sentinels in this design.
	
An empty list is then composed of 
- a head node whose next is trail node. 
- a head node whose previous is nil.
- a trail node whose previous is head node.
- a trail node whose next is nil.
"
Class {
	#name : #DSDoubleLinkedList,
	#superclass : #Object,
	#instVars : [
		'head',
		'trail'
	],
	#category : #'myBecher-DS-DoubleLinkedList'
}

{ #category : #'adding/removing' }
DSDoubleLinkedList >> add: anInteger beforeNode: aDoubleNode [
	"add a value in a node before the adDoubleNode node."
	
	| newNode |
	newNode := DSDoubleNode new value: anInteger ; yourself.
	newNode next: aDoubleNode. 
	newNode previous: aDoubleNode previous.
	aDoubleNode previous next: newNode. 
	aDoubleNode previous: newNode
	
]

{ #category : #'adding/removing' }
DSDoubleLinkedList >> addFirst2: anInteger [
	"an alternate addFirst: using add:beforeNode:"

	self add: anInteger beforeNode: head next 
]

{ #category : #'adding/removing' }
DSDoubleLinkedList >> addFirst: anInteger [ 
	| node | 
	node := DSDoubleNode new.
	node value: anInteger.
	self addFirstNode: node.
]

{ #category : #'adding/removing' }
DSDoubleLinkedList >> addFirstNode: aNode [ 
	aNode next: head next.
	aNode previous: head.
	head next previous: aNode.
	head next: aNode.
]

{ #category : #'adding/removing' }
DSDoubleLinkedList >> addLast: anInteger [ 
	self add: anInteger beforeNode: trail
]

{ #category : #'adding/removing' }
DSDoubleLinkedList >> addLastNode: aDSDoubleNode [ 
	
	aDSDoubleNode next: trail.
	aDSDoubleNode previous: trail previous.
	aDSDoubleNode previous next: aDSDoubleNode.
	trail previous: aDSDoubleNode
]

{ #category : #accessing }
DSDoubleLinkedList >> first [
	^ self firstNode value
]

{ #category : #accessing }
DSDoubleLinkedList >> firstNode [
	self isEmpty ifTrue: [  DSEmptyError signal ].
	^ head next
]

{ #category : #initialization }
DSDoubleLinkedList >> initialize [ 
	
	super initialize.
	head := DSDoubleNode new.
	head value: 'head'.
	trail := DSDoubleNode new.
	trail value: 'trail'.
	head next: trail.
	trail previous: head.
]

{ #category : #testing }
DSDoubleLinkedList >> isEmpty [
	^ head next == trail
]

{ #category : #accessing }
DSDoubleLinkedList >> last [
	^ self lastNode value
]

{ #category : #accessing }
DSDoubleLinkedList >> lastNode [
	self isEmpty ifTrue: [  DSEmptyError signal ].
	^ trail previous
]

{ #category : #'adding/removing' }
DSDoubleLinkedList >> removeFirst [
	self removeNode: head next
]

{ #category : #'adding/removing' }
DSDoubleLinkedList >> removeLast [
	self removeNode: trail previous.
]

{ #category : #'adding/removing' }
DSDoubleLinkedList >> removeNode: aDSDoubleNode [ 
	"Precondition: aDSDoubleNode belongs to the receiver."
	
	| prev |
	prev := aDSDoubleNode previous.
	prev next: aDSDoubleNode next. 
	aDSDoubleNode next previous: prev
]

{ #category : #accessing }
DSDoubleLinkedList >> size [ 

	| s current |
	self isEmpty ifTrue: [ ^ 0 ].
	s := 0.
	current := head next.  
	[ current == trail ] whileFalse: [ 
		current := current next.
		s := s + 1 ].
	^ s
]
