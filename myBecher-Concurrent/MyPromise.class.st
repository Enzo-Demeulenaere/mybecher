"
A promise is a value that is concurrently computed by another process and that will eventually returns.
When the value is not available, asking for its value will block the caller until the value is available. 


valueProtectingSemaphore is the semaphore protecting the value. 
hasValue returns true whether a value is available.
value is the 
"
Class {
	#name : #MyPromise,
	#superclass : #Object,
	#instVars : [
		'value',
		'hasValue',
		'raisedException',
		'valueProtectingSemaphore'
	],
	#category : #'myBecher-Concurrent-promise'
}

{ #category : #accessing }
MyPromise class >> script [ 

	| controllingPromise promise |
	controllingPromise := Semaphore new.
	[ (Delay forSeconds: 10) wait.
	controllingPromise signal ] fork.
	promise := [ controllingPromise wait. 
							1 + 3 ] promise. 
	self deny: promise hasValue.
	(Delay forSeconds: 15) wait. 
	self assert: promise hasValue.
	self assert: promise value equals: 4
]

{ #category : #accessing }
MyPromise >> hasValue [

	^ hasValue
]

{ #category : #accessing }
MyPromise >> initialize [
	super initialize.
	valueProtectingSemaphore := Semaphore new.
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
			valueProtectingSemaphore signal.
			true]
		ifFalse:
			[false]
]

{ #category : #'private for block' }
MyPromise >> value [
	"Wait for a value and once it is available returns it"
	valueProtectingSemaphore wait.
	valueProtectingSemaphore signal. 
	"To allow multiple requests for the value."
	^ value 
]

{ #category : #'private for block' }
MyPromise >> value: resultValue [

	value := resultValue.
	hasValue := true.
	valueProtectingSemaphore signal
]

{ #category : #'private for block' }
MyPromise >> valueWithExceptionHandling [

	valueProtectingSemaphore wait.
	valueProtectingSemaphore signal. 
	"To allow multiple requests for the value."
	raisedException == nil
		ifTrue: [ ^value ]
		ifFalse: [ 
				"we got an exception and we stored it now signals it."
				raisedException signalIn: thisContext
				]
]
