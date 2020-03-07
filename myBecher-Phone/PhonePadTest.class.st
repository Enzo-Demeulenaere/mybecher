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

{ #category : #tests }
PhonePadTest >> testD3EqualF [

	self assert: (phonepad decode: $D and: 3) equals: $F.
]
