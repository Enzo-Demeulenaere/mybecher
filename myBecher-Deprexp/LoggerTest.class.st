Class {
	#name : #LoggerTest,
	#superclass : #TestCase,
	#category : #'myBecher-Deprexp-myBecher-Deprexp'
}

{ #category : #tests }
LoggerTest >> testLogger [

	self assert: (Logger new log: 'a message') equals: 'a message'
]
