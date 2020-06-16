Class {
	#name : #Logger,
	#superclass : #Object,
	#category : #'myBecher-Deprexp-myBecher-Deprexp'
}

{ #category : #'instance creation' }
Logger >> log: aMessage [

	self 
		deprecated: 'Use: #log:level: instead'
		transformWith: '`rec log: `arg' -> '`rec log: `arg level: #info'.
	^ self log: aMessage level: #info
]

{ #category : #'instance creation' }
Logger >> log: aMessage level: aSymbol [
	
	^ aSymbol, aMessage
]
