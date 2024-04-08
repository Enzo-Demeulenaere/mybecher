Class {
	#name : #BlCleanSliderHorizontalTUTO,
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
		'sliderBackground',
		'widgetSize',
		'maxPixelDistance',
		'enumeratedValues',
		'enumeratedColors',
		'initColor',
		'endColor',
		'barThickness',
		'eventHandler',
		'sliderHandle',
		'handlePushedPoint'
	],
	#category : #myBecherBloc
}

{ #category : #building }
BlCleanSliderHorizontalTUTO class >> backgroundDefaultColor [

	^ Color gray
]

{ #category : #building }
BlCleanSliderHorizontalTUTO class >> barDefaultColor [

	^ Color blue 
]

{ #category : #building }
BlCleanSliderHorizontalTUTO class >> defaultMaxPixelDistance [

	^ 25
]

{ #category : #testing }
BlCleanSliderHorizontalTUTO class >> exampleSegmented [

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
BlCleanSliderHorizontalTUTO class >> exampleSegmentedWithColors [

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
	bl2 openInSpace.
]

{ #category : #building }
BlCleanSliderHorizontalTUTO class >> interactionDefaultColor [

	^ Color pink alpha: 0.5
]

{ #category : #building }
BlCleanSliderHorizontalTUTO class >> interactorDefaultColor [

	^ Color red 
]

{ #category : #testing }
BlCleanSliderHorizontalTUTO class >> visualTestNotSegmented [

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
	^ val
]

{ #category : #testing }
BlCleanSliderHorizontalTUTO class >> visualTestNotSegmentedInspectValue [

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
	^ val
]

{ #category : #testing }
BlCleanSliderHorizontalTUTO class >> visualTestSegmented [

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

{ #category : #accessing }
BlCleanSliderHorizontalTUTO >> barThickness: anObject [

	barThickness := anObject
]

{ #category : #'private - building' }
BlCleanSliderHorizontalTUTO >> buildBackground [

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

{ #category : #'private - building' }
BlCleanSliderHorizontalTUTO >> buildBar [

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

{ #category : #'private - building' }
BlCleanSliderHorizontalTUTO >> buildDefaultHandle [

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
BlCleanSliderHorizontalTUTO >> buildForeground [ 

	self id: #sliderInteractionForeground.
	self size: self widgetSize.
	self background: self class interactionDefaultColor.
]

{ #category : #'private - building' }
BlCleanSliderHorizontalTUTO >> buildHandle [ 

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
BlCleanSliderHorizontalTUTO >> buildSlider [

	self removeAllShapes.
	self size: self widgetSize.
	self buildForeground.
	self buildBackground.
	self buildBar.
	self buildHandle.
	self initializeEventHandlers
]

{ #category : #'changing state' }
BlCleanSliderHorizontalTUTO >> changedCurrentValue: aValue [

^self changedCurrentValue: aValue withSlider: false
]

{ #category : #'changing state' }
BlCleanSliderHorizontalTUTO >> changedCurrentValue: aValue withSlider: aBool [

	| v color |
	v := self valueToCoord: aValue.
			aBool ifTrue: [
				self sliderHandle ifNotNil: [ :sl |
					sl position: v @ sl constraints position y ] ].
			self sliderBar size:
				v - self sliderPixelMargin @ self sliderBar size y.
	color := self colorForValue: aValue.
	self sliderHandle background: color.
	self sliderBar background: color
]

{ #category : #'changing state' }
BlCleanSliderHorizontalTUTO >> changedHandlePosition: v [

			self sliderHandle ifNotNil: [ :sl |
				sl position: v @ sl constraints position y ]
]

{ #category : #private }
BlCleanSliderHorizontalTUTO >> cleanSliderParts [

	sliderBackground := nil.
	sliderBar := nil.
	sliderHandle := nil
]

{ #category : #private }
BlCleanSliderHorizontalTUTO >> colorForValue: aValue [

	| i |
	self enumeratedColors
		ifNil: [
			^  endColor
				  mixed: (self proportionOf: aValue)
				  with: self initColor ]
		ifNotNil: [ :list |
			i := self enumeratedValues indexOf: aValue.
			i = 0 ifTrue: [ ^ self initColor ].
			(i > list size) ifTrue: [ ^  endColor ].
			^list at: i ]
]

{ #category : #private }
BlCleanSliderHorizontalTUTO >> currentValue [

	^ currentValue
]

{ #category : #private }
BlCleanSliderHorizontalTUTO >> currentValue: aNumber [

	(aNumber between: minValue and: maxValue) ifFalse: [ ^ self ].
	currentValue := aNumber.
	self changedCurrentValue: aNumber
]

{ #category : #'api - slider' }
BlCleanSliderHorizontalTUTO >> decrementValue [

	self decrementValue: self stepValue.
]

{ #category : #'api - slider' }
BlCleanSliderHorizontalTUTO >> decrementValue: aValue [

	| tmp |
	tmp := validatedValue - aValue.
	tmp < self maxValue ifTrue: [ self validatedValue: tmp ]
]

{ #category : #accessing }
BlCleanSliderHorizontalTUTO >> endColor: anObject [

	endColor := anObject
]

{ #category : #accessing }
BlCleanSliderHorizontalTUTO >> enumeratedColors [

	^ enumeratedColors
]

{ #category : #accessing }
BlCleanSliderHorizontalTUTO >> enumeratedColors: anObject [

	enumeratedColors := anObject
]

{ #category : #'api - values' }
BlCleanSliderHorizontalTUTO >> enumeratedValues [
	"since the enumerated value are derived from min, max and step, we lazy initialize it."
	
	enumeratedValues ifNil: [
		enumeratedValues := (self minValue to: self maxValue by:
		                     self stepValue) asOrderedCollection ].
	^ enumeratedValues
]

{ #category : #accessing }
BlCleanSliderHorizontalTUTO >> enumeratedValues: anObject [

	enumeratedValues := anObject
]

{ #category : #accessing }
BlCleanSliderHorizontalTUTO >> handlePushedPoint [

	^ handlePushedPoint
]

{ #category : #accessing }
BlCleanSliderHorizontalTUTO >> handlePushedPoint: anObject [

	handlePushedPoint := anObject
]

{ #category : #'api - slider' }
BlCleanSliderHorizontalTUTO >> incrementValue [

	self incrementValue: self stepValue
]

{ #category : #'api - slider' }
BlCleanSliderHorizontalTUTO >> incrementValue: aValue [

	| tmp |
	tmp := validatedValue + aValue.
	tmp < self maxValue ifTrue: [ self validatedValue: tmp ]
]

{ #category : #accessing }
BlCleanSliderHorizontalTUTO >> initColor [

	^ initColor
]

{ #category : #accessing }
BlCleanSliderHorizontalTUTO >> initColor: anObject [

	initColor := anObject
]

{ #category : #initialization }
BlCleanSliderHorizontalTUTO >> initialize [

	super initialize.
	barThickness := 8.
	maxValue := 100.0.
	minValue := 0.0.
	self size: 300 @ 30.
	currentValue := 0.0.
	sliderPixelMargin := 5.
	stepValue := 1.
	endColor := self class interactorDefaultColor.
	initColor := self class interactorDefaultColor.
	maxPixelDistance := self class defaultMaxPixelDistance
]

{ #category : #initialization }
BlCleanSliderHorizontalTUTO >> initializeEventHandlers [

	self isSliderBuilt ifFalse: [
		^ self error: 'The slider must be built first' ].
	eventHandler ifNotNil: [ ^ self ].
	self flag: #toClean. "to be cleaned after"
	
	eventHandler := BlCleanSliderHandler new.
	self  addEventHandler: eventHandler
	

]

{ #category : #private }
BlCleanSliderHorizontalTUTO >> is: aValue near: aValue2 [

	^(aValue - aValue2) abs < self maxPixelDistance
]

{ #category : #'private - building' }
BlCleanSliderHorizontalTUTO >> isSliderBuilt [
	"if no interactor, no slider"

	^ self sliderHandle isNotNil
]

{ #category : #accessing }
BlCleanSliderHorizontalTUTO >> maxPixelDistance [

	^ maxPixelDistance 
]

{ #category : #accessing }
BlCleanSliderHorizontalTUTO >> maxPixelDistance: anObject [

	maxPixelDistance := anObject
]

{ #category : #'api - values' }
BlCleanSliderHorizontalTUTO >> maxValue [

	^ maxValue
]

{ #category : #'api - values' }
BlCleanSliderHorizontalTUTO >> maxValue: anObject [
	"when we change the maxValue, we are rebuilding the enumerated values and slider"

	maxValue := anObject.
	enumeratedValues := nil.
	self isSliderBuilt ifTrue: [ self buildSlider ]
]

{ #category : #'api - values' }
BlCleanSliderHorizontalTUTO >> minValue [

	^ minValue
]

{ #category : #'api - values' }
BlCleanSliderHorizontalTUTO >> minValue: anObject [

	minValue := anObject.
	enumeratedValues := nil.
	currentValue < minValue ifTrue: [ currentValue := minValue copy ].
	self isSliderBuilt ifTrue: [ self buildSlider ]
]

{ #category : #'api - values' }
BlCleanSliderHorizontalTUTO >> nearestValue: aValue [

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
BlCleanSliderHorizontalTUTO >> pointToValue: point [

	| facteur valeur |
	facteur := point x / self sliderBackground size x.
	valeur := (self maxValue - self minValue) * facteur.
	valeur := (valeur roundTo: (self stepValue ifNil: [ 1 ]))
	          + self minValue.
	valeur := self nearestValue: valeur.
	^ valeur
]

{ #category : #private }
BlCleanSliderHorizontalTUTO >> proportionOf: aValue [
	| i |
	i := self enumeratedValues indexOf: aValue.
	^ (i/self enumeratedValues size)
]

{ #category : #private }
BlCleanSliderHorizontalTUTO >> removeAllShapes [

	| list |
	list := self sliderParts.
	"BlCleanSlider>>sliderParts is only called here and returns the same thing as BlElement>>children"
	self removeEventHandler.
	self removeChildren: list.
	self cleanSliderParts
]

{ #category : #private }
BlCleanSliderHorizontalTUTO >> removeEventHandler [

	eventHandler ifNil: [ ^ self ].
	self flag: #toClean. "we should not test this"
	
	self removeEventHandler: eventHandler.
	eventHandler := nil.
	
]

{ #category : #'api - slider' }
BlCleanSliderHorizontalTUTO >> setMaxValue [

	self setValue: self maxValue.
]

{ #category : #'api - slider' }
BlCleanSliderHorizontalTUTO >> setMinValue [

	self setValue: self minValue
]

{ #category : #'api - slider' }
BlCleanSliderHorizontalTUTO >> setValue: aValue [

	(aValue < self maxValue and: [ aValue > self minValue ]) ifTrue: [
		self validatedValue: aValue ].
]

{ #category : #'api - bounds' }
BlCleanSliderHorizontalTUTO >> size: aValue [

	super size: aValue.
	self widgetSize: aValue.
	self isSliderBuilt ifTrue: [ self buildSlider ]
]

{ #category : #accessing }
BlCleanSliderHorizontalTUTO >> sliderBackground [

	^ sliderBackground
]

{ #category : #accessing }
BlCleanSliderHorizontalTUTO >> sliderBackground: anObject [

	sliderBackground := anObject
]

{ #category : #accessing }
BlCleanSliderHorizontalTUTO >> sliderBar [

	^ sliderBar
]

{ #category : #accessing }
BlCleanSliderHorizontalTUTO >> sliderBar: anObject [

	sliderBar := anObject
]

{ #category : #'events - bar' }
BlCleanSliderHorizontalTUTO >> sliderBarClicked: event [

	| tmp val |
	tmp := self sliderBackground globalPointToLocal: event position.
	val := self pointToValue: tmp.
	self validatedValue: val.
]

{ #category : #accessing }
BlCleanSliderHorizontalTUTO >> sliderHandle [

	^ sliderHandle
]

{ #category : #accessing }
BlCleanSliderHorizontalTUTO >> sliderHandle: anObject [

	sliderHandle := anObject
]

{ #category : #'events - interactor' }
BlCleanSliderHorizontalTUTO >> sliderHandleMoved: event [

	| val tmp v |
	self handlePushedPoint ifNil: [ ^ self ].
	tmp := self sliderBackground globalPointToLocal: event position.
	val := self pointToValue: tmp.
	tmp := self globalPointToLocal: event position.
			v := tmp x.
			v := v min: (self valueToCoord: self maxValue).
			v := v max: (self valueToCoord: self minValue).

	self changedHandlePosition: v.
	self currentValue: val
]

{ #category : #'events - interactor' }
BlCleanSliderHorizontalTUTO >> sliderHandlePushed: event [

	| value pt1 pt2 |
	self sliderBar ifNil: [ ^ self ].
	value := self pointToValue:
		         (self sliderBackground globalPointToLocal: event position).
	pt1 := self valueToCoord: value.
	pt2 := self valueToCoord: currentValue.
	(self is: pt1 near: pt2) ifTrue: [
		self handlePushedPoint: event position copy ]
]

{ #category : #'events - interactor' }
BlCleanSliderHorizontalTUTO >> sliderHandleReleased [

	self handlePushedPoint ifNil: [ ^ self ].
	self handlePushedPoint: nil.
	self validatedValue: currentValue
]

{ #category : #private }
BlCleanSliderHorizontalTUTO >> sliderParts [

	| oc |
	oc := OrderedCollection new.
	self sliderBackground ifNotNil: [ :e | oc add: e ].
	self sliderBar ifNotNil: [ :e | oc add: e ].
	self sliderHandle ifNotNil: [ :e | oc add: e ].
	^ oc
]

{ #category : #accessing }
BlCleanSliderHorizontalTUTO >> sliderPixelMargin [

	^ sliderPixelMargin 
]

{ #category : #accessing }
BlCleanSliderHorizontalTUTO >> sliderPixelMargin: anObject [

	sliderPixelMargin := anObject.
	self isSliderBuilt ifTrue: [ self buildSlider ]
]

{ #category : #'api - values' }
BlCleanSliderHorizontalTUTO >> stepValue [

	^ stepValue
]

{ #category : #'api - values' }
BlCleanSliderHorizontalTUTO >> stepValue: anObject [

	stepValue := anObject.
	enumeratedValues := nil.
]

{ #category : #'api - values' }
BlCleanSliderHorizontalTUTO >> validatedValue [

	^ validatedValue
]

{ #category : #'api - values' }
BlCleanSliderHorizontalTUTO >> validatedValue: aValue [

	currentValue := aValue.
	self changedCurrentValue: aValue withSlider: true. 
	validatedValue := aValue.
	self validatedValueCallback ifNotNil: [ :e | e value: validatedValue ]
]

{ #category : #private }
BlCleanSliderHorizontalTUTO >> validatedValueCallback [

	^ validatedValueCallback
]

{ #category : #'api - values' }
BlCleanSliderHorizontalTUTO >> validatedValueCallback: anObject [

	validatedValueCallback := anObject
]

{ #category : #'api - transformations' }
BlCleanSliderHorizontalTUTO >> valueToCoord: aValue [

	| current total coeff |
	current := aValue - self minValue.
	total := self maxValue - self minValue.
	coeff := current / total.
	^ self sliderPixelMargin
	  + (self sliderBackground constraints horizontal resizer size * coeff roundTo: 1)
]

{ #category : #accessing }
BlCleanSliderHorizontalTUTO >> widgetSize [

	^ widgetSize
]

{ #category : #private }
BlCleanSliderHorizontalTUTO >> widgetSize: anObject [

	widgetSize := anObject
]
