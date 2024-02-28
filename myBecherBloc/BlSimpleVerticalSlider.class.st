Class {
	#name : #BlSimpleVerticalSlider,
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
BlSimpleVerticalSlider class >> alainVisual1 [

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
	bl openInSpace
]

{ #category : #testing }
BlSimpleVerticalSlider class >> alainVisual2 [

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
BlSimpleVerticalSlider class >> backgroundDefaultColor [

	^ Color gray
]

{ #category : #building }
BlSimpleVerticalSlider class >> barDefaultColor [

	^ Color blue 
]

{ #category : #building }
BlSimpleVerticalSlider class >> buildDefaultInteractor [

	| bl |
	bl := BlElement new
		      geometry: BlCircleGeometry new;
		      background: self interactorDefaultColor;
		      size: 20 asPoint;
		      transformDo: [ :t | t translateBy: -10 asPoint ].
	^ bl
]

{ #category : #building }
BlSimpleVerticalSlider class >> defaultMaxPixelDistance [

	^ 25
]

{ #category : #building }
BlSimpleVerticalSlider class >> interactionDefaultColor [

	^ Color green alpha: 0.
	
	
]

{ #category : #building }
BlSimpleVerticalSlider class >> interactorDefaultColor [

	^ Color red 
]

{ #category : #testing }
BlSimpleVerticalSlider class >> visualTest1 [

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
BlSimpleVerticalSlider class >> visualTest2 [

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
BlSimpleVerticalSlider class >> visualTest3 [

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
BlSimpleVerticalSlider class >> visualTestVertical1 [

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
BlSimpleVerticalSlider >> addSliderEventHandler: aAssoc [

	sliderEventHandlerList add: aAssoc
]

{ #category : #accessing }
BlSimpleVerticalSlider >> barHeight [

	^ barHeight
]

{ #category : #accessing }
BlSimpleVerticalSlider >> barHeight: anObject [

	barHeight := anObject
]

{ #category : #'private - building' }
BlSimpleVerticalSlider >> buildHorizontalSlider [

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
	bl := self class buildDefaultInteractor.
	pt := (self valueToCoord: self currentValue)
	      @ (self widgetSize y / 2).
	bl position: pt.
	bl zIndex: 3.
	self addChild: bl.
	self sliderInteractor: bl
]

{ #category : #'api - slider' }
BlSimpleVerticalSlider >> buildSlider [
	
		self changeOrientation: self orientation.
		self initializeEventHandlers.
]

{ #category : #'private - building' }
BlSimpleVerticalSlider >> buildVerticalSlider [

	| bl pt pt1 pt2 |
	
	"foreground"
	bl := BlElement new.
	bl id: #sliderForeground.
	bl size: widgetSize.
	bl background: self class interactionDefaultColor.
	bl zIndex: 50.
	self addChild: bl.
	self sliderInteractionRectangle: bl.

	"background"
	bl := BlElement new.
	pt1 := self barHeight	@ (self widgetSize y - (2 * self sliderPixelMargin)).
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
	bl := self class buildDefaultInteractor.
	bl id: #sliderInteractor.
	pt := self widgetSize x / 2 @ (self valueToCoord: self currentValue).
	bl position: pt.
	bl zIndex: 3.
	self addChild: bl.
	self sliderInteractor: bl
]

{ #category : #'changing state' }
BlSimpleVerticalSlider >> changeOrientation: aSymbol [

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
BlSimpleVerticalSlider >> changedCurrentValue: aValue [

^self changedCurrentValue: aValue withSlider: false
]

{ #category : #'changing state' }
BlSimpleVerticalSlider >> changedCurrentValue: aValue withSlider: aBool [

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
BlSimpleVerticalSlider >> changedCursorPosition: v [

	self orientation = #horizontal
		ifTrue: [
			self sliderInteractor ifNotNil: [ :sl |
				sl position: v @ sl constraints position y ] ]
		ifFalse: [
			self sliderInteractor ifNotNil: [ :sl |
				sl position: sl constraints position x @ v ] ]
]

{ #category : #private }
BlSimpleVerticalSlider >> cleanSliderParts [

	sliderInteractionRectangle := nil.
	sliderBackground := nil.
	sliderDecorations := nil.
	sliderBar := nil.
	sliderInteractor := nil
]

{ #category : #private }
BlSimpleVerticalSlider >> colorForValue: aValue [

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
BlSimpleVerticalSlider >> currentValue [

	^ currentValue
]

{ #category : #private }
BlSimpleVerticalSlider >> currentValue: anObject [

	(anObject <= maxValue and: [ anObject >= minValue ]) ifFalse: [ ^ self ].
	currentValue := anObject.

	"SmockTracer warn: 'CVal = ' , currentValue printString."
	self changedCurrentValue: anObject
]

{ #category : #'api - slider' }
BlSimpleVerticalSlider >> decrementValue [

	self decrementValue: self stepValue.
]

{ #category : #'api - slider' }
BlSimpleVerticalSlider >> decrementValue: aValue [

	| tmp |
	tmp := validatedValue - aValue.
	tmp < self maxValue ifTrue: [ self validatedValue: tmp ]
]

{ #category : #accessing }
BlSimpleVerticalSlider >> disabledRebuilding [

	^ disabledRebuilding
]

{ #category : #accessing }
BlSimpleVerticalSlider >> disabledRebuilding: anObject [

	disabledRebuilding := anObject
]

{ #category : #accessing }
BlSimpleVerticalSlider >> endColor [

	^ endColor
]

{ #category : #accessing }
BlSimpleVerticalSlider >> endColor: anObject [

	endColor := anObject
]

{ #category : #accessing }
BlSimpleVerticalSlider >> enumeratedColors [

	^ enumeratedColors
]

{ #category : #accessing }
BlSimpleVerticalSlider >> enumeratedColors: anObject [

	enumeratedColors := anObject
]

{ #category : #'api - values' }
BlSimpleVerticalSlider >> enumeratedValues [

	enumeratedValues ifNil: [
		enumeratedValues := (self minValue to: self maxValue by:
		                     self stepValue) asOrderedCollection ].
	^enumeratedValues 
]

{ #category : #accessing }
BlSimpleVerticalSlider >> enumeratedValues: anObject [

	enumeratedValues := anObject
]

{ #category : #'api - slider' }
BlSimpleVerticalSlider >> incrementValue [

	self incrementValue: self stepValue
]

{ #category : #'api - slider' }
BlSimpleVerticalSlider >> incrementValue: aValue [

	| tmp |
	tmp := validatedValue + aValue.
	tmp < self maxValue ifTrue: [ self validatedValue: tmp ]
]

{ #category : #accessing }
BlSimpleVerticalSlider >> initColor [

	^ initColor
]

{ #category : #accessing }
BlSimpleVerticalSlider >> initColor: anObject [

	initColor := anObject
]

{ #category : #initialization }
BlSimpleVerticalSlider >> initialize [

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
BlSimpleVerticalSlider >> initializeEventHandlers [

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
BlSimpleVerticalSlider >> initializeSpaceEventHandlers [

	self space
		addEventHandlerOn: BlMouseUpEvent
		do: [ :event | self sliderInteractorReleased: event ]
]

{ #category : #accessing }
BlSimpleVerticalSlider >> interactorPushedPoint [

	^ interactorPushedPoint
]

{ #category : #accessing }
BlSimpleVerticalSlider >> interactorPushedPoint: anObject [

	interactorPushedPoint := anObject
]

{ #category : #private }
BlSimpleVerticalSlider >> is: aValue near: aValue2 [

	^(aValue - aValue2) abs < self maxPixelDistance
]

{ #category : #'private - building' }
BlSimpleVerticalSlider >> isBuildSlider [
	"if no interactor, no slider"

	^ self sliderInteractor isNil not
]

{ #category : #accessing }
BlSimpleVerticalSlider >> maxPixelDistance [

	^ maxPixelDistance 
]

{ #category : #accessing }
BlSimpleVerticalSlider >> maxPixelDistance: anObject [

	maxPixelDistance := anObject
]

{ #category : #'api - values' }
BlSimpleVerticalSlider >> maxValue [

	^ maxValue
]

{ #category : #'api - values' }
BlSimpleVerticalSlider >> maxValue: anObject [
	"when we change the maxValue, we rebuilding the slider"
	
	maxValue := anObject.
	enumeratedValues := nil.
	self isBuildSlider ifTrue: [ 
		self rebuildSlider ]
]

{ #category : #'api - values' }
BlSimpleVerticalSlider >> minValue [

	^ minValue
]

{ #category : #'api - values' }
BlSimpleVerticalSlider >> minValue: anObject [

	minValue := anObject.
	enumeratedValues := nil.
	self currentValue < minValue ifTrue: [ currentValue := minValue copy ].
	self isBuildSlider ifTrue: [ self rebuildSlider ]
]

{ #category : #'api - values' }
BlSimpleVerticalSlider >> nearestValue: aValue [

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
BlSimpleVerticalSlider >> orientation [

	^ orientation
]

{ #category : #accessing }
BlSimpleVerticalSlider >> orientation: anObject [

	self orientation = anObject ifTrue: [ ^ self ].
	self size: self widgetSize transposed.
	orientation := anObject.
	self changeOrientation: anObject
]

{ #category : #'api - transformations' }
BlSimpleVerticalSlider >> pointToValue: point [

	^  self orientation = #horizontal
			ifTrue: [ self pointToXValue: point ]
			ifFalse: [ self pointToYValue: point ].
]

{ #category : #'api - transformations' }
BlSimpleVerticalSlider >> pointToXValue: point [

	| facteur valeur |
	facteur := point x / self sliderBackground size x.
	valeur := self maxValue - self minValue * facteur.
	valeur := (valeur roundTo: (self stepValue ifNil: [ 1 ]))
	          + self minValue.
	valeur := self nearestValue: valeur.
	^ valeur
]

{ #category : #'api - transformations' }
BlSimpleVerticalSlider >> pointToYValue: point [

	| facteur valeur |
	facteur := 1 - (point y / self sliderBackground size y).
	valeur := self maxValue - self minValue * facteur.
	valeur := (valeur roundTo: (self stepValue ifNil: [ 1 ]))
	          + self minValue.
	valeur := self nearestValue: valeur.
	^ valeur
]

{ #category : #private }
BlSimpleVerticalSlider >> proportionOf: aValue [
	| i |
	i := self enumeratedValues indexOf: aValue.
	^ (i/self enumeratedValues size)
]

{ #category : #'private - building' }
BlSimpleVerticalSlider >> rebuildSlider [

	self disabledRebuilding ifTrue: [ ^ self ].
	self changeOrientation: self orientation.
]

{ #category : #private }
BlSimpleVerticalSlider >> removeAllShapes [

	| list |
	list := self sliderParts.
	self removeAllSliderEventHandlers.
	self removeChildren: list.
	self cleanSliderParts
]

{ #category : #private }
BlSimpleVerticalSlider >> removeAllSliderEventHandlers [

	sliderEventHandlerList do: [ :e | e key removeEventHandler: e value ].
	sliderEventHandlerList := OrderedCollection new
]

{ #category : #'api - slider' }
BlSimpleVerticalSlider >> setMaxValue [

	self setValue: self maxValue.
]

{ #category : #'api - slider' }
BlSimpleVerticalSlider >> setMinValue [

	self setValue: self minValue
]

{ #category : #'api - slider' }
BlSimpleVerticalSlider >> setValue: aValue [

	(aValue < self maxValue and: [ aValue > self minValue ]) ifTrue: [
		self validatedValue: aValue ].
]

{ #category : #'api - bounds' }
BlSimpleVerticalSlider >> size: aValue [

	super size: aValue.
	self widgetSize: aValue.
	self isBuildSlider ifTrue: [ self rebuildSlider ]
]

{ #category : #accessing }
BlSimpleVerticalSlider >> sliderBackground [

	^ sliderBackground
]

{ #category : #accessing }
BlSimpleVerticalSlider >> sliderBackground: anObject [

	sliderBackground := anObject
]

{ #category : #accessing }
BlSimpleVerticalSlider >> sliderBar [

	^ sliderBar
]

{ #category : #accessing }
BlSimpleVerticalSlider >> sliderBar: anObject [

	sliderBar := anObject
]

{ #category : #'events - bar' }
BlSimpleVerticalSlider >> sliderBarClicked: event [

	| tmp val |
	tmp := self sliderBackground globalPointToLocal: event position.
	val := self pointToValue: tmp.
	self validatedValue: val.
]

{ #category : #accessing }
BlSimpleVerticalSlider >> sliderDecorations [

	^ sliderDecorations
]

{ #category : #accessing }
BlSimpleVerticalSlider >> sliderDecorations: anObject [

	sliderDecorations := anObject
]

{ #category : #accessing }
BlSimpleVerticalSlider >> sliderInteractionRectangle [

	^ sliderInteractionRectangle
]

{ #category : #accessing }
BlSimpleVerticalSlider >> sliderInteractionRectangle: anObject [

	sliderInteractionRectangle := anObject
]

{ #category : #accessing }
BlSimpleVerticalSlider >> sliderInteractor [

	^ sliderInteractor
]

{ #category : #accessing }
BlSimpleVerticalSlider >> sliderInteractor: anObject [

	sliderInteractor := anObject
]

{ #category : #'events - interactor' }
BlSimpleVerticalSlider >> sliderInteractorMoved: event [

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
BlSimpleVerticalSlider >> sliderInteractorPushed: event [

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
BlSimpleVerticalSlider >> sliderInteractorReleased: event [

	self interactorPushedPoint isNil ifTrue: [ ^ self ].
	self interactorPushedPoint: nil.
	self validatedValue: self currentValue
]

{ #category : #private }
BlSimpleVerticalSlider >> sliderParts [

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
BlSimpleVerticalSlider >> sliderPixelMargin [

	^ sliderPixelMargin
]

{ #category : #accessing }
BlSimpleVerticalSlider >> sliderPixelMargin: anObject [

	sliderPixelMargin := anObject.
	self isBuildSlider ifTrue: [ 
		self rebuildSlider ]
]

{ #category : #'api - space' }
BlSimpleVerticalSlider >> space: aSpace [
	super space: aSpace.
	self initializeSpaceEventHandlers
]

{ #category : #'api - values' }
BlSimpleVerticalSlider >> stepValue [

	^ stepValue
]

{ #category : #'api - values' }
BlSimpleVerticalSlider >> stepValue: anObject [

	stepValue := anObject.
	enumeratedValues := nil.
]

{ #category : #'api - values' }
BlSimpleVerticalSlider >> validatedValue [

	^ validatedValue
]

{ #category : #'api - values' }
BlSimpleVerticalSlider >> validatedValue: aValue [

	currentValue := aValue.
	self changedCurrentValue: aValue withSlider: true. 
	validatedValue := aValue.
	self validatedValueCallback ifNotNil: [ :e | e value: validatedValue ]
]

{ #category : #private }
BlSimpleVerticalSlider >> validatedValueCallback [

	^ validatedValueCallback
]

{ #category : #'api - values' }
BlSimpleVerticalSlider >> validatedValueCallback: anObject [

	validatedValueCallback := anObject
]

{ #category : #'api - transformations' }
BlSimpleVerticalSlider >> valueToCoord: aValue [

	^ self orientation = #horizontal 
		ifTrue: [ self valueToX: aValue ]
		ifFalse: [ self valueToY: aValue  ]
	
]

{ #category : #'api - transformations' }
BlSimpleVerticalSlider >> valueToX: aValue [

	| valeurCourante valeurTotale facteur |
	valeurCourante := aValue - self minValue.
	valeurTotale := self maxValue - self minValue.
	facteur := valeurCourante / valeurTotale.
	^ self sliderPixelMargin
	  + (self sliderBackground constraints horizontal resizer size * facteur roundTo: 1)
]

{ #category : #'api - transformations' }
BlSimpleVerticalSlider >> valueToY: aValue [

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
BlSimpleVerticalSlider >> whenEvent: anEventClass do: aBlock [

	| anEventHandler |
	anEventHandler := BlEventHandler
		                  on: anEventClass
		                  do: aBlock.
	self addSliderEventHandler: self->anEventHandler.
	self addEventHandler: anEventHandler
]

{ #category : #private }
BlSimpleVerticalSlider >> whenEvent: anEventClass on: aBlElement do: aBlock [

	| anEventHandler |
	anEventHandler := BlEventHandler
		                  on: anEventClass
		                  do: aBlock.
	self addSliderEventHandler: aBlElement -> anEventHandler.
	aBlElement addEventHandler: anEventHandler
]

{ #category : #accessing }
BlSimpleVerticalSlider >> widgetSize [

	^ widgetSize
]

{ #category : #private }
BlSimpleVerticalSlider >> widgetSize: anObject [

	widgetSize := anObject
]
