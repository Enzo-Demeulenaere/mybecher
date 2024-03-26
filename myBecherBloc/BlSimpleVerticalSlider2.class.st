Class {
	#name : #BlSimpleVerticalSlider2,
	#superclass : #BlElement,
	#instVars : [
		'widgetSize',
		'handle',
		'bar',
		'isHorizontal',
		'minValue',
		'maxValue',
		'stepValue',
		'currentValue',
		'barThickness',
		'barLength'
	],
	#category : #myBecherBloc
}

{ #category : #testing }
BlSimpleVerticalSlider2 class >> alainVisual1 [

	<script>
	| bl |
	bl := self new.
	bl minValue: 0.
	bl maxValue: 20.
	bl stepValue: 1.
	bl sliderPixelMargin: 20.
	bl size: 500 @ 25.
	bl buildSlider.
	bl validatedValueCallback: [ :e | "self changedTimeValue: e" ].
	bl margin: (BlInsets top: 5).
	bl openInSpace.
	bl inspect
]

{ #category : #accessing }
BlSimpleVerticalSlider2 >> bar [
	^ bar
]

{ #category : #accessing }
BlSimpleVerticalSlider2 >> bar: aBlElement [ 
	bar := aBlElement
]

{ #category : #'api - bounds' }
BlSimpleVerticalSlider2 >> barDefaultColor [ 

	^ Color lightGray 
]

{ #category : #accessing }
BlSimpleVerticalSlider2 >> barLength [

	^ barLength
]

{ #category : #accessing }
BlSimpleVerticalSlider2 >> barLength: aNumber [

	barLength := aNumber 
]

{ #category : #accessing }
BlSimpleVerticalSlider2 >> barThickness [ 

	^ barThickness 
]

{ #category : #accessing }
BlSimpleVerticalSlider2 >> barThickness: aNumber [

	barThickness := aNumber 
]

{ #category : #accessing }
BlSimpleVerticalSlider2 >> beHorizontal [

	self horizontal: true.
	self buildHorizontal
]

{ #category : #accessing }
BlSimpleVerticalSlider2 >> beVertical [

	self horizontal: false.
	self buildVertical
]

{ #category : #'as yet unclassified' }
BlSimpleVerticalSlider2 >> buildHorizontal [

	self widgetSize: widgetSize x @ widgetSize y.
	self removeParts.
	self initializeParts
]

{ #category : #'as yet unclassified' }
BlSimpleVerticalSlider2 >> buildVertical [

	self widgetSize: widgetSize y @ widgetSize x.
	self removeParts.
	self initializeParts
]

{ #category : #accessing }
BlSimpleVerticalSlider2 >> currentValue [ 

	^ currentValue 
]

{ #category : #accessing }
BlSimpleVerticalSlider2 >> currentValue: aNumber [

	(aNumber < self minValue or: [ aNumber > self maxValue ]) ifTrue: [ ^ self ].
	currentValue := aNumber
]

{ #category : #'api - bounds' }
BlSimpleVerticalSlider2 >> defaultBar [

	| size |
	size := self isHorizontal
		        ifTrue: [ self defaultLength @ self defaultThickness ]
		        ifFalse: [ self defaultThickness @ self defaultLength ].

	^ BlElement new
		  geometry: (BlRoundedRectangleGeometry cornerRadius: 5);
		  background: self barDefaultColor;
		  size: size;
			position: self defaultMargin asPoint;
		  yourself
]

{ #category : #'api - bounds' }
BlSimpleVerticalSlider2 >> defaultColor [ 

	^ Color lightRed 
]

{ #category : #'api - bounds' }
BlSimpleVerticalSlider2 >> defaultHandle [

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
BlSimpleVerticalSlider2 >> defaultLength [

	^ 200
]

{ #category : #'api - bounds' }
BlSimpleVerticalSlider2 >> defaultMargin [

	^ 10
]

{ #category : #'api - bounds' }
BlSimpleVerticalSlider2 >> defaultSize [
	"self bar size maybe"
	^ (self isHorizontal
		   ifTrue: [ self defaultLength @ self defaultThickness ]
		   ifFalse: [ self defaultThickness @ self defaultLength ])
	  + (2 * self defaultMargin)
]

{ #category : #'api - bounds' }
BlSimpleVerticalSlider2 >> defaultThickness [

	^ 10
]

{ #category : #accessing }
BlSimpleVerticalSlider2 >> handle [
	^ handle
]

{ #category : #accessing }
BlSimpleVerticalSlider2 >> handle: aBlElement [ 
	handle := aBlElement
]

{ #category : #'api - bounds' }
BlSimpleVerticalSlider2 >> handleDefaultColor [ 

	^ Color red
]

{ #category : #accessing }
BlSimpleVerticalSlider2 >> horizontal: aBoolean [

	isHorizontal := aBoolean 
]

{ #category : #initialization }
BlSimpleVerticalSlider2 >> initialize [

	super initialize.
	isHorizontal := true.
	barLength := self defaultLength.
	barThickness := self defaultThickness.
	self widgetSize: self defaultSize.
	self background: self defaultColor.
	self initializeValues.
	self initializeParts
]

{ #category : #initialization }
BlSimpleVerticalSlider2 >> initializeParts [

	self bar: self defaultBar.
	self handle: self defaultHandle.
	self positionDefaultHandle.
	self addChild: self bar.
	self addChild: self handle
]

{ #category : #initialization }
BlSimpleVerticalSlider2 >> initializeValues [ 

	self minValue: 0.
	self maxValue: 50.
	self currentValue: 0
]

{ #category : #accessing }
BlSimpleVerticalSlider2 >> isHorizontal [ 

	^ isHorizontal 
]

{ #category : #accessing }
BlSimpleVerticalSlider2 >> maxValue [

	^ maxValue
]

{ #category : #accessing }
BlSimpleVerticalSlider2 >> maxValue: aNumber [

	maxValue := aNumber
]

{ #category : #accessing }
BlSimpleVerticalSlider2 >> minValue [ 

	^ minValue 
]

{ #category : #accessing }
BlSimpleVerticalSlider2 >> minValue: aNumber [

	minValue := aNumber 
]

{ #category : #'as yet unclassified' }
BlSimpleVerticalSlider2 >> moveHandleTo: aPosition [

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
	self updateValue
]

{ #category : #'as yet unclassified' }
BlSimpleVerticalSlider2 >> positionDefaultHandle [

	self isHorizontal
		ifTrue: [ handle position: self defaultMargin @ (widgetSize y / 2) ]
		ifFalse: [ handle position: widgetSize x / 2 @ (self defaultMargin + barLength) ]
]

{ #category : #removing }
BlSimpleVerticalSlider2 >> removeParts [

	self removeChildren. 
	bar := nil.
	handle := nil
]

{ #category : #'api - bounds' }
BlSimpleVerticalSlider2 >> size: aValue [
	"just to keep the widgset size"

	super size: aValue.
	
	" for now do not support resize
	
	self isBuildSlider ifTrue: [ self rebuildSlider ]
	"
]

{ #category : #accessing }
BlSimpleVerticalSlider2 >> stepValue [

	^ stepValue 
]

{ #category : #accessing }
BlSimpleVerticalSlider2 >> stepValue: aNumber [

	stepValue := aNumber 
	
]

{ #category : #protocol }
BlSimpleVerticalSlider2 >> updateValue [

	| value |
	value := self valueAtCoord: handle position.
]

{ #category : #'api - transformations' }
BlSimpleVerticalSlider2 >> valueAtCoord: aPoint [

	^ self isHorizontal
		  ifTrue: [ self valueAtX: aPoint  ]
		  ifFalse: [ self valueAtY: aPoint  ]
]

{ #category : #'api - transformations' }
BlSimpleVerticalSlider2 >> valueAtX: aPoint [

	| dist valueDiff value coeff |
	dist := (aPoint - bar position) x.
	dist = 0
		ifTrue: [ value := minValue ]
		ifFalse: [
			valueDiff := maxValue - minValue.
			coeff := barLength / dist.
			value := minValue + (valueDiff / coeff) ].
	 value asFloat traceCr
]

{ #category : #'api - transformations' }
BlSimpleVerticalSlider2 >> valueAtY: aPoint [

	| dist valueDiff value coeff |
	dist := (bar position y + barLength) - aPoint y.
	dist = 0
		ifTrue: [ value := minValue ]
		ifFalse: [
			valueDiff := maxValue - minValue.
			coeff := barLength / dist.
			value := minValue + (valueDiff / coeff) ].
	value asFloat traceCr
]

{ #category : #'api - transformations' }
BlSimpleVerticalSlider2 >> valueToCoord: aValue [

	^ self isHorizontal
		  ifTrue: [ self valueToX: aValue ]
		  ifFalse: [ self valueToY: aValue ]
]

{ #category : #'api - transformations' }
BlSimpleVerticalSlider2 >> valueToX: aValue [

	| current total coeff |
	current := aValue - self minValue.
	total := self maxValue - self minValue.
	coeff := current / total.
	^ 
		  (self bar constraints horizontal resizer size * coeff
			   roundTo: 1)
]

{ #category : #'api - transformations' }
BlSimpleVerticalSlider2 >> valueToY: aValue [

	| current total coeff |
	current := aValue - self minValue.
	total := self maxValue - self minValue.
	coeff := current / total.
	^ (self bar constraints vertical resizer size * coeff
			   roundTo: 1)
]

{ #category : #accessing }
BlSimpleVerticalSlider2 >> widgetSize [ 

	^ widgetSize 
]

{ #category : #accessing }
BlSimpleVerticalSlider2 >> widgetSize: aNumber [

	widgetSize := aNumber.
	self size: aNumber 
]
