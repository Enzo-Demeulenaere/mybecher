Class {
	#name : #BlCleanSliderHandler,
	#superclass : #BlCustomEventHandler,
	#category : #myBecherBloc
}

{ #category : #'event management' }
BlCleanSliderHandler >> clickEvent: anEvent [

	anEvent currentTarget sliderBarClicked: anEvent
]

{ #category : #'event management' }
BlCleanSliderHandler >> dragEndEvent: anEvent [

	anEvent currentTarget sliderHandleReleased
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

	anEvent currentTarget sliderHandleReleased
]
