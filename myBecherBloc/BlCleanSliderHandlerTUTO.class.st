Class {
	#name : #BlCleanSliderHandlerTUTO,
	#superclass : #BlCustomEventHandler,
	#category : #'myBecherBloc-Slider'
}

{ #category : #'event management' }
BlCleanSliderHandlerTUTO >> clickEvent: anEvent [

	anEvent currentTarget sliderBarClicked: anEvent
]

{ #category : #'event management' }
BlCleanSliderHandlerTUTO >> dragEndEvent: anEvent [

	anEvent currentTarget sliderHandleReleased
]

{ #category : #'event management' }
BlCleanSliderHandlerTUTO >> eventsToHandle [
	^ { BlMouseDownEvent . BlDragEndEvent . BlMouseUpEvent . BlMouseMoveEvent . BlClickEvent}
]

{ #category : #'event management' }
BlCleanSliderHandlerTUTO >> mouseDownEvent: anEvent [

	anEvent currentTarget sliderHandlePushed: anEvent
]

{ #category : #'event management' }
BlCleanSliderHandlerTUTO >> mouseMoveEvent: anEvent [

	anEvent currentTarget sliderHandleMoved: anEvent
]

{ #category : #'event management' }
BlCleanSliderHandlerTUTO >> mouseUpEvent: anEvent [

	anEvent currentTarget sliderHandleReleased
]
