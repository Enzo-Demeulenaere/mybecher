Class {
	#name : #BlBatchingSlider,
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
		'sliderDecorations',
		'orientation',
		'disabledRebuilding',
		'sliderEventHandlerList',
		'barHeight',
		'widgetSize',
		'interactorPushedPoint',
		'maxPixelDistance',
		'enumeratedValues',
		'enumeratedColors',
		'initColor',
		'endColor'
	],
	#category : #myBecherBloc
}

{ #category : #testing }
BlBatchingSlider class >> alainVisual1 [

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
BlBatchingSlider class >> alainVisual2 [

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
	bl2 orientation: #vertical.
	bl2 buildSlider.
	bl2 validatedValueCallback: [ :e | "self changedOperationalActivityValue: e"
		 ].
	bl2 openInSpace
]

{ #category : #building }
BlBatchingSlider class >> backgroundDefaultColor [

	^ Color gray
]

{ #category : #building }
BlBatchingSlider class >> barDefaultColor [

	^ Color blue 
]

{ #category : #building }
BlBatchingSlider class >> defaultMaxPixelDistance [

	^ 25
]

{ #category : #building }
BlBatchingSlider class >> interactionDefaultColor [

	^ Color pink alpha: 0
]

{ #category : #building }
BlBatchingSlider class >> interactorDefaultColor [

	^ Color red 
]

{ #category : #testing }
BlBatchingSlider class >> visualTest1 [

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
	val inspect.
	^val.
]

{ #category : #testing }
BlBatchingSlider class >> visualTest2 [

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
BlBatchingSlider class >> visualTest3 [

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

{ #category : #testing }
BlBatchingSlider class >> visualTestVertical1 [

	<script>
	| bl space val |
	bl := self new.
	bl minValue: 10.
	bl maxValue: 50.
	bl stepValue: 1.
	bl orientation: #vertical.
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
BlBatchingSlider >> addSliderEventHandler: aAssoc [

	sliderEventHandlerList add: aAssoc
]

{ #category : #accessing }
BlBatchingSlider >> barHeight [

	^ barHeight
]

{ #category : #accessing }
BlBatchingSlider >> barHeight: anObject [

	barHeight := anObject
]

{ #category : #'private - building' }
BlBatchingSlider >> buildDefaultInteractor [

	| bl pt |
	pt := 20 @ 20.
	bl := BlElement new
		      geometry: BlCircleGeometry new;
		      background: self class interactorDefaultColor;
		      size: pt;
		      transformDo: [ :t | t translateBy: pt negated / 2 ].
	^ bl
]

{ #category : #'private - building' }
BlBatchingSlider >> buildHorizontalSlider [

	| bl pt |
	"foreground"
	bl := BlElement new.
	bl id: #sliderForeground.
	bl size: self widgetSize.
	bl background: self class interactionDefaultColor.
	bl zIndex: 50.
	self addChild: bl.
	self sliderInteractionRectangle: bl.

	"background"
	bl := BlElement new.
	bl size:
		self widgetSize x - (2 * self sliderPixelMargin) @ self barHeight.
	bl id: #sliderBackground.
	bl position: self sliderPixelMargin
		@ (self widgetSize y / 2 - (self barHeight / 2)).
	bl background: self class backgroundDefaultColor.
	bl zIndex: 0.
	self addChild: bl.
	self sliderBackground: bl.

	"bar"
	bl := BlElement new.
	bl size:
		(self valueToCoord: self currentValue)
		- (1 * self sliderPixelMargin) @ self barHeight.
	bl id: #sliderBar.
	bl position: self sliderPixelMargin
		@ (self widgetSize y / 2 - (self barHeight / 2)).
	bl background: self class barDefaultColor.
	bl zIndex: 2.
	self addChild: bl.
	self sliderBar: bl.

	"interactor"
	bl := self buildDefaultInteractor.
	bl id: #sliderInteractor.
	pt := (self valueToCoord: self currentValue)
	      @ (self widgetSize y / 2).
	bl position: pt.
	bl zIndex: 3.
	self addChild: bl.
	self sliderInteractor: bl
]

{ #category : #'api - slider' }
BlBatchingSlider >> buildSlider [
	
		self changeOrientation: self orientation.
		self initializeEventHandlers.
]

{ #category : #'private - building' }
BlBatchingSlider >> buildVerticalSlider [

	| bl pt pt1 pt2 |
	"foreground"
	bl := BlElement new.
	bl id: #sliderForeground.
	bl size: self widgetSize.

	bl background: self class interactionDefaultColor.
	bl zIndex: 50.
	self addChild: bl.
	self sliderInteractionRectangle: bl.

	"background"
	bl := BlElement new.
	pt1 := self barHeight
	       @ (self widgetSize y - (2 * self sliderPixelMargin)).
	bl size: pt1.
	bl id: #sliderBackground.
	pt2 := self widgetSize x / 2 - (self barHeight / 2)
	       @ self sliderPixelMargin.
	bl position: pt2.
	bl background: self class backgroundDefaultColor.
	bl zIndex: 0.
	self addChild: bl.
	self sliderBackground: bl.

	"bar"
	bl := BlElement new.
	bl size: self barHeight
		@ (self widgetSize y - (self valueToCoord: self currentValue)
			 - self sliderPixelMargin).
	bl id: #sliderBar.
	bl position: self widgetSize x / 2 - (self barHeight / 2)
		@ (self valueToCoord: self currentValue).
	bl background: self class barDefaultColor.
	bl zIndex: 2.
	self addChild: bl.
	self sliderBar: bl.

	"interactor"
	bl := self  buildDefaultInteractor.
	bl id: #sliderInteractor.
	pt := self widgetSize x / 2 @ (self valueToCoord: self currentValue).
	bl position: pt.
	bl zIndex: 3.
	self addChild: bl.
	self sliderInteractor: bl
]

{ #category : #'changing state' }
BlBatchingSlider >> changeOrientation: aSymbol [

	self removeAllShapes.
	aSymbol = #horizontal ifTrue: [
		self size: self widgetSize.
		self buildHorizontalSlider.
		^self initializeEventHandlers. ].
	aSymbol = #vertical ifTrue: [
		self size: self widgetSize.
		self buildVerticalSlider.
		^self initializeEventHandlers
		 ].
	^ self error: 'Unknown orientation : ' , aSymbol
]

{ #category : #'changing state' }
BlBatchingSlider >> changedCurrentValue: aValue [

^self changedCurrentValue: aValue withSlider: false
]

{ #category : #'changing state' }
BlBatchingSlider >> changedCurrentValue: aValue withSlider: aBool [

	| v color |
	v := self valueToCoord: aValue.
	self orientation = #horizontal
		ifTrue: [
			aBool ifTrue: [
				self sliderInteractor ifNotNil: [ :sl |
					sl position: v @ sl constraints position y ] ].
			self sliderBar size:
				v - self sliderPixelMargin @ self sliderBar size y ]
		ifFalse: [
			aBool ifTrue: [
				self sliderInteractor ifNotNil: [ :sl |
					sl position: sl constraints position x @ v ] ].
			self sliderBar size: self barHeight
				@ (self widgetSize y - (self valueToCoord: self currentValue)
					 - self sliderPixelMargin).
			self sliderBar position:
				self widgetSize x / 2 - (self barHeight / 2)
				@ (self valueToCoord: self currentValue) ].
	color := self colorForValue: aValue.
	self sliderInteractor background: color.
	self sliderBar background: color
]

{ #category : #'changing state' }
BlBatchingSlider >> changedCursorPosition: v [

	self orientation = #horizontal
		ifTrue: [
			self sliderInteractor ifNotNil: [ :sl |
				sl position: v @ sl constraints position y ] ]
		ifFalse: [
			self sliderInteractor ifNotNil: [ :sl |
				sl position: sl constraints position x @ v ] ]
]

{ #category : #private }
BlBatchingSlider >> cleanSliderParts [

	sliderInteractionRectangle := nil.
	sliderBackground := nil.
	sliderDecorations := nil.
	sliderBar := nil.
	sliderInteractor := nil
]

{ #category : #private }
BlBatchingSlider >> colorForValue: aValue [

	| i |
	self enumeratedColors
		ifNil: [
			^ self endColor
				  mixed: (self proportionOf: aValue)
				  with: self initColor ]
		ifNotNil: [ :list |
			i := self enumeratedValues indexOf: aValue.
			i = 0 ifTrue: [ ^ self initColor ].
			(i > list size) ifTrue: [ ^ self endColor ].
			^list at: i ]
]

{ #category : #private }
BlBatchingSlider >> currentValue [

	^ currentValue
]

{ #category : #private }
BlBatchingSlider >> currentValue: aNumber [

	(aNumber <= maxValue and: [ aNumber >= minValue ]) ifFalse: [
		^ self ].
	currentValue := aNumber.
	self changedCurrentValue: aNumber
]

{ #category : #'api - slider' }
BlBatchingSlider >> decrementValue [

	self decrementValue: self stepValue.
]

{ #category : #'api - slider' }
BlBatchingSlider >> decrementValue: aValue [

	| tmp |
	tmp := validatedValue - aValue.
	tmp < self maxValue ifTrue: [ self validatedValue: tmp ]
]

{ #category : #accessing }
BlBatchingSlider >> disabledRebuilding [

	^ disabledRebuilding
]

{ #category : #accessing }
BlBatchingSlider >> disabledRebuilding: anObject [

	disabledRebuilding := anObject
]

{ #category : #accessing }
BlBatchingSlider >> endColor [

	^ endColor
]

{ #category : #accessing }
BlBatchingSlider >> endColor: anObject [

	endColor := anObject
]

{ #category : #accessing }
BlBatchingSlider >> enumeratedColors [

	^ enumeratedColors
]

{ #category : #accessing }
BlBatchingSlider >> enumeratedColors: anObject [

	enumeratedColors := anObject
]

{ #category : #'api - values' }
BlBatchingSlider >> enumeratedValues [

	enumeratedValues ifNil: [
		enumeratedValues := (self minValue to: self maxValue by:
		                     self stepValue) asOrderedCollection ].
	^enumeratedValues 
]

{ #category : #accessing }
BlBatchingSlider >> enumeratedValues: anObject [

	enumeratedValues := anObject
]

{ #category : #'api - slider' }
BlBatchingSlider >> incrementValue [

	self incrementValue: self stepValue
]

{ #category : #'api - slider' }
BlBatchingSlider >> incrementValue: aValue [

	| tmp |
	tmp := validatedValue + aValue.
	tmp < self maxValue ifTrue: [ self validatedValue: tmp ]
]

{ #category : #accessing }
BlBatchingSlider >> initColor [

	^ initColor
]

{ #category : #accessing }
BlBatchingSlider >> initColor: anObject [

	initColor := anObject
]

{ #category : #initialization }
BlBatchingSlider >> initialize [

	super initialize.
	barHeight := 8.
	maxValue := 100.0.
	minValue := 0.0.
	self size: 300 @ 30.
	currentValue := 0.0.
	orientation := #horizontal.
	sliderPixelMargin := 5.
	disabledRebuilding := false.
	stepValue := 1.
	sliderEventHandlerList := OrderedCollection new.
	endColor := self class interactorDefaultColor.
	initColor := self class interactorDefaultColor.
	maxPixelDistance := self class defaultMaxPixelDistance
]

{ #category : #initialization }
BlBatchingSlider >> initializeEventHandlers [

	| bl |
	self isBuildSlider ifFalse: [
		^ self error: 'The slider must be built first' ].
	bl := self sliderInteractionRectangle.
	self
		whenEvent: BlMouseDownEvent
		on: bl
		do: [ :event | self sliderInteractorPushed: event ].
	self
		whenEvent: BlDragEndEvent
		on: bl
		do: [ :event | self sliderInteractorReleased: event ].
	self
		whenEvent: BlMouseUpEvent
		on: bl
		do: [ :event | self sliderInteractorReleased: event ].
	self
		whenEvent: BlMouseMoveEvent
		on: bl
		do: [ :event | self sliderInteractorMoved: event ].
	self
		whenEvent: BlClickEvent
		on: bl
		do: [ :event | self sliderBarClicked: event ]
]

{ #category : #initialization }
BlBatchingSlider >> initializeSpaceEventHandlers [

	self space
		addEventHandlerOn: BlMouseUpEvent
		do: [ :event | self sliderInteractorReleased: event ]
]

{ #category : #accessing }
BlBatchingSlider >> interactorPushedPoint [

	^ interactorPushedPoint
]

{ #category : #accessing }
BlBatchingSlider >> interactorPushedPoint: anObject [

	interactorPushedPoint := anObject
]

{ #category : #private }
BlBatchingSlider >> is: aValue near: aValue2 [

	^(aValue - aValue2) abs < self maxPixelDistance
]

{ #category : #'private - building' }
BlBatchingSlider >> isBuildSlider [
	"if no interactor, no slider"

	^ self sliderInteractor isNil not
]

{ #category : #accessing }
BlBatchingSlider >> maxPixelDistance [

	^ maxPixelDistance 
]

{ #category : #accessing }
BlBatchingSlider >> maxPixelDistance: anObject [

	maxPixelDistance := anObject
]

{ #category : #'api - values' }
BlBatchingSlider >> maxValue [

	^ maxValue
]

{ #category : #'api - values' }
BlBatchingSlider >> maxValue: anObject [
	"when we change the maxValue, we rebuilding the slider"
	
	maxValue := anObject.
	enumeratedValues := nil.
	self isBuildSlider ifTrue: [ 
		self rebuildSlider ]
]

{ #category : #'api - values' }
BlBatchingSlider >> minValue [

	^ minValue
]

{ #category : #'api - values' }
BlBatchingSlider >> minValue: anObject [

	minValue := anObject.
	enumeratedValues := nil.
	self currentValue < minValue ifTrue: [ currentValue := minValue copy ].
	self isBuildSlider ifTrue: [ self rebuildSlider ]
]

{ #category : #'api - values' }
BlBatchingSlider >> nearestValue: aValue [

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

{ #category : #accessing }
BlBatchingSlider >> orientation [

	^ orientation
]

{ #category : #accessing }
BlBatchingSlider >> orientation: anObject [

	self orientation = anObject ifTrue: [ ^ self ].
	self size: self widgetSize transposed.
	orientation := anObject.
	self changeOrientation: anObject
]

{ #category : #'api - transformations' }
BlBatchingSlider >> pointToValue: point [

	^  self orientation = #horizontal
			ifTrue: [ self pointToXValue: point ]
			ifFalse: [ self pointToYValue: point ].
]

{ #category : #'api - transformations' }
BlBatchingSlider >> pointToXValue: point [

	| facteur valeur |
	facteur := point x / self sliderBackground size x.
	valeur := self maxValue - self minValue * facteur.
	valeur := (valeur roundTo: (self stepValue ifNil: [ 1 ]))
	          + self minValue.
	valeur := self nearestValue: valeur.
	^ valeur
]

{ #category : #'api - transformations' }
BlBatchingSlider >> pointToYValue: point [

	| facteur valeur |
	facteur := 1 - (point y / self sliderBackground size y).
	valeur := self maxValue - self minValue * facteur.
	valeur := (valeur roundTo: (self stepValue ifNil: [ 1 ]))
	          + self minValue.
	valeur := self nearestValue: valeur.
	^ valeur
]

{ #category : #private }
BlBatchingSlider >> proportionOf: aValue [
	| i |
	i := self enumeratedValues indexOf: aValue.
	^ (i/self enumeratedValues size)
]

{ #category : #'private - building' }
BlBatchingSlider >> rebuildSlider [

	self disabledRebuilding ifTrue: [ ^ self ].
	self changeOrientation: self orientation.
]

{ #category : #private }
BlBatchingSlider >> removeAllShapes [

	| list |
	list := self sliderParts.
	self removeAllSliderEventHandlers.
	self removeChildren: list.
	self cleanSliderParts
]

{ #category : #private }
BlBatchingSlider >> removeAllSliderEventHandlers [

	sliderEventHandlerList do: [ :e | e key removeEventHandler: e value ].
	sliderEventHandlerList := OrderedCollection new
]

{ #category : #'api - slider' }
BlBatchingSlider >> setMaxValue [

	self setValue: self maxValue.
]

{ #category : #'api - slider' }
BlBatchingSlider >> setMinValue [

	self setValue: self minValue
]

{ #category : #'api - slider' }
BlBatchingSlider >> setValue: aValue [

	(aValue < self maxValue and: [ aValue > self minValue ]) ifTrue: [
		self validatedValue: aValue ].
]

{ #category : #'api - bounds' }
BlBatchingSlider >> size: aValue [

	super size: aValue.
	self widgetSize: aValue.
	self isBuildSlider ifTrue: [ self rebuildSlider ]
]

{ #category : #accessing }
BlBatchingSlider >> sliderBackground [

	^ sliderBackground
]

{ #category : #accessing }
BlBatchingSlider >> sliderBackground: anObject [

	sliderBackground := anObject
]

{ #category : #accessing }
BlBatchingSlider >> sliderBar [

	^ sliderBar
]

{ #category : #accessing }
BlBatchingSlider >> sliderBar: anObject [

	sliderBar := anObject
]

{ #category : #'events - bar' }
BlBatchingSlider >> sliderBarClicked: event [

	| tmp val |
	tmp := self sliderBackground globalPointToLocal: event position.
	val := self pointToValue: tmp.
	self validatedValue: val.
]

{ #category : #accessing }
BlBatchingSlider >> sliderDecorations [

	^ sliderDecorations
]

{ #category : #accessing }
BlBatchingSlider >> sliderDecorations: anObject [

	sliderDecorations := anObject
]

{ #category : #accessing }
BlBatchingSlider >> sliderInteractionRectangle [

	^ sliderInteractionRectangle
]

{ #category : #accessing }
BlBatchingSlider >> sliderInteractionRectangle: anObject [

	sliderInteractionRectangle := anObject
]

{ #category : #accessing }
BlBatchingSlider >> sliderInteractor [

	^ sliderInteractor
]

{ #category : #accessing }
BlBatchingSlider >> sliderInteractor: anObject [

	sliderInteractor := anObject
]

{ #category : #'events - interactor' }
BlBatchingSlider >> sliderInteractorMoved: event [

	| val tmp v |
	self interactorPushedPoint isNil ifTrue: [ ^ self ].
	tmp := self sliderBackground globalPointToLocal: event position.
	val := self pointToValue: tmp.
	tmp := self globalPointToLocal: event position.
	self orientation = #horizontal
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
BlBatchingSlider >> sliderInteractorPushed: event [

	| value pt1 pt2 |
	self sliderBar ifNil: [ ^ self ].
	value := self pointToValue:
		         (self sliderBackground globalPointToLocal: event position).
	pt1 := self valueToX: value.
	pt2 := self valueToX: self currentValue.
	(self is: pt1 near: pt2) ifTrue: [
		self interactorPushedPoint: event position copy ]
]

{ #category : #'events - interactor' }
BlBatchingSlider >> sliderInteractorReleased: event [

	self interactorPushedPoint isNil ifTrue: [ ^ self ].
	self interactorPushedPoint: nil.
	self validatedValue: self currentValue
]

{ #category : #private }
BlBatchingSlider >> sliderParts [

	| oc |
	oc := OrderedCollection new.
	self sliderInteractionRectangle ifNotNil: [ :e | oc add: e ].
	self sliderBackground ifNotNil: [ :e | oc add: e ].
	self sliderDecorations ifNotNil: [ :e | oc add: e ].
	self sliderBar ifNotNil: [ :e | oc add: e ].
	self sliderInteractor ifNotNil: [ :e | oc add: e ].
	^ oc
]

{ #category : #accessing }
BlBatchingSlider >> sliderPixelMargin [

	^ sliderPixelMargin
]

{ #category : #accessing }
BlBatchingSlider >> sliderPixelMargin: anObject [

	sliderPixelMargin := anObject.
	self isBuildSlider ifTrue: [ 
		self rebuildSlider ]
]

{ #category : #'api - space' }
BlBatchingSlider >> space: aSpace [
	super space: aSpace.
	self initializeSpaceEventHandlers
]

{ #category : #'api - values' }
BlBatchingSlider >> stepValue [

	^ stepValue
]

{ #category : #'api - values' }
BlBatchingSlider >> stepValue: anObject [

	stepValue := anObject.
	enumeratedValues := nil.
]

{ #category : #'api - values' }
BlBatchingSlider >> validatedValue [

	^ validatedValue
]

{ #category : #'api - values' }
BlBatchingSlider >> validatedValue: aValue [

	currentValue := aValue.
	self changedCurrentValue: aValue withSlider: true. 
	validatedValue := aValue.
	self validatedValueCallback ifNotNil: [ :e | e value: validatedValue ]
]

{ #category : #private }
BlBatchingSlider >> validatedValueCallback [

	^ validatedValueCallback
]

{ #category : #'api - values' }
BlBatchingSlider >> validatedValueCallback: anObject [

	validatedValueCallback := anObject
]

{ #category : #'api - transformations' }
BlBatchingSlider >> valueToCoord: aValue [

	^ self orientation = #horizontal 
		ifTrue: [ self valueToX: aValue ]
		ifFalse: [ self valueToY: aValue  ]
	
]

{ #category : #'api - transformations' }
BlBatchingSlider >> valueToX: aValue [

	| valeurCourante valeurTotale facteur |
	valeurCourante := aValue - self minValue.
	valeurTotale := self maxValue - self minValue.
	facteur := valeurCourante / valeurTotale.
	^ self sliderPixelMargin
	  + (self sliderBackground constraints horizontal resizer size * facteur roundTo: 1)
]

{ #category : #'api - transformations' }
BlBatchingSlider >> valueToY: aValue [

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
BlBatchingSlider >> whenEvent: anEventClass do: aBlock [

	| anEventHandler |
	anEventHandler := BlEventHandler
		                  on: anEventClass
		                  do: aBlock.
	self addSliderEventHandler: self->anEventHandler.
	self addEventHandler: anEventHandler
]

{ #category : #private }
BlBatchingSlider >> whenEvent: anEventClass on: aBlElement do: aBlock [

	| anEventHandler |
	anEventHandler := BlEventHandler
		                  on: anEventClass
		                  do: aBlock.
	self addSliderEventHandler: aBlElement -> anEventHandler.
	aBlElement addEventHandler: anEventHandler
]

{ #category : #accessing }
BlBatchingSlider >> widgetSize [

	^ widgetSize
]

{ #category : #private }
BlBatchingSlider >> widgetSize: anObject [

	widgetSize := anObject
]
