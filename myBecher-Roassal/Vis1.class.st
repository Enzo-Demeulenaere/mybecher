"
Vis1 new 
	classes: RSObject withAllSubclasses;
	draw;
	open
"
Class {
	#name : #Vis1,
	#superclass : #Object,
	#instVars : [
		'c',
		'classes'
	],
	#category : #'myBecher-Roassal'
}

{ #category : #accessing }
Vis1 >> classes: aCollection [ 

	classes := aCollection
]

{ #category : #drawing }
Vis1 >> createCompositeFrom: label methods: methods [
	^  RSComposite new
			color: Color gray;
			shapes: {label} , methods;
			@ RSDraggable;
			padding: 10
]

{ #category : #drawing }
Vis1 >> createLabel: cls [
	^ RSLabel new text: cls name
]

{ #category : #drawing }
Vis1 >> createMethodBox: m [
	^ RSBox new
		model: m;
		size: m sourceCode size sqrt;
		color: Color blue
]

{ #category : #drawing }
Vis1 >> draw [
	classes
		do: [ :cls | 
			| label methods composite |
			label := self createLabel: cls.
			methods := cls methods
				collect: [ :m | self createMethodBox: m ]
				as: RSGroup.
			RSGridLayout on: methods.
			methods @ RSPopup.
			RSLocation new
				above;
				move: label on: methods.
			c add: (self createCompositeFrom: label methods: methods) ].
	RSFlowLayout on: c shapes.
	c @ RSCanvasController
]

{ #category : #initialization }
Vis1 >> initialize [

	c := RSCanvas new.
]

{ #category : #drawing }
Vis1 >> open [ 

	c open
]
