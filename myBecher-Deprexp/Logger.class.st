Class {
	#name : #Logger,
	#superclass : #Object,
	#category : #'myBecher-Deprexp-myBecher-Deprexp'
}

{ #category : #'instance creation' }
Logger >> log: aMessage [

	self 
		deprecated: 'Use: #logMessage: instead'
		transformWith: '`rec log: `arg' -> '`rec logMessage: `arg'.
	^ self logMessage: aMessage 
]

{ #category : #'instance creation' }
Logger >> logMessage: aMessage [ 
	
	^ aMessage
]
