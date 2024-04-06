"
I'm a copy of the segmented Slider to play with it.
I have a useless interactionRectangle. Do not use me. 
Here just for archival purposes
"
Class {
	#name : #BlOriginalSegmentedSlider,
	#superclass : #BlElement,
	#instVars : [
		'minValue',
		'maxValue',
		'stepValue',
		'sliderPixelMargin',
		'currentValue',
		'validatedValue',
		'validatedValueCallback',
		'sliderBar',
		'sliderInteractor',
		'sliderInteractionRectangle',
		'sliderBackground',
		'disabledRebuilding',
		'sliderEventHandlerList',
		'widgetSize',
		'interactorPushedPoint',
		'maxPixelDistance',
		'enumeratedValues',
		'enumeratedColors',
		'initColor',
		'endColor',
		'barThickness',
		'isHorizontal'
	],
	#category : #myBecherBloc
}

{ #category : #testing }
BlOriginalSegmentedSlider class >> alainVisual1 [

	<script>
	| bl |
	bl := self new.
	bl minValue: 0.
	bl maxValue: 20.
	bl stepValue: 1.
	bl enumeratedValues: #( 0 5 10 15 20 ).
	bl sliderPixelMargin: 20.
	bl size: 500 @ 25.
	bl buildSlider.
	bl validatedValueCallback: [ :e | "self changedTimeValue: e" ].
	bl margin: (BlInsets top: 5).
	bl openInSpace.
	bl inspect
]

{ #category : #testing }
BlOriginalSegmentedSlider class >> alainVisual2 [

	<script>
	| bl2 |
	bl2 := self new.
	bl2 enumeratedColors: {
			Color lightBlue.
			Color blue.
			Color orange.
			Color red }.
	bl2 position: 0 @ 20.
	bl2 minValue: 50.
	bl2 maxValue: 200.
	bl2 stepValue: 50.
	bl2 size: 550 @ 48.
	bl2 sliderPixelMargin: 35.
	bl2 buildSlider.
	bl2 validatedValueCallback: [ :e | "self changedOperationalActivityValue: e"
		 ].
	bl2 openInSpace
]

{ #category : #building }
BlOriginalSegmentedSlider class >> backgroundDefaultColor [

	^ Color gray
]

{ #category : #building }
BlOriginalSegmentedSlider class >> barDefaultColor [

	^ Color blue 
]

{ #category : #building }
BlOriginalSegmentedSlider class >> defaultMaxPixelDistance [

	^ 25
]

{ #category : #building }
BlOriginalSegmentedSlider class >> interactionDefaultColor [

	^ Color pink alpha: 0.5
]

{ #category : #building }
BlOriginalSegmentedSlider class >> interactorDefaultColor [

	^ Color red 
]

{ #category : #testing }
BlOriginalSegmentedSlider class >> visualTest1 [

	<script>
	| bl space val |
	bl := self new.
	bl minValue: 55.
	bl maxValue: 75.
	bl stepValue: 5.
	bl buildSlider.
	space := bl openInNewSpace.
	space windowExtent: 1920 @ 1050.
	space setPosition: 0 @ 30.
	val := space -> bl.
	^ val
]

{ #category : #testing }
BlOriginalSegmentedSlider class >> visualTest2 [

	<script>
	| bl space val |
	bl := self new.
	bl minValue: 10.
	bl maxValue: 50.
	bl stepValue: 1.
	bl buildSlider.
	space := bl openInNewSpace.
	space windowExtent: 1920 @ 1050.
	space setPosition: 0 @ 30.
	val := space -> bl.
"	bl validatedValueCallback: [ :e | e inspect ]."
	val inspect.
	^ val
]

{ #category : #testing }
BlOriginalSegmentedSlider class >> visualTest3 [

	<script>
	| bl space val |
	bl := self new.
	bl minValue: 10.
	bl maxValue: 50.
	bl stepValue: 0.1.
	bl buildSlider.
	space := bl openInNewSpace.
	space windowExtent: 1920 @ 1050.
	space setPosition: 0 @ 30.
	val := space -> bl.
	bl validatedValueCallback: [ :e | e inspect ].
	val inspect.
	^ val
]

{ #category : #testing }
BlOriginalSegmentedSlider class >> visualTestVertical1 [

	<script>
	| bl space val |
	bl := self new.
	bl minValue: 10.
	bl maxValue: 50.
	bl stepValue: 1.
	bl buildSlider.
	space := bl openInNewSpace.
	space windowExtent: 1920 @ 1050.
	space setPosition: 0 @ 30.
	val := space -> bl.
	bl validatedValueCallback: [ :e | e inspect ].
	val inspect.
	^ val
]

{ #category : #private }
BlOriginalSegmentedSlider >> addSliderEventHandler: aAssoc [

	('addSliderEventHandler: with' , aAssoc printString) traceCr.
	sliderEventHandlerList add: aAssoc
]

{ #category : #accessing }
BlOriginalSegmentedSlider >> barThickness [

	^ barThickness
]

{ #category : #accessing }
BlOriginalSegmentedSlider >> barThickness: anObject [

	barThickness := anObject
]

{ #category : #accessing }
BlOriginalSegmentedSlider >> beHorizontal [  

	self horizontal: true.
]

{ #category : #accessing }
BlOriginalSegmentedSlider >> beVertical [ 

	self horizontal: false
]

{ #category : #'private - building' }
BlOriginalSegmentedSlider >> buildDefaultHandle [

	| bl pt |
	pt := 20 @ 20.
	bl := BlElement new
		      geometry: BlCircleGeometry new;
		      background: self class interactorDefaultColor;
		      size: pt;
		      transformDo: [ :t | t translateBy: pt negated / 2 ].
	^ bl
]

{ #category : #'as yet unclassified' }
BlOriginalSegmentedSlider >> buildForeground [ 

	
	| fgElt |
	fgElt := BlElement new.
	fgElt id: #sliderInteractionForeground.
	fgElt size: self widgetSize.
	fgElt background: self class interactionDefaultColor.
	fgElt zIndex: 50.
	self addChild: fgElt.
	self sliderInteractionRectangle: fgElt.
]

{ #category : #'as yet unclassified' }
BlOriginalSegmentedSlider >> buildHorizontalBackground [

	| bgElt |
	bgElt := BlElement new.
	bgElt size:
		self widgetSize x - (2 * self sliderPixelMargin) @ barThickness.
	bgElt id: #sliderBackground.
	bgElt position: self sliderPixelMargin
		@ (self widgetSize y / 2 - (barThickness / 2)).
	bgElt background: self class backgroundDefaultColor.
	bgElt zIndex: 0.
	self addChild: bgElt.
	self sliderBackground: bgElt
]

{ #category : #'as yet unclassified' }
BlOriginalSegmentedSlider >> buildHorizontalBar [

	| bar |
	bar := BlElement new.
	bar size:
		(self valueToCoord: currentValue)
		- (self sliderPixelMargin) @ barThickness.
	bar id: #sliderBar.
	bar position: self sliderPixelMargin
		@ (self widgetSize y / 2 - (barThickness / 2)).
	bar background: self class barDefaultColor.
	bar zIndex: 2.
	self addChild: bar.
	self sliderBar: bar
]

{ #category : #'as yet unclassified' }
BlOriginalSegmentedSlider >> buildHorizontalHandle [ 

	| handle pt |
	handle := self buildDefaultHandle.
	handle id: #sliderHandle.
	pt := (self valueToCoord: currentValue)
	      @ (self widgetSize y / 2).
	handle position: pt.
	handle zIndex: 3.
	self addChild: handle.
	self sliderHandle: handle
]

{ #category : #'private - building' }
BlOriginalSegmentedSlider >> buildHorizontalSlider [

	self buildForeground.
	self buildHorizontalBackground.
	self buildHorizontalBar.
	self buildHorizontalHandle
]

{ #category : #'changing state' }
BlOriginalSegmentedSlider >> buildOrientation [

	self removeAllShapes.
	self size: self widgetSize.
	self isHorizontal
		ifTrue: [ self buildHorizontalSlider ]
		ifFalse: [ self buildVerticalSlider ].
	self initializeEventHandlers
]

{ #category : #'api - slider' }
BlOriginalSegmentedSlider >> buildSlider [

	self buildOrientation.
	self initializeEventHandlers
]

{ #category : #'private - building' }
BlOriginalSegmentedSlider >> buildVerticalSlider [

	| fgElt bgElt bar handle pt pt1 pt2 |
	"foreground"
	fgElt := BlElement new.
	fgElt id: #sliderForeground.
	fgElt size: self widgetSize.

	fgElt background: self class interactionDefaultColor.
	fgElt zIndex: 50.
	self addChild: fgElt.
	self sliderInteractionRectangle: fgElt.

	"background"
	bgElt := BlElement new.
	pt1 :=  barThickness
	       @ (self widgetSize y - (2 * self sliderPixelMargin)).
	bgElt size: pt1.
	bgElt id: #sliderBackground.
	pt2 := self widgetSize x / 2 - ( barThickness / 2)
	       @ self sliderPixelMargin.
	bgElt position: pt2.
	bgElt background: self class backgroundDefaultColor.
	bgElt zIndex: 0.
	self addChild: bgElt.
	self sliderBackground: bgElt.

	"bar"
	bar := BlElement new.
	bar size: barThickness
		@ (self widgetSize y - (self valueToCoord: currentValue)
			 - self sliderPixelMargin).
	bar id: #sliderBar.
	bar position: self widgetSize x / 2 - (barThickness / 2)
		@ (self valueToCoord: currentValue).
	bar background: self class barDefaultColor.
	bar zIndex: 2.
	self addChild: bar.
	self sliderBar: bar.

	"interactor"
	handle := self buildDefaultHandle.
	handle id: #sliderHandle.
	pt := self widgetSize x / 2 @ (self valueToCoord: currentValue).
	handle position: pt.
	handle zIndex: 3.
	self addChild: handle.
	self sliderHandle: handle
]

{ #category : #'changing state' }
BlOriginalSegmentedSlider >> changedCurrentValue: aValue [

^self changedCurrentValue: aValue withSlider: false
]

{ #category : #'changing state' }
BlOriginalSegmentedSlider >> changedCurrentValue: aValue withSlider: aBool [

	| v color |
	v := self valueToCoord: aValue.
	self isHorizontal 
		ifTrue: [
			aBool ifTrue: [
				self sliderHandle ifNotNil: [ :sl |
					sl position: v @ sl constraints position y ] ].
			self sliderBar size:
				v - self sliderPixelMargin @ self sliderBar size y ]
		ifFalse: [
			aBool ifTrue: [
				self sliderHandle ifNotNil: [ :sl |
					sl position: sl constraints position x @ v ] ].
			self sliderBar size: barThickness
				@ (self widgetSize y - (self valueToCoord: currentValue)
					 - self sliderPixelMargin).
			self sliderBar position:
				self widgetSize x / 2 - (barThickness / 2)
				@ (self valueToCoord: currentValue) ].
	color := self colorForValue: aValue.
	self sliderHandle background: color.
	self sliderBar background: color
]

{ #category : #'changing state' }
BlOriginalSegmentedSlider >> changedCursorPosition: v [

	self isHorizontal 
		ifTrue: [
			self sliderHandle ifNotNil: [ :sl |
				sl position: v @ sl constraints position y ] ]
		ifFalse: [
			self sliderHandle ifNotNil: [ :sl |
				sl position: sl constraints position x @ v ] ]
]

{ #category : #private }
BlOriginalSegmentedSlider >> cleanSliderParts [

	sliderInteractionRectangle := nil.
	sliderBackground := nil.
	sliderBar := nil.
	sliderInteractor := nil
]

{ #category : #private }
BlOriginalSegmentedSlider >> colorForValue: aValue [

	| i |
	self enumeratedColors
		ifNil: [
			^ endColor
				  mixed: (self proportionOf: aValue)
				  with: self initColor ]
		ifNotNil: [ :list |
			i := self enumeratedValues indexOf: aValue.
			i = 0 ifTrue: [ ^ self initColor ].
			(i > list size) ifTrue: [ ^ endColor ].
			^list at: i ]
]

{ #category : #private }
BlOriginalSegmentedSlider >> currentValue [

	^ currentValue
]

{ #category : #private }
BlOriginalSegmentedSlider >> currentValue: aNumber [

	(aNumber <= maxValue and: [ aNumber >= minValue ]) ifFalse: [
		^ self ].
	currentValue := aNumber.
	self changedCurrentValue: aNumber
]

{ #category : #'api - slider' }
BlOriginalSegmentedSlider >> decrementValue [

	self decrementValue: self stepValue.
]

{ #category : #'api - slider' }
BlOriginalSegmentedSlider >> decrementValue: aValue [

	| tmp |
	tmp := validatedValue - aValue.
	tmp < self maxValue ifTrue: [ self validatedValue: tmp ]
]

{ #category : #accessing }
BlOriginalSegmentedSlider >> disabledRebuilding [

	^ disabledRebuilding
]

{ #category : #accessing }
BlOriginalSegmentedSlider >> disabledRebuilding: anObject [

	disabledRebuilding := anObject
]

{ #category : #accessing }
BlOriginalSegmentedSlider >> endColor [

	^ endColor
]

{ #category : #accessing }
BlOriginalSegmentedSlider >> endColor: anObject [

	endColor := anObject
]

{ #category : #accessing }
BlOriginalSegmentedSlider >> enumeratedColors [

	^ enumeratedColors
]

{ #category : #accessing }
BlOriginalSegmentedSlider >> enumeratedColors: anObject [

	enumeratedColors := anObject
]

{ #category : #'api - values' }
BlOriginalSegmentedSlider >> enumeratedValues [
	"since the enumerated value are derived from min, max and step, we lazy initialize it."
	
	enumeratedValues ifNil: [
		enumeratedValues := (self minValue to: self maxValue by:
		                     self stepValue) asOrderedCollection ].
	^ enumeratedValues
]

{ #category : #accessing }
BlOriginalSegmentedSlider >> enumeratedValues: anObject [

	enumeratedValues := anObject
]

{ #category : #accessing }
BlOriginalSegmentedSlider >> horizontal: aBoolean [

	isHorizontal := aBoolean 
]

{ #category : #'api - slider' }
BlOriginalSegmentedSlider >> incrementValue [

	self incrementValue: self stepValue
]

{ #category : #'api - slider' }
BlOriginalSegmentedSlider >> incrementValue: aValue [

	| tmp |
	tmp := validatedValue + aValue.
	tmp < self maxValue ifTrue: [ self validatedValue: tmp ]
]

{ #category : #accessing }
BlOriginalSegmentedSlider >> initColor [

	^ initColor
]

{ #category : #accessing }
BlOriginalSegmentedSlider >> initColor: anObject [

	initColor := anObject
]

{ #category : #initialization }
BlOriginalSegmentedSlider >> initialize [

	super initialize.
	barThickness := 8.
	maxValue := 100.0.
	minValue := 0.0.
	self size: 300 @ 30.
	currentValue := 0.0.
	self beHorizontal.
	sliderPixelMargin := 5.
	disabledRebuilding := false.
	stepValue := 1.
	sliderEventHandlerList := OrderedCollection new.
	endColor := self class interactorDefaultColor.
	initColor := self class interactorDefaultColor.
	maxPixelDistance := self class defaultMaxPixelDistance
]

{ #category : #initialization }
BlOriginalSegmentedSlider >> initializeEventHandlers [

	| bl |
	self isSliderBuilt ifFalse: [
		^ self error: 'The slider must be built first' ].
	bl := self sliderInteractionRectangle.
	self
		whenEvent: BlMouseDownEvent
		on: bl
		do: [ :event | self sliderHandlePushed: event ].
	self
		whenEvent: BlDragEndEvent
		on: bl
		do: [ :event | self sliderHandleReleased: event ].
	self
		whenEvent: BlMouseUpEvent
		on: bl
		do: [ :event | self sliderHandleReleased: event ].
	self
		whenEvent: BlMouseMoveEvent
		on: bl
		do: [ :event | self sliderHandleMoved: event ].
	self
		whenEvent: BlClickEvent
		on: bl
		do: [ :event | self sliderBarClicked: event ]
]

{ #category : #initialization }
BlOriginalSegmentedSlider >> initializeSpaceEventHandlers [

	self space
		addEventHandlerOn: BlMouseUpEvent
		do: [ :event | self sliderHandleReleased: event ]
]

{ #category : #accessing }
BlOriginalSegmentedSlider >> interactorPushedPoint [

	^ interactorPushedPoint
]

{ #category : #accessing }
BlOriginalSegmentedSlider >> interactorPushedPoint: anObject [

	interactorPushedPoint := anObject
]

{ #category : #private }
BlOriginalSegmentedSlider >> is: aValue near: aValue2 [

	^(aValue - aValue2) abs < self maxPixelDistance
]

{ #category : #accessing }
BlOriginalSegmentedSlider >> isHorizontal [ 

	^ isHorizontal 
]

{ #category : #'private - building' }
BlOriginalSegmentedSlider >> isSliderBuilt [
	"if no interactor, no slider"

	^ self sliderHandle isNotNil
]

{ #category : #accessing }
BlOriginalSegmentedSlider >> maxPixelDistance [

	^ maxPixelDistance 
]

{ #category : #accessing }
BlOriginalSegmentedSlider >> maxPixelDistance: anObject [

	maxPixelDistance := anObject
]

{ #category : #'api - values' }
BlOriginalSegmentedSlider >> maxValue [

	^ maxValue
]

{ #category : #'api - values' }
BlOriginalSegmentedSlider >> maxValue: anObject [
	"when we change the maxValue, we rebuilding the enumerated values and slider"

	maxValue := anObject.
	enumeratedValues := nil.
	self isSliderBuilt ifTrue: [ self rebuildSlider ]
]

{ #category : #'api - values' }
BlOriginalSegmentedSlider >> minValue [

	^ minValue
]

{ #category : #'api - values' }
BlOriginalSegmentedSlider >> minValue: anObject [

	minValue := anObject.
	enumeratedValues := nil.
	currentValue < minValue ifTrue: [ currentValue := minValue copy ].
	self isSliderBuilt ifTrue: [ self rebuildSlider ]
]

{ #category : #'api - values' }
BlOriginalSegmentedSlider >> nearestValue: aValue [

	| val minResult tmp tmp2 |
	self enumeratedValues ifNil: [ ^ aValue ].
	self enumeratedValues isEmpty ifTrue: [ ^ aValue ].
	val := self enumeratedValues first.
	minResult := (aValue - val) abs.
	2 to: enumeratedValues size do: [ :e |
		tmp := self enumeratedValues at: e.
		tmp2 := (aValue - tmp) abs.
		tmp2 < minResult ifTrue: [
			minResult := tmp2.
			val := tmp ] ].
	^ val
]

{ #category : #'api - transformations' }
BlOriginalSegmentedSlider >> pointToValue: point [

	^ self isHorizontal 
		  ifTrue: [ self pointToXValue: point ]
		  ifFalse: [ self pointToYValue: point ]
]

{ #category : #'api - transformations' }
BlOriginalSegmentedSlider >> pointToXValue: point [

	| facteur valeur |
	facteur := point x / self sliderBackground size x.
	valeur := self maxValue - self minValue * facteur.
	valeur := (valeur roundTo: (self stepValue ifNil: [ 1 ]))
	          + self minValue.
	valeur := self nearestValue: valeur.
	^ valeur
]

{ #category : #'api - transformations' }
BlOriginalSegmentedSlider >> pointToYValue: point [

	| facteur valeur |
	facteur := 1 - (point y / self sliderBackground size y).
	valeur := self maxValue - self minValue * facteur.
	valeur := (valeur roundTo: (self stepValue ifNil: [ 1 ]))
	          + self minValue.
	valeur := self nearestValue: valeur.
	^ valeur
]

{ #category : #private }
BlOriginalSegmentedSlider >> proportionOf: aValue [
	| i |
	i := self enumeratedValues indexOf: aValue.
	^ (i/self enumeratedValues size)
]

{ #category : #'private - building' }
BlOriginalSegmentedSlider >> rebuildSlider [

	self disabledRebuilding ifTrue: [ ^ self ].
	self buildOrientation
]

{ #category : #private }
BlOriginalSegmentedSlider >> removeAllShapes [

	| list |
	list := self sliderParts.
	self removeAllSliderEventHandlers.
	self removeChildren: list.
	self cleanSliderParts
]

{ #category : #private }
BlOriginalSegmentedSlider >> removeAllSliderEventHandlers [
	sliderEventHandlerList traceCr.
	sliderEventHandlerList do: [ :e | e key removeEventHandler: e value ].
	sliderEventHandlerList := OrderedCollection new
]

{ #category : #'api - slider' }
BlOriginalSegmentedSlider >> setMaxValue [

	self setValue: self maxValue.
]

{ #category : #'api - slider' }
BlOriginalSegmentedSlider >> setMinValue [

	self setValue: self minValue
]

{ #category : #'api - slider' }
BlOriginalSegmentedSlider >> setValue: aValue [

	(aValue < self maxValue and: [ aValue > self minValue ]) ifTrue: [
		self validatedValue: aValue ].
]

{ #category : #'api - bounds' }
BlOriginalSegmentedSlider >> size: aValue [

	super size: aValue.
	self widgetSize: aValue.
	self isSliderBuilt ifTrue: [ self rebuildSlider ]
]

{ #category : #accessing }
BlOriginalSegmentedSlider >> sliderBackground [

	^ sliderBackground
]

{ #category : #accessing }
BlOriginalSegmentedSlider >> sliderBackground: anObject [

	sliderBackground := anObject
]

{ #category : #accessing }
BlOriginalSegmentedSlider >> sliderBar [

	^ sliderBar
]

{ #category : #accessing }
BlOriginalSegmentedSlider >> sliderBar: anObject [

	sliderBar := anObject
]

{ #category : #'events - bar' }
BlOriginalSegmentedSlider >> sliderBarClicked: event [

	| tmp val |
	tmp := self sliderBackground globalPointToLocal: event position.
	val := self pointToValue: tmp.
	self validatedValue: val.
]

{ #category : #accessing }
BlOriginalSegmentedSlider >> sliderHandle [

	^ sliderInteractor
]

{ #category : #accessing }
BlOriginalSegmentedSlider >> sliderHandle: anObject [

	sliderInteractor := anObject
]

{ #category : #'events - interactor' }
BlOriginalSegmentedSlider >> sliderHandleMoved: event [

	| val tmp v |
	self interactorPushedPoint ifNil: [ ^ self ].
	tmp := self sliderBackground globalPointToLocal: event position.
	val := self pointToValue: tmp.
	tmp := self globalPointToLocal: event position.
	self isHorizontal
		ifTrue: [
			v := tmp x.
			v := v min: (self valueToX: self maxValue).
			v := v max: (self valueToX: self minValue) ]
		ifFalse: [
			v := tmp y.
			v := v min: (self valueToY: self minValue).
			v := v max: (self valueToY: self maxValue) ].

	self changedCursorPosition: v.
	self currentValue: val
]

{ #category : #'events - interactor' }
BlOriginalSegmentedSlider >> sliderHandlePushed: event [

	| value pt1 pt2 |
	self sliderBar ifNil: [ ^ self ].
	value := self pointToValue:
		         (self sliderBackground globalPointToLocal: event position).
	pt1 := self valueToX: value.
	pt2 := self valueToX: currentValue.
	(self is: pt1 near: pt2) ifTrue: [
		self interactorPushedPoint: event position copy ]
]

{ #category : #'events - interactor' }
BlOriginalSegmentedSlider >> sliderHandleReleased: event [

	self interactorPushedPoint isNil ifTrue: [ ^ self ].
	self interactorPushedPoint: nil.
	self validatedValue: currentValue
]

{ #category : #accessing }
BlOriginalSegmentedSlider >> sliderInteractionRectangle [

	^ sliderInteractionRectangle
]

{ #category : #accessing }
BlOriginalSegmentedSlider >> sliderInteractionRectangle: anObject [

	sliderInteractionRectangle := anObject
]

{ #category : #private }
BlOriginalSegmentedSlider >> sliderParts [

	| oc |
	oc := OrderedCollection new.
	self sliderInteractionRectangle ifNotNil: [ :e | oc add: e ].
	self sliderBackground ifNotNil: [ :e | oc add: e ].
	self sliderBar ifNotNil: [ :e | oc add: e ].
	self sliderHandle ifNotNil: [ :e | oc add: e ].
	^ oc
]

{ #category : #accessing }
BlOriginalSegmentedSlider >> sliderPixelMargin [

	^ sliderPixelMargin 
]

{ #category : #accessing }
BlOriginalSegmentedSlider >> sliderPixelMargin: anObject [

	sliderPixelMargin := anObject.
	self isSliderBuilt ifTrue: [ 
		self rebuildSlider ]
]

{ #category : #'api - space' }
BlOriginalSegmentedSlider >> space: aSpace [
	super space: aSpace.
	self initializeSpaceEventHandlers
]

{ #category : #'api - values' }
BlOriginalSegmentedSlider >> stepValue [

	^ stepValue
]

{ #category : #'api - values' }
BlOriginalSegmentedSlider >> stepValue: anObject [

	stepValue := anObject.
	enumeratedValues := nil.
]

{ #category : #'api - values' }
BlOriginalSegmentedSlider >> validatedValue [

	^ validatedValue
]

{ #category : #'api - values' }
BlOriginalSegmentedSlider >> validatedValue: aValue [

	currentValue := aValue.
	self changedCurrentValue: aValue withSlider: true. 
	validatedValue := aValue.
	self validatedValueCallback ifNotNil: [ :e | e value: validatedValue ]
]

{ #category : #private }
BlOriginalSegmentedSlider >> validatedValueCallback [

	^ validatedValueCallback
]

{ #category : #'api - values' }
BlOriginalSegmentedSlider >> validatedValueCallback: anObject [

	validatedValueCallback := anObject
]

{ #category : #'api - transformations' }
BlOriginalSegmentedSlider >> valueToCoord: aValue [

	^ self isHorizontal 
		  ifTrue: [ self valueToX: aValue ]
		  ifFalse: [ self valueToY: aValue ]
]

{ #category : #'api - transformations' }
BlOriginalSegmentedSlider >> valueToX: aValue [

	| current total coeff |
	current := aValue - self minValue.
	total := self maxValue - self minValue.
	coeff := current / total.
	^ self sliderPixelMargin
	  + (self sliderBackground constraints horizontal resizer size * coeff roundTo: 1)
]

{ #category : #'api - transformations' }
BlOriginalSegmentedSlider >> valueToY: aValue [

	| valeurCourante valeurTotale facteur |
	valeurCourante := aValue - self minValue.
	valeurTotale := self maxValue - self minValue.
	facteur := 1 - (valeurCourante / valeurTotale).
	^ self sliderPixelMargin
	  +
		  (self sliderBackground constraints vertical resizer size * facteur
			   roundTo: 1)
]

{ #category : #private }
BlOriginalSegmentedSlider >> whenEvent: anEventClass do: aBlock [

	| anEventHandler |
	anEventHandler := BlEventHandler
		                  on: anEventClass
		                  do: aBlock.
	self addSliderEventHandler: self->anEventHandler.
	self addEventHandler: anEventHandler
]

{ #category : #private }
BlOriginalSegmentedSlider >> whenEvent: anEventClass on: aBlElement do: aBlock [

	| anEventHandler |
	anEventHandler := BlEventHandler
		                  on: anEventClass
		                  do: aBlock.
	self addSliderEventHandler: aBlElement -> anEventHandler.
	aBlElement addEventHandler: anEventHandler
]

{ #category : #accessing }
BlOriginalSegmentedSlider >> widgetSize [

	^ widgetSize
]

{ #category : #private }
BlOriginalSegmentedSlider >> widgetSize: anObject [

	widgetSize := anObject
]
