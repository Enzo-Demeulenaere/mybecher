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

{ #category : #examples }
BlNestedSquare class >> prettyExample2Squares [

	<script>
	| elt1 elt2 elt3 |
	elt1 := self new
		        border: (BlBorder paint: Color purple width: 5);
		        size: 200 asPoint.
	elt2 := self new
		        border: (BlBorder paint: Color pink width: 5);
		        size: 160 asPoint;
		        position: 20 asPoint.
	elt3 := BlElement new
		        background: Color lightGreen;
		        position: 50 asPoint.

	elt1 addChild: elt2.
	elt2 addChild: elt3.
	
	elt2 addEventHandlerOn: BlClickEvent do: [ :e | elt2 inspect ].

	elt1 openInSpace
]

{ #category : #examples }
BlNestedSquare class >> prettyExample5Squares [

	<script>
	| elt1 elt2 elt3 elt4 elt5 |
	elt1 := self new
		        border: (BlBorder paint: Color purple width: 5);
		        size: 200 asPoint.
	elt2 := self new
		        border: (BlBorder paint: Color purple width: 5);
		        size: 180 asPoint.
	elt3 := self new
		        border: (BlBorder paint: Color purple width: 5);
		        size: 160 asPoint.
	elt4 := self new
		        border: (BlBorder paint: Color purple width: 5);
		        size: 140 asPoint.
	elt5 := self new
		        border: (BlBorder paint: Color purple width: 5);
		        size: 120 asPoint.


	elt1 addChild: elt2.
	elt2 addChild: elt3.
	elt3 addChild: elt4.
	elt4 addChild: elt5.

	elt1 openInSpace
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
			event consumed: true.
			newPos := event position - offset.
			lastPos := self position.
			self position: newPos.
			"self moveChildrenBy: 0"
			self moveChildrenBy: newPos - lastPos ]
]

{ #category : #'children - geometry' }
BlNestedSquare >> moveChildrenBy: a2DVector [

	self childrenDo: [ :child |
		| newPos childPos moved |
		newPos := child position - a2DVector.
		childPos := child position.
		moved := false.

		newPos x < 0 ifTrue: [
			newPos := 0 @ newPos y.
			moved := true ].
		newPos y < 0 ifTrue: [
			newPos := newPos x @ 0.
			moved := true ].

		newPos x > (child parent width - child width) ifTrue: [
			newPos := child parent width - child width @ newPos y.
			moved := true ].
		newPos y > (child parent height - child height) ifTrue: [
			newPos := newPos x @ (child parent height - child height).
			moved := true ].

		child position: newPos.
		(child class = self class and: moved) ifTrue: [
			child moveChildrenBy: a2DVector  ] ]
]
