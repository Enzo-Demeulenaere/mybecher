"
| d |
d := Duck new.
d speak
"
Class {
	#name : #Counter,
	#superclass : #Object,
	#traits : 'TCounting',
	#classTraits : 'TCounting classTrait',
	#category : #'myBecher-Traits'
}

{ #category : #initialization }
Counter >> initialize [

	self initializeTCounting
]
