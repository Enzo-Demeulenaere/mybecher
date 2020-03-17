"
Counter new increment; increment
"
Class {
	#name : #Person,
	#superclass : #Object,
	#traits : 'TCounting',
	#classTraits : 'TCounting classTrait',
	#category : #'myBecher-Traits'
}

{ #category : #initialization }
Person >> initialize [

	self initializeTCounting
]

{ #category : #accessing }
Person >> name [ 
	^ 'Bob'
]
