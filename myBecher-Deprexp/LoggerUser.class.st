Class {
	#name : #LoggerUser,
	#superclass : #Object,
	#category : #'myBecher-Deprexp'
}

{ #category : #'as yet unclassified' }
LoggerUser >> usingLogger [
	"self new usingLogger"
	
	Logger new log: 'Yes Im using a log'
]
