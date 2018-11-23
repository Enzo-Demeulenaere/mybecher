Class {
	#name : #OntoClassResources,
	#superclass : #Object,
	#instVars : [
		'x',
		'y'
	],
	#category : #'OntoPharo-Resources\r\t'
}

{ #category : #'polar coordinates' }
OntoClassResources >> adhereTo: aRectangle [
	"If the receiver lies outside aRectangle, return the nearest point on the boundary of the rectangle, otherwise return self."

	(aRectangle containsPoint: self) ifTrue: [^ self].
	^ ((x max: aRectangle left) min: aRectangle right)
		@ ((y max: aRectangle top) min: aRectangle bottom)
]

{ #category : #'polar coordinates' }
OntoClassResources >> degrees [
	"Answer the angle the receiver makes with origin in degrees. right is 0; down is 90."
	| tan theta |
	^ x = 0 
		ifTrue: 
			[ y >= 0 
				ifTrue: [ 90.0 ]
				ifFalse: [ 270.0 ] ]
		ifFalse: 
			[ tan := y asFloat / x asFloat.
			theta := tan arcTan.
			x >= 0 
				ifTrue: 
					[ y >= 0 
						ifTrue: [ theta radiansToDegrees ]
						ifFalse: [ 360.0 + theta radiansToDegrees ] ]
				ifFalse: [ 180.0 + theta radiansToDegrees ] ]
]
