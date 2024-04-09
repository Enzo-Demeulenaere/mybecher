Class {
	#name : #BlCleanSlider,
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
		'disabledRebuilding',
		'widgetSize',
		'maxPixelDistance',
		'enumeratedValues',
		'enumeratedColors',
		'initColor',
		'endColor',
		'barThickness',
		'isHorizontal',
		'eventHandler',
		'sliderHandle',
		'handlePushedPoint'
	],
	#category : #'myBecherBloc-Slider'
}

{ #category : #building }
BlCleanSlider class >> backgroundDefaultColor [

	^ Color gray
]

{ #category : #building }
BlCleanSlider class >> barDefaultColor [

	^ Color blue 
]

{ #category : #building }
BlCleanSlider class >> defaultMaxPixelDistance [

	^ 25
]

{ #category : #testing }
BlCleanSlider class >> exampleSegmented [

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
BlCleanSlider class >> exampleSegmentedWithColors [

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
BlCleanSlider class >> interactionDefaultColor [

	^ Color pink alpha: 0.5
]

{ #category : #building }
BlCleanSlider class >> interactorDefaultColor [

	^ Color red 
]

{ #category : #testing }
BlCleanSlider class >> visualTestNotSegmented [

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
BlCleanSlider class >> visualTestNotSegmentedInspectValue [

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
BlCleanSlider class >> visualTestSegmented [

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
BlCleanSlider >> barThickness: anObject [

	barThickness := anObject
]

{ #category : #'main configuration' }
BlCleanSlider >> beHorizontal [

	self horizontal: true.
]

{ #category : #'main configuration' }
BlCleanSlider >> beVertical [

	self horizontal: false.
]

{ #category : #'private - building' }
BlCleanSlider >> buildDefaultHandle [

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
BlCleanSlider >> buildForeground [ 

	self id: #sliderInteractionForeground.
	self size: self widgetSize.
	self background: self class interactionDefaultColor.
]

{ #category : #'private - building' }
BlCleanSlider >> buildHorizontalBackground [

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
BlCleanSlider >> buildHorizontalBar [

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
BlCleanSlider >> buildHorizontalHandle [ 

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
BlCleanSlider >> buildHorizontalSlider [

	self buildForeground.
	self buildHorizontalBackground.
	self buildHorizontalBar.
	self buildHorizontalHandle
]

{ #category : #'private - building' }
BlCleanSlider >> buildSlider [

	self removeAllShapes.
	self size: self widgetSize.
	self isHorizontal
		ifTrue: [ self buildHorizontalSlider ]
		ifFalse: [ self buildVerticalSlider ].
	self initializeEventHandlers
]

{ #category : #'private - building' }
BlCleanSlider >> buildVerticalBackground [

	
	| bgElt pt1 pt2 |
	bgElt := BlElement new.
	pt1 := barThickness
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

]

{ #category : #'private - building' }
BlCleanSlider >> buildVerticalBar [

	| bar |
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

	
]

{ #category : #'private - building' }
BlCleanSlider >> buildVerticalHandle [

	| handle pt |

	handle := self buildDefaultHandle.
	handle id: #sliderHandle.
	pt := self widgetSize x / 2 @ (self valueToCoord: currentValue).
	handle position: pt.
	handle zIndex: 3.
	self addChild: handle.
	self sliderHandle: handle
]

{ #category : #'private - building' }
BlCleanSlider >> buildVerticalSlider [

	self buildForeground.
	self buildVerticalBackground.
	self buildVerticalBar.
	self buildVerticalHandle
]

{ #category : #'changing state' }
BlCleanSlider >> changedCurrentValue: aValue [

^self changedCurrentValue: aValue withSlider: false
]

{ #category : #'changing state' }
BlCleanSlider >> changedCurrentValue: aValue withSlider: aBool [

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
			self sliderBar size:
				barThickness
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
BlCleanSlider >> changedHandlePosition: v [

	self isHorizontal 
		ifTrue: [
			self sliderHandle ifNotNil: [ :sl |
				sl position: v @ sl constraints position y ] ]
		ifFalse: [
			self sliderHandle ifNotNil: [ :sl |
				sl position: sl constraints position x @ v ] ]
]

{ #category : #private }
BlCleanSlider >> cleanSliderParts [

	sliderBackground := nil.
	sliderBar := nil.
	sliderHandle := nil
]

{ #category : #private }
BlCleanSlider >> colorForValue: aValue [

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
BlCleanSlider >> currentValue [

	^ currentValue
]

{ #category : #private }
BlCleanSlider >> currentValue: aNumber [

	(aNumber between: minValue and: maxValue) ifFalse: [ ^ self ].
	currentValue := aNumber.
	self changedCurrentValue: aNumber
]

{ #category : #'api - slider' }
BlCleanSlider >> decrementValue [

	self decrementValue: self stepValue.
]

{ #category : #'api - slider' }
BlCleanSlider >> decrementValue: aValue [

	| tmp |
	tmp := validatedValue - aValue.
	tmp < self maxValue ifTrue: [ self validatedValue: tmp ]
]

{ #category : #accessing }
BlCleanSlider >> disabledRebuilding [

	^ disabledRebuilding
]

{ #category : #accessing }
BlCleanSlider >> disabledRebuilding: anObject [

	disabledRebuilding := anObject
]

{ #category : #accessing }
BlCleanSlider >> endColor: anObject [

	endColor := anObject
]

{ #category : #accessing }
BlCleanSlider >> enumeratedColors [

	^ enumeratedColors
]

{ #category : #accessing }
BlCleanSlider >> enumeratedColors: anObject [

	enumeratedColors := anObject
]

{ #category : #'api - values' }
BlCleanSlider >> enumeratedValues [
	"since the enumerated value are derived from min, max and step, we lazy initialize it."
	
	enumeratedValues ifNil: [
		enumeratedValues := (self minValue to: self maxValue by:
		                     self stepValue) asOrderedCollection ].
	^ enumeratedValues
]

{ #category : #accessing }
BlCleanSlider >> enumeratedValues: anObject [

	enumeratedValues := anObject
]

{ #category : #accessing }
BlCleanSlider >> handlePushedPoint [

	^ handlePushedPoint
]

{ #category : #accessing }
BlCleanSlider >> handlePushedPoint: anObject [

	handlePushedPoint := anObject
]

{ #category : #accessing }
BlCleanSlider >> horizontal: aBoolean [

	isHorizontal := aBoolean 
]

{ #category : #'api - slider' }
BlCleanSlider >> incrementValue [

	self incrementValue: self stepValue
]

{ #category : #'api - slider' }
BlCleanSlider >> incrementValue: aValue [

	| tmp |
	tmp := validatedValue + aValue.
	tmp < self maxValue ifTrue: [ self validatedValue: tmp ]
]

{ #category : #accessing }
BlCleanSlider >> initColor [

	^ initColor
]

{ #category : #accessing }
BlCleanSlider >> initColor: anObject [

	initColor := anObject
]

{ #category : #initialization }
BlCleanSlider >> initialize [

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
	endColor := self class interactorDefaultColor.
	initColor := self class interactorDefaultColor.
	maxPixelDistance := self class defaultMaxPixelDistance
]

{ #category : #initialization }
BlCleanSlider >> initializeEventHandlers [

	self isSliderBuilt ifFalse: [
		^ self error: 'The slider must be built first' ].
	eventHandler ifNotNil: [ ^ self ].
	self flag: #toClean. "to be cleaned after"
	
	eventHandler := BlCleanSliderHandler new.
	self  addEventHandler: eventHandler
	

]

{ #category : #private }
BlCleanSlider >> is: aValue near: aValue2 [

	^(aValue - aValue2) abs < self maxPixelDistance
]

{ #category : #accessing }
BlCleanSlider >> isHorizontal [ 

	^ isHorizontal 
]

{ #category : #'private - building' }
BlCleanSlider >> isSliderBuilt [
	"if no interactor, no slider"

	^ self sliderHandle isNotNil
]

{ #category : #accessing }
BlCleanSlider >> maxPixelDistance [

	^ maxPixelDistance 
]

{ #category : #accessing }
BlCleanSlider >> maxPixelDistance: anObject [

	maxPixelDistance := anObject
]

{ #category : #'api - values' }
BlCleanSlider >> maxValue [

	^ maxValue
]

{ #category : #'api - values' }
BlCleanSlider >> maxValue: anObject [
	"when we change the maxValue, we are rebuilding the enumerated values and slider"

	maxValue := anObject.
	enumeratedValues := nil.
	self isSliderBuilt ifTrue: [ self rebuildSlider ]
]

{ #category : #'api - values' }
BlCleanSlider >> minValue [

	^ minValue
]

{ #category : #'api - values' }
BlCleanSlider >> minValue: anObject [

	minValue := anObject.
	enumeratedValues := nil.
	currentValue < minValue ifTrue: [ currentValue := minValue copy ].
	self isSliderBuilt ifTrue: [ self rebuildSlider ]
]

{ #category : #'api - values' }
BlCleanSlider >> nearestValue: aValue [

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
BlCleanSlider >> pointToValue: point [

	^ self isHorizontal 
		  ifTrue: [ self pointToXValue: point ]
		  ifFalse: [ self pointToYValue: point ]
]

{ #category : #'api - transformations' }
BlCleanSlider >> pointToXValue: point [

	| facteur valeur |
	facteur := point x / self sliderBackground size x.
	valeur := self maxValue - self minValue * facteur.
	valeur := (valeur roundTo: (self stepValue ifNil: [ 1 ]))
	          + self minValue.
	valeur := self nearestValue: valeur.
	^ valeur
]

{ #category : #'api - transformations' }
BlCleanSlider >> pointToYValue: point [

	| facteur valeur |
	facteur := 1 - (point y / self sliderBackground size y).
	valeur := self maxValue - self minValue * facteur.
	valeur := (valeur roundTo: (self stepValue ifNil: [ 1 ]))
	          + self minValue.
	valeur := self nearestValue: valeur.
	^ valeur
]

{ #category : #private }
BlCleanSlider >> proportionOf: aValue [
	| i |
	i := self enumeratedValues indexOf: aValue.
	^ (i/self enumeratedValues size)
]

{ #category : #'private - building' }
BlCleanSlider >> rebuildSlider [

	self disabledRebuilding ifTrue: [ ^ self ].
	self buildSlider
]

{ #category : #private }
BlCleanSlider >> removeAllShapes [

	| list |
	list := self sliderParts.
	"BlCleanSlider>>sliderParts is only called here and returns the same thing as BlElement>>children"
	self removeEventHandler.
	self removeChildren: list.
	self cleanSliderParts
]

{ #category : #private }
BlCleanSlider >> removeEventHandler [

	eventHandler ifNil: [ ^ self ].
	self flag: #toClean. "we should not test this"
	
	self removeEventHandler: eventHandler.
	eventHandler := nil.
	
]

{ #category : #'api - slider' }
BlCleanSlider >> setMaxValue [

	self setValue: self maxValue.
]

{ #category : #'api - slider' }
BlCleanSlider >> setMinValue [

	self setValue: self minValue
]

{ #category : #'api - slider' }
BlCleanSlider >> setValue: aValue [

	(aValue < self maxValue and: [ aValue > self minValue ]) ifTrue: [
		self validatedValue: aValue ].
]

{ #category : #'api - bounds' }
BlCleanSlider >> size: aValue [

	super size: aValue.
	self widgetSize: aValue.
	self isSliderBuilt ifTrue: [ self rebuildSlider ]
]

{ #category : #accessing }
BlCleanSlider >> sliderBackground [

	^ sliderBackground
]

{ #category : #accessing }
BlCleanSlider >> sliderBackground: anObject [

	sliderBackground := anObject
]

{ #category : #accessing }
BlCleanSlider >> sliderBar [

	^ sliderBar
]

{ #category : #accessing }
BlCleanSlider >> sliderBar: anObject [

	sliderBar := anObject
]

{ #category : #'events - bar' }
BlCleanSlider >> sliderBarClicked: event [

	| tmp val |
	tmp := self sliderBackground globalPointToLocal: event position.
	val := self pointToValue: tmp.
	self validatedValue: val.
]

{ #category : #accessing }
BlCleanSlider >> sliderHandle [

	^ sliderHandle
]

{ #category : #accessing }
BlCleanSlider >> sliderHandle: anObject [

	sliderHandle := anObject
]

{ #category : #'events - interactor' }
BlCleanSlider >> sliderHandleMoved: event [

	| val tmp v |
	self handlePushedPoint ifNil: [ ^ self ].
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

	self changedHandlePosition: v.
	self currentValue: val
]

{ #category : #'events - interactor' }
BlCleanSlider >> sliderHandlePushed: event [

	| value pt1 pt2 |
	self sliderBar ifNil: [ ^ self ].
	value := self pointToValue:
		         (self sliderBackground globalPointToLocal: event position).
	pt1 := self valueToX: value.
	pt2 := self valueToX: currentValue.
	(self is: pt1 near: pt2) ifTrue: [
		self handlePushedPoint: event position copy ]
]

{ #category : #'events - interactor' }
BlCleanSlider >> sliderHandleReleased [

	self handlePushedPoint ifNil: [ ^ self ].
	self handlePushedPoint: nil.
	self validatedValue: currentValue
]

{ #category : #private }
BlCleanSlider >> sliderParts [

	| oc |
	oc := OrderedCollection new.
	self sliderBackground ifNotNil: [ :e | oc add: e ].
	self sliderBar ifNotNil: [ :e | oc add: e ].
	self sliderHandle ifNotNil: [ :e | oc add: e ].
	^ oc
]

{ #category : #accessing }
BlCleanSlider >> sliderPixelMargin [

	^ sliderPixelMargin 
]

{ #category : #accessing }
BlCleanSlider >> sliderPixelMargin: anObject [

	sliderPixelMargin := anObject.
	self isSliderBuilt ifTrue: [ 
		self rebuildSlider ]
]

{ #category : #'api - values' }
BlCleanSlider >> stepValue [

	^ stepValue
]

{ #category : #'api - values' }
BlCleanSlider >> stepValue: anObject [

	stepValue := anObject.
	enumeratedValues := nil.
]

{ #category : #'api - values' }
BlCleanSlider >> validatedValue [

	^ validatedValue
]

{ #category : #'api - values' }
BlCleanSlider >> validatedValue: aValue [

	currentValue := aValue.
	self changedCurrentValue: aValue withSlider: true. 
	validatedValue := aValue.
	self validatedValueCallback ifNotNil: [ :e | e value: validatedValue ]
]

{ #category : #private }
BlCleanSlider >> validatedValueCallback [

	^ validatedValueCallback
]

{ #category : #'api - values' }
BlCleanSlider >> validatedValueCallback: anObject [

	validatedValueCallback := anObject
]

{ #category : #'api - transformations' }
BlCleanSlider >> valueToCoord: aValue [

	^ self isHorizontal 
		  ifTrue: [ self valueToX: aValue ]
		  ifFalse: [ self valueToY: aValue ]
]

{ #category : #'api - transformations' }
BlCleanSlider >> valueToX: aValue [

	| current total coeff |
	current := aValue - self minValue.
	total := self maxValue - self minValue.
	coeff := current / total.
	^ self sliderPixelMargin
	  + (self sliderBackground constraints horizontal resizer size * coeff roundTo: 1)
]

{ #category : #'api - transformations' }
BlCleanSlider >> valueToY: aValue [

	| valeurCourante valeurTotale facteur |
	valeurCourante := aValue - self minValue.
	valeurTotale := self maxValue - self minValue.
	facteur := 1 - (valeurCourante / valeurTotale).
	^ self sliderPixelMargin
	  +
		  (self sliderBackground constraints vertical resizer size * facteur
			   roundTo: 1)
]

{ #category : #accessing }
BlCleanSlider >> widgetSize [

	^ widgetSize
]

{ #category : #private }
BlCleanSlider >> widgetSize: anObject [

	widgetSize := anObject
]
