Class {
	#name : #BlSimpleSlider,
	#superclass : #BlElement,
	#instVars : [
		'widgetSize',
		'handle',
		'bar',
		'coloredBar',
		'isHorizontal',
		'minValue',
		'maxValue',
		'stepValue',
		'currentValue',
		'barThickness',
		'barLength',
		'marginThickness',
		'marginLength',
		'announcer'
	],
	#category : #'myBecherBloc-Slider'
}

{ #category : #example }
BlSimpleSlider class >> alainVisual1 [

	<script>
	| bl |
	bl := self new.
	bl minValue: 0.
	bl maxValue: 20.
	bl stepValue: 1.
	bl size: 500 @ 25.
	bl buildSlider.
	bl validatedValueCallback: [ :e | "self changedTimeValue: e" ].
	bl margin: (BlInsets top: 5).
	bl openInSpace.
	bl inspect
]

{ #category : #accessing }
BlSimpleSlider class >> beHorizontal [

	^ self new beHorizontal 
]

{ #category : #accessing }
BlSimpleSlider class >> beVertical [ 
	
	^ self new beVertical 
]

{ #category : #example }
BlSimpleSlider class >> simpleExampleHorizontal [
	"The values of the slider are also written in the transcript"

	<script>
	| slider textElt container |
	slider := self beHorizontal.
	textElt := BlTextElement new position: 100 @ 40.

	textElt text: slider currentValue asRopedText.

	slider
		addEventHandlerOn: BlSliderValueChangedEvent
		do: [ textElt text: slider currentValue asRopedText ].

	container := BlElement new clipChildren: false.

	container addChild: slider.
	container addChild: textElt.

	container openInSpace
]

{ #category : #example }
BlSimpleSlider class >> simpleExampleVertical [
	"The values of the slider are also written in the transcript"

	<script>
	| slider textElt container |
	slider := self beVertical.
	textElt := BlTextElement new position: 40 @ 100.

	textElt text: slider currentValue asRopedText.

	slider
		addEventHandlerOn: BlSliderValueChangedEvent
		do: [ textElt text: slider currentValue asRopedText ].




	container := BlElement new clipChildren: false.

	container addChild: slider.
	container addChild: textElt.

	container openInSpace
]

{ #category : #accessing }
BlSimpleSlider >> announcer [ 

	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #accessing }
BlSimpleSlider >> bar [
	^ bar
]

{ #category : #accessing }
BlSimpleSlider >> bar: aBlElement [ 
	bar := aBlElement
]

{ #category : #'api - bounds' }
BlSimpleSlider >> barDefaultColor [ 

	^ Color lightGray 
]

{ #category : #accessing }
BlSimpleSlider >> barLength [

	^ barLength
]

{ #category : #accessing }
BlSimpleSlider >> barLength: aNumber [

	barLength := aNumber.
	self rebuild
]

{ #category : #accessing }
BlSimpleSlider >> barThickness [ 

	^ barThickness 
]

{ #category : #accessing }
BlSimpleSlider >> barThickness: aNumber [

	barThickness := aNumber.
	self rebuild
]

{ #category : #accessing }
BlSimpleSlider >> beHorizontal [

	self horizontal: true.
	self buildHorizontal
]

{ #category : #accessing }
BlSimpleSlider >> beVertical [

	self horizontal: false.
	self buildVertical
]

{ #category : #'as yet unclassified' }
BlSimpleSlider >> buildHorizontal [

	widgetSize y > widgetSize x ifTrue: [
		self widgetSize: widgetSize y @ widgetSize x ].
	self removeParts.
	self initializeParts
]

{ #category : #'as yet unclassified' }
BlSimpleSlider >> buildVertical [

	widgetSize y > widgetSize x ifFalse: [
		self widgetSize: widgetSize y @ widgetSize x ].

	self removeParts.
	self initializeParts
]

{ #category : #accessing }
BlSimpleSlider >> coloredBar [ 

	^ coloredBar 
]

{ #category : #accessing }
BlSimpleSlider >> coloredBar: aBlElement [

	coloredBar := aBlElement 
]

{ #category : #'as yet unclassified' }
BlSimpleSlider >> coloredBarDefaultColor [

	^ Color red
]

{ #category : #accessing }
BlSimpleSlider >> currentValue [ 

	^ currentValue 
]

{ #category : #accessing }
BlSimpleSlider >> currentValue: aNumber [

	(aNumber < self minValue or: [ aNumber > self maxValue ]) ifTrue: [ ^ self ].
	currentValue := aNumber
]

{ #category : #'api - bounds' }
BlSimpleSlider >> defaultBar [

	| size |
	size := self isHorizontal
		        ifTrue: [ self defaultBarLength @ self defaultBarThickness ]
		        ifFalse: [ self defaultBarThickness @ self defaultBarLength ].

	^ BlElement new
		  geometry: (BlRoundedRectangleGeometry cornerRadius: 5);
		  background: self barDefaultColor;
		  size: size;
		  yourself
]

{ #category : #'api - bounds' }
BlSimpleSlider >> defaultBarLength [

	^ 200
]

{ #category : #'api - bounds' }
BlSimpleSlider >> defaultBarThickness [

	^ 10
]

{ #category : #'api - bounds' }
BlSimpleSlider >> defaultColor [ 

	^ Color lightRed 
]

{ #category : #'as yet unclassified' }
BlSimpleSlider >> defaultColoredBar [

	| size |
	size := self isHorizontal
		        ifTrue: [ 0 @ self defaultBarThickness ]
		        ifFalse: [ self defaultBarThickness @ 0 ].

	^ BlElement new
		  geometry: (BlRoundedRectangleGeometry cornerRadius: 5);
		  background: self coloredBarDefaultColor;
		  size: size;
		  yourself
]

{ #category : #'api - bounds' }
BlSimpleSlider >> defaultHandle [

	| size elt offset |
	size := 15 asPoint.
	elt := BlElement new
		       geometry: BlCircleGeometry new;
		       background: self handleDefaultColor;
		       size: size;
		       transformDo: [ :t | "so the position is now the center"
			       t translateBy: size negated / 2 ];
		       yourself.

	elt addEventHandlerOn: BlDragStartEvent do: [ :event |
		event consumed: true.
		offset := event position - elt position ].

	elt
		addEventHandlerOn: BlDragEvent
		do: [ :event | self moveHandleTo: event position - offset ].

	^ elt
]

{ #category : #'api - bounds' }
BlSimpleSlider >> defaultMargin [

	^ 10
]

{ #category : #'as yet unclassified' }
BlSimpleSlider >> defaultMarginLength [ 

	^ 10
]

{ #category : #'as yet unclassified' }
BlSimpleSlider >> defaultMarginThickness [

	^ 10
]

{ #category : #'api - bounds' }
BlSimpleSlider >> defaultSize [
	"self bar size maybe"
	^ (self isHorizontal
		   ifTrue: [ self defaultBarLength @ self defaultBarThickness ]
		   ifFalse: [ self defaultBarThickness @ self defaultBarLength ])
	  + (2 * self defaultMargin)
]

{ #category : #accessing }
BlSimpleSlider >> handle [
	^ handle
]

{ #category : #accessing }
BlSimpleSlider >> handle: aBlElement [ 
	handle := aBlElement
]

{ #category : #'api - bounds' }
BlSimpleSlider >> handleDefaultColor [ 

	^ Color red
]

{ #category : #accessing }
BlSimpleSlider >> horizontal: aBoolean [

	isHorizontal := aBoolean 
]

{ #category : #initialization }
BlSimpleSlider >> initialize [

	super initialize.
	isHorizontal := true.
	self initializeSizes.
	self widgetSize: self defaultSize.
	self background: self defaultColor.
	self initializeValues.
	self initializeParts
]

{ #category : #initialization }
BlSimpleSlider >> initializeParts [

	self bar: self defaultBar.
	self positionDefaultBar.
	self addChild: self bar.

	self coloredBar: self defaultColoredBar.
	self positionDefaultColoredBar.
	self addChild: self coloredBar.

	self handle: self defaultHandle.
	self positionDefaultHandle.
	self addChild: self handle.

	
]

{ #category : #initialization }
BlSimpleSlider >> initializeSizes [ 

	barLength := self defaultBarLength.
	barThickness := self defaultBarThickness.
	marginLength := self defaultMarginLength.
	marginThickness := self defaultMarginThickness.
]

{ #category : #initialization }
BlSimpleSlider >> initializeValues [

	self minValue: 0.
	self maxValue: 50.
	self currentValue: self minValue 
]

{ #category : #accessing }
BlSimpleSlider >> isHorizontal [ 

	^ isHorizontal 
]

{ #category : #accessing }
BlSimpleSlider >> marginLength [

	^ marginLength
]

{ #category : #accessing }
BlSimpleSlider >> marginLength: aNumber [

	marginLength := aNumber.
	self rebuild
]

{ #category : #accessing }
BlSimpleSlider >> marginThickness [ 

	^ marginThickness 
]

{ #category : #accessing }
BlSimpleSlider >> marginThickness: aNumber [

	marginThickness := aNumber.
	self rebuild
]

{ #category : #accessing }
BlSimpleSlider >> maxValue [

	^ maxValue
]

{ #category : #accessing }
BlSimpleSlider >> maxValue: aNumber [

	maxValue := aNumber
]

{ #category : #accessing }
BlSimpleSlider >> minValue [ 

	^ minValue 
]

{ #category : #accessing }
BlSimpleSlider >> minValue: aNumber [

	minValue := aNumber 
]

{ #category : #'as yet unclassified' }
BlSimpleSlider >> moveHandleTo: aPosition [

	| newPos |
	newPos := aPosition.
	self isHorizontal
		ifTrue: [
			| newPosX |
			newPosX := newPos x.
			newPos x < bar position x ifTrue: [ newPosX := bar position x ].
			newPos x > (bar position x + barLength) ifTrue: [
				newPosX := bar position x + barLength ].
			handle position: newPosX @ handle position y ]
		ifFalse: [
			| newPosY |
			newPosY := newPos y.
			newPos y < bar position y ifTrue: [ newPosY := bar position y ].
			newPos y > (bar position y + barLength) ifTrue: [
				newPosY := bar position y + barLength ].
			handle position: handle position x @ newPosY ].
	self updateColoredBar.
	self updateValue
]

{ #category : #'as yet unclassified' }
BlSimpleSlider >> positionDefaultBar [

	self isHorizontal
		ifTrue: [ bar position: self defaultMarginLength @ self defaultMarginThickness ]
		ifFalse: [
			bar position:
				self defaultMarginThickness @ self defaultMarginLength  ]
]

{ #category : #'as yet unclassified' }
BlSimpleSlider >> positionDefaultColoredBar [

	self positionDefaultBar
]

{ #category : #'as yet unclassified' }
BlSimpleSlider >> positionDefaultHandle [

	self isHorizontal
		ifTrue: [ handle position: self defaultMargin @ (widgetSize y / 2) ]
		ifFalse: [ handle position: widgetSize x / 2 @ (self defaultMargin + barLength) ]
]

{ #category : #building }
BlSimpleSlider >> rebuild [ 

	self isHorizontal ifTrue: [ self buildHorizontal ] ifFalse: [ self buildVertical ]
]

{ #category : #removing }
BlSimpleSlider >> removeParts [

	self removeChildren. 
	bar := nil.
	handle := nil
]

{ #category : #'api - bounds' }
BlSimpleSlider >> size: aValue [
	"just to keep the widgset size"

	super size: aValue.
	
	" for now do not support resize
	
	self isBuildSlider ifTrue: [ self rebuildSlider ]
	"
]

{ #category : #accessing }
BlSimpleSlider >> stepValue [

	^ stepValue 
]

{ #category : #accessing }
BlSimpleSlider >> stepValue: aNumber [

	stepValue := aNumber 
	
]

{ #category : #'as yet unclassified' }
BlSimpleSlider >> updateColoredBar [

	self isHorizontal
		ifTrue: [
			coloredBar position:
				bar position.
			coloredBar size:
				(handle position - coloredBar position) x @ barThickness ]
		ifFalse: [
			coloredBar position:
				handle position x - (barThickness / 2) @ handle position y.
			coloredBar size:
				barThickness @ (bar position x + barLength - handle position y) ]
]

{ #category : #protocol }
BlSimpleSlider >> updateValue [

	currentValue := self valueAtCoord: handle position.
	"self announcer announce: BlSliderValueChangedEvent"
	self dispatchEvent: BlSliderValueChangedEvent new.
]

{ #category : #'api - transformations' }
BlSimpleSlider >> valueAtCoord: aPoint [

	^ self isHorizontal
		  ifTrue: [ self valueAtX: aPoint  ]
		  ifFalse: [ self valueAtY: aPoint  ]
]

{ #category : #'api - transformations' }
BlSimpleSlider >> valueAtX: aPoint [

	| dist valueDiff value coeff |
	dist := (aPoint - bar position) x.
	dist = 0
		ifTrue: [ value := minValue ]
		ifFalse: [
			valueDiff := maxValue - minValue.
			coeff := barLength / dist.
			value := minValue + (valueDiff / coeff) ].
	value asFloat traceCr.
	^ value asFloat
]

{ #category : #'api - transformations' }
BlSimpleSlider >> valueAtY: aPoint [

	| dist valueDiff value coeff |
	dist := bar position y + barLength - aPoint y.
	dist = 0
		ifTrue: [ value := minValue ]
		ifFalse: [
			valueDiff := maxValue - minValue.
			coeff := barLength / dist.
			value := minValue + (valueDiff / coeff) ].
	value asFloat traceCr.
	^ value asFloat
]

{ #category : #accessing }
BlSimpleSlider >> widgetSize [ 

	^ widgetSize 
]

{ #category : #accessing }
BlSimpleSlider >> widgetSize: aNumber [

	widgetSize := aNumber.
	self size: aNumber 
]
