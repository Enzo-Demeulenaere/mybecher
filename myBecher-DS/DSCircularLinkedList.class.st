"
Basically a linked list but circular.
A circular linked list has a cursor.

- cursor next is the head (or front) of the linked list
- cursor is also the last element (or back) of the linked list.

A future version may try to refactor and share the logic with SingleLinkedList.

I do not like the implementation of add: based on the book Data Structures and Algorithems in C++ (Goodricjh, Tamassai, Mount) because adding in sequence does not conserve the order. 

```
	| ll |
	ll := DSCircularLinkedList new.
	ll add: 66.
	ll add: 33.
	ll add: 11.
	""the order is really bad right now I have 66 11 33""
```

The idea of `add:` adding after the cursor means that the cursor (first element) keeps the first added element and then the others are added first after it. This mess up the order. 

``` 
const Elem& CircleList::back() const {
	return cursor -> elem
	}
	
const Elem& CircleList::front() const {
	return cursor -> next -> elem
	}	
```

```
void CircleList::add(const Elem& e) {
	CNOde* v = new CNode ();
	v -> elem = e;
	if (cursor == NULL) {
		v -> next = v;
		cursor = v;
		}
	else {
		v -> next = cursor -> next ;
		cursor -> next = v;
	}
}

```


"
Class {
	#name : #DSCircularLinkedList,
	#superclass : #Object,
	#instVars : [
		'cursor'
	],
	#category : #'myBecher-DS-CircularLinkedList'
}

{ #category : #adding }
DSCircularLinkedList >> add: anObject [
	"Add insert a node after the cursor. Still making the list circular."

	| node |
	node := DSSingleLinkedNode new value: anObject; yourself.

	self isEmpty
		ifTrue: [ 
			node next: node. "yes we have a circular list"
			cursor := node ]
		ifFalse: [ 
			node next: cursor next.
			cursor next: node ]
]

{ #category : #'adding/removing' }
DSCircularLinkedList >> addFirst: anObject [ 
	
	| item |
	item := DSSingleLinkedNode new.
	item next: cursor.
	item value: anObject.
	cursor := item.
]

{ #category : #operations }
DSCircularLinkedList >> advance [
	cursor := cursor next
]

{ #category : #accessing }
DSCircularLinkedList >> cursor [
	^ cursor
]

{ #category : #accessing }
DSCircularLinkedList >> first [
	"Return the first element value based on the current cursor."
	
	^ self firstNode value
	
]

{ #category : #accessing }
DSCircularLinkedList >> firstNode [
	
	self isEmpty ifTrue: [ DSEmptyError signal ].
	^ cursor
]

{ #category : #testing }
DSCircularLinkedList >> isEmpty [

	^ cursor isNil
]

{ #category : #accessing }
DSCircularLinkedList >> last [
	"Return the first element value based on the current cursor."
	self isEmpty ifTrue: [ DSEmptyError signal ].
	^ self cursor value
	
]
