Class {
	#name : #MyOrder,
	#superclass : #Object,
	#instVars : [
		'price',
		'quantity'
	],
	#category : #'myBecher-Concurrent'
}

{ #category : #initialization }
MyOrder class >> set [ 
	| delay1 delay2 order  |
	delay1 := Delay forMilliseconds: 10.
	delay2 := Delay forMilliseconds: 60.
	order := MyOrder new. 
	order quantity: 300 atRandom.
	order price: 200 atRandom.
	{ [[ order price: 1000 atRandom. delay1 wait] repeat ] 
				forkAt: Processor userBackgroundPriority.
	
	[ [ order quantity: 300 atRandom. delay2 wait] repeat ] 
				forkAt: Processor userBackgroundPriority - 2 } inspect

]

{ #category : #printing }
MyOrder >> amount [ 

	^ price * quantity
]

{ #category : #printing }
MyOrder >> initialize [

	quantity := 0.
	price := 0
]

{ #category : #accessing }
MyOrder >> price: anObject [
	price := anObject.
	self printAmount
]

{ #category : #printing }
MyOrder >> printAmount [

	(String streamContents: [ :s |
		| amount |
		s cr.
		s << 'Price: '.
		s print: price. 
		s << ' Quantity: '.
		s print: quantity.
		s << ' = '.
		amount := self amount. 
		s print: amount. 
		s << '('.
		s print: (amount = (price * quantity)).
		s << ')'.
			]) trace
	
]

{ #category : #accessing }
MyOrder >> quantity: anObject [
	quantity := anObject.
	self printAmount
]
