"
Basically a linked list but circular.
A circular linked list has a cursor.

- cursor next is the head (or front) of the linked list
- cursor points to also the last element (or back) of the linked list.

A future version may try to refactor and share the logic with SingleLinkedList.

The implementation is based on the book Data Structures and Algorithems in C++ (Goodricjh, Tamassai, Mount).
The key point is to see that the cursor is always pointing to the last element and that the next of cursor is the first element. 



``` 
const Elem& CircleList::back() const {
	return cursor -> elem
	}
	
const Elem& CircleList::front() const {
	return cursor -> next -> elem
	}	
```

if we do not follow this convention, then adding a sequence of objects will not lead to a linked list with the same order.

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

### Discussions

- There is no insert methods. Now inserting anywhere is different than at the end because at the end the we should update the cursor to point to the newly inserted node.



"
Class {
	#name : 'DSCircularLinkedList',
	#superclass : 'Object',
	#instVars : [
		'cursor'
	],
	#category : 'myBecher-DS-CircularLinkedList',
	#package : 'myBecher-DS',
	#tag : 'CircularLinkedList'
}

{ #category : 'adding' }
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

{ #category : 'operations' }
DSCircularLinkedList >> advance [
	cursor := cursor next
]

{ #category : 'accessing' }
DSCircularLinkedList >> cursor [
	^ cursor
]

{ #category : 'accessing' }
DSCircularLinkedList >> first [
	"Return the first element value based on the current cursor. Remember that the cursor refer to the last element."
	
	^ self firstNode value
	
]

{ #category : 'accessing' }
DSCircularLinkedList >> firstNode [
	"Remember that the first element (back in book) is the next one of the cursor node.
	Cursor points to last (back)."
	
	self isEmpty ifTrue: [ DSEmptyError signal ].
	^ cursor next
]

{ #category : 'testing' }
DSCircularLinkedList >> isEmpty [

	^ cursor isNil
]

{ #category : 'accessing' }
DSCircularLinkedList >> last [
	"Return the first element value based on the current cursor."
	self isEmpty ifTrue: [ DSEmptyError signal ].
	^ self cursor value
	
]

{ #category : 'adding/removing' }
DSCircularLinkedList >> remove [
	
	self isEmpty ifTrue: [ ^ self ].
	cursor == cursor next
		ifTrue: [ cursor := nil ]
		ifFalse: [  
				cursor next: cursor next next ]
]
