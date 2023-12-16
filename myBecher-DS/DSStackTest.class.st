Class {
	#name : 'DSStackTest',
	#superclass : 'TestCase',
	#instVars : [
		'empty',
		'nonEmpty'
	],
	#category : 'myBecher-DS-Stack',
	#package : 'myBecher-DS',
	#tag : 'Stack'
}

{ #category : 'requirements' }
DSStackTest >> empty [
	
	^ empty
]

{ #category : 'requirements' }
DSStackTest >> nonEmpty [
	
	^ nonEmpty
]

{ #category : 'setup' }
DSStackTest >> setUp [
	super setUp.
	empty := self stackClass new.
	nonEmpty := self stackClass new.
	nonEmpty push: 1.
	nonEmpty push: -2.
	nonEmpty push: 3.
	nonEmpty push: 1.
	
]

{ #category : 'setup' }
DSStackTest >> stackClass [

	^ DSStack
]

{ #category : 'tests' }
DSStackTest >> testEmptyError [

	| aStack |
	aStack := self stackClass new.
	self should: [ aStack top ] raise: Error.
	self should: [ aStack pop ] raise: Error.
	aStack push: 'element'.
	aStack top.
	aStack pop.	"The stack is empty again due to previous pop"
	self should: [ aStack top ] raise: Error.
	self should: [ aStack pop ] raise: Error
]

{ #category : 'tests' }
DSStackTest >> testIsEmpty [

	| aStack |
	aStack := self stackClass new.
	self assert: aStack isEmpty.
	aStack push: 1.
	self deny: aStack isEmpty

]

{ #category : 'tests' }
DSStackTest >> testPop [

	| aStack res elem |
	elem := 'anElement'.	
	aStack := self stackClass new.
	self assert: aStack isEmpty.
	
	aStack push: 'a'.
	aStack push: elem.
	res := aStack pop.	
	self assert: res equals: elem.
	self assert: res == elem.
	
	self assert: aStack size equals: 1.
	aStack pop.
	self assert: aStack isEmpty.


]

{ #category : 'tests' }
DSStackTest >> testPush [
	
	| aStack |
	aStack := self stackClass new.
	aStack push: 'a'.
	self assert: aStack size equals: 1.	
	aStack push: 'b'.
	self assert: aStack size equals: 2.
	
]

{ #category : 'tests' }
DSStackTest >> testSize [
	
	| aStack |
	aStack := self stackClass new.
	self assert: aStack size equals: 0.
	aStack push: 'a'.
	self assert: aStack size equals: 1.
	aStack push: 'b'.
	self assert: aStack size equals: 2.
	aStack pop.
	self assert: aStack size equals: 1.
	aStack pop.
	self assert: aStack size equals: 0.

 
	



]

{ #category : 'tests' }
DSStackTest >> testTop [

	| aStack |
	aStack := self stackClass new.
	self assert: aStack isEmpty.
	aStack push: 'a'.
	aStack push: 'b'.
	self assert: aStack top equals: 'b'.
	self assert: aStack top equals: 'b'.
	self assert: aStack size equals: 2.
]
