Class {
	#name : #BlSimpleVerticalSlider2,
	#superclass : #BlElement,
	#instVars : [
		'widgetSize',
		'sliderInteractionRectangle',
		'interactorDefaultColor'
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

{ #category : #building }
BlSimpleVerticalSlider2 >> buildDefaultInteractor [

	| bl pt |
	pt := 20 @ 20.
	bl := BlElement new
		      geometry: BlCircleGeometry new;
		      background: interactorDefaultColor;
		      size: pt;
		      transformDo: [ :t | t translateBy: pt negated / 2 ].
	^ bl
]

{ #category : #building }
BlSimpleVerticalSlider2 >> initialize [ 

	super initialize.
	interactorDefaultColor := Color red "yes we will use a palette like object"
]

{ #category : #'api - bounds' }
BlSimpleVerticalSlider2 >> size: aValue [
	"just to keep the widgset size"

	super size: aValue.
	widgetSize := aValue

	" for now do not support resize
	
	self isBuildSlider ifTrue: [ self rebuildSlider ]
	"
]
