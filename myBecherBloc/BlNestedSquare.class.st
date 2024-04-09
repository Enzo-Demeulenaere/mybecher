Class {
	#name : #BlNestedSquare,
	#superclass : #BlElement,
	#category : #'myBecherBloc-enzo'
}

{ #category : #examples }
BlNestedSquare class >> example [

	<script>
	| nested elt |
	nested := self new
		          border: (BlBorder paint: Color purple width: 5);
		          size: 200 asPoint.

	elt := BlElement new background: Color lightGreen; position: 50 asPoint.

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
			| newPos lastPos|
			newPos := event position - offset.
			lastPos := self position.
			self position: newPos.
			self moveChildrenBy: newPos - lastPos ]
]

{ #category : #'children - geometry' }
BlNestedSquare >> moveChildrenBy: aPoint [

	self childrenDo: [ :child | child position: child position + aPoint negated
		 ]
]
