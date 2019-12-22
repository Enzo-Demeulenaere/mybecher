"
A promise is a value that is concurrently computed by another process and that will eventually returns.
When the value is not available, asking for its value will block the caller until the value is available. 


sync is the semaphore protecting the value. 
hasValue returns true whether a value is available.
value is the 
"
Class {
	#name : #MyPromise,
	#superclass : #Object,
	#instVars : [
		'sync',
		'value',
		'hasValue',
		'raisedException'
	],
	#category : #'myBecher-Concurrent-promise'
}

{ #category : #accessing }
MyPromise >> hasValue [

	^ hasValue
]

{ #category : #accessing }
MyPromise >> initialize [
	super initialize.
	sync := Semaphore new.
	hasValue := false
]

{ #category : #'private for block' }
MyPromise >> raisedException: anException [
	"Record that the child terminated with an exception, and answer true.  If the exception
	has already been recorded, do nothing and answer false."
	^ raisedException isNil
		ifTrue:
			[ raisedException := anException.
			hasValue := true.
			sync signal.
			true]
		ifFalse:
			[false]
]

{ #category : #'private for block' }
MyPromise >> value [

	sync wait.
	sync signal. 
	"To allow multiple requests for the value."
	^ value 
]

{ #category : #'private for block' }
MyPromise >> value: resultValue [

	value := resultValue.
	hasValue := true.
	sync signal
]

{ #category : #'private for block' }
MyPromise >> valueWithExceptionHandling [

	sync wait.
	sync signal. 
	"To allow multiple requests for the value."
	raisedException == nil
		ifTrue: [ ^value ]
		ifFalse: [ 
				"we got an exception and we stored it now signals it."
				raisedException signalIn: thisContext
				]
]
