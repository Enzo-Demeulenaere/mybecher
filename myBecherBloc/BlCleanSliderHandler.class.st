Class {
	#name : #BlCleanSliderHandler,
	#superclass : #BlCustomEventHandler,
	#category : #myBecherBloc
}

{ #category : #'event management' }
BlCleanSliderHandler >> clickEvent: anEvent [

	self sliderBarClicked: anEvent
]

{ #category : #'event management' }
BlCleanSliderHandler >> dragEndEvent: anEvent [

	self sliderHandleReleased: anEvent
	
]

{ #category : #'event management' }
BlCleanSliderHandler >> eventsToHandle [
	^ { BlMouseDownEvent . BlDragEndEvent . BlMouseUpEvent . BlMouseMoveEvent . BlClickEvent}
]

{ #category : #'event management' }
BlCleanSliderHandler >> mouseDownEvent: anEvent [

	self sliderHandlePushed: anEvent
	
]

{ #category : #'event management' }
BlCleanSliderHandler >> mouseMoveEvent: anEvent [

	self sliderHandleMoved: anEvent.
]

{ #category : #'event management' }
BlCleanSliderHandler >> mouseUpEvent: anEvent [

	self sliderHandleReleased: anEvent
]

{ #category : #actions }
BlCleanSliderHandler >> sliderBarClicked: event [

	| tmp val slider |
	slider := event currentTarget.
	tmp := slider sliderBackground globalPointToLocal: event position.
	val := slider pointToValue: tmp.
	slider validatedValue: val.
]

{ #category : #actions }
BlCleanSliderHandler >> sliderHandleMoved: event [

	| val tmp v slider |
	
	slider := event currentTarget.
	
	slider handlePushedPoint ifNil: [ ^ self ].
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

	slider changedHandlePosition: v.
	slider currentValue: val
]

{ #category : #actions }
BlCleanSliderHandler >> sliderHandlePushed: event [

	| value pt1 pt2 slider |
	slider := event currentTarget.
	slider sliderBar ifNil: [ ^self ].
	value := slider  pointToValue:
		         (slider   sliderBackground globalPointToLocal: event position).
	pt1 := slider  valueToX: value.
	pt2 := slider  valueToX: slider currentValue.
	(slider  is: pt1 near: pt2) ifTrue: [
		slider  handlePushedPoint: event position copy ]
]

{ #category : #actions }
BlCleanSliderHandler >> sliderHandleReleased: event [

	| slider |
	slider := event currentTarget.
	slider handlePushedPoint ifNil: [ ^ self ].
	slider handlePushedPoint: nil.
	slider validatedValue: slider currentValue
]
