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

	anEvent currentTarget sliderHandlePushed: anEvent
]

{ #category : #'event management' }
BlCleanSliderHandler >> mouseMoveEvent: anEvent [

	anEvent currentTarget sliderHandleMoved: anEvent
]

{ #category : #'event management' }
BlCleanSliderHandler >> mouseUpEvent: anEvent [

	anEvent currentTarget sliderHandleReleased: anEvent
]

{ #category : #actions }
BlCleanSliderHandler >> sliderBarClicked: event [

	| tmp val slider |
	slider := event currentTarget.
	tmp := slider sliderBackground globalPointToLocal: event position.
	val := slider pointToValue: tmp.
	slider validatedValue: val.
]
