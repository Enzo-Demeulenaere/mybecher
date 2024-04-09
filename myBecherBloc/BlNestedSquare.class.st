Class {
	#name : #BlNestedSquare,
	#superclass : #BlElement,
	#category : #'myBecherBloc-enzo'
}

{ #category : #examples }
BlNestedSquare class >> basicExample [

	<script>
	| nested elt |
	nested := self new
		          border: (BlBorder paint: Color purple width: 5);
		          size: 200 asPoint.

	elt := BlElement new
		       background: Color lightGreen;
		       position: 50 asPoint.

	nested addChild: elt.

	nested openInSpace
]

{ #category : #initialization }
BlNestedSquare >> initialize [

	super initialize.
	self clipChildren: false.
	self initializeEvents
]

{ #category : #initialization }
BlNestedSquare >> initializeEvents [

	| offset |
	self
		addEventHandlerOn: BlDragStartEvent do: [ :event |
			event consumed: true.
			offset := event position - self position ];
		addEventHandlerOn: BlDragEvent do: [ :event |
			| newPos lastPos |
			newPos := event position - offset.
			lastPos := self position.
			self position: newPos.
			self moveChildrenBy: newPos - lastPos ]
]

{ #category : #'children - geometry' }
BlNestedSquare >> moveChildrenBy: aPoint [

	self childrenDo: [ :child |
		| newPos |
		newPos := child position + aPoint negated.
		
		newPos x < 0 ifTrue: [ newPos := 0 @ newPos y ].
		newPos y < 0 ifTrue: [ newPos := newPos x @ 0 ].
		
		newPos x > (self width - child width) ifTrue: [ newPos := (self width - child width) @ newPos y ].
		newPos y > (self height - child height) ifTrue: [ newPos := newPos x @ (self height - child height) ].
		
		child position: newPos ]
]
