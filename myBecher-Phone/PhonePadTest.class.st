Class {
	#name : #PhonePadTest,
	#superclass : #TestCase,
	#instVars : [
		'phonepad'
	],
	#category : #'myBecher-Phone'
}

{ #category : #running }
PhonePadTest >> setUp [

	phonepad := PhonePad new.



	

]

{ #category : #tests }
PhonePadTest >> testA3EqualC [

	self assert: (phonepad decode: $A and: 3) equals: $C.
]
