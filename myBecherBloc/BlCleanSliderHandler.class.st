Class {
	#name : #BlCleanSliderHandler,
	#superclass : #BlCustomEventHandler,
	#category : #myBecherBloc
}

{ #category : #methods }
BlCleanSliderHandler >> clickEvent: anEvent [

	self sliderBarClicked: anEvent
]

{ #category : #methods }
BlCleanSliderHandler >> dragEndEvent: anEvent [

	self sliderInteractorReleased: anEvent
	
]

{ #category : #methods }
BlCleanSliderHandler >> eventsToHandle [
	^ { BlMouseDownEvent . BlDragEndEvent . BlMouseUpEvent . BlMouseMoveEvent . BlClickEvent}
]

{ #category : #methods }
BlCleanSliderHandler >> mouseDownEvent: anEvent [

	self sliderInteractorPushed: anEvent
	
]

{ #category : #methods }
BlCleanSliderHandler >> mouseMoveEvent: anEvent [

	self sliderInteractorMoved: anEvent.
]

{ #category : #methods }
BlCleanSliderHandler >> mouseUpEvent: anEvent [

	self sliderInteractorReleased: anEvent
]

{ #category : #methods }
BlCleanSliderHandler >> sliderBarClicked: event [

	| tmp val slider |
	slider := event currentTarget.
	tmp := slider sliderBackground globalPointToLocal: event position.
	val := slider pointToValue: tmp.
	slider validatedValue: val.
]

{ #category : #'api - accessing' }
BlCleanSliderHandler >> sliderInteractorMoved: event [

	| val tmp v slider interactor |
	
	slider := event currentTarget.
	
	slider interactorPushedPoint ifNil: [ ^ self ].
	tmp := slider sliderBackground globalPointToLocal: event position.
	val := slider pointToValue: tmp.
	tmp := slider globalPointToLocal: event position.
	slider isHorizontal
		ifTrue: [
			v := tmp x.
			v := v min: (slider valueToX: slider maxValue).
			v := v max: (slider valueToX: slider minValue) ]
		ifFalse: [
			v := tmp y.
			v := v min: (slider valueToY: slider minValue).
			v := v max: (slider valueToY: slider maxValue) ].

	slider changedCursorPosition: v.
	slider currentValue: val
]

{ #category : #'api - accessing' }
BlCleanSliderHandler >> sliderInteractorPushed: event [

	| value pt1 pt2 slider |
	slider := event currentTarget.
	slider sliderBar ifNil: [ ^self ].
	value := slider  pointToValue:
		         (slider   sliderBackground globalPointToLocal: event position).
	pt1 := slider  valueToX: value.
	pt2 := slider  valueToX: slider  currentValue.
	(slider  is: pt1 near: pt2) ifTrue: [
		slider  interactorPushedPoint: event position copy ]
]

{ #category : #'api - accessing' }
BlCleanSliderHandler >> sliderInteractorReleased: event [
	| slider | 
	slider := event currentTarget.
	slider interactorPushedPoint isNil ifTrue: [ ^ self ].
	slider interactorPushedPoint: nil.
	slider validatedValue: slider currentValue
]
