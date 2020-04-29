"
NBexp >> #blockLocalTemp


CompilationContext bytecodeBackend: EncoderForSistaV1.
CompilationContext optionFullBlockClosure: true.
NBexp recompile: #blockLocalTemp.
(NBexp >> #blockLocalTemp) inspect


blockLocalTemp
	| collection |
	collection := OrderedCollection new.
	#(1 2 3) do: [ :index |
		| temp |
		temp := index.
		collection add: [ temp ] ].
	^ collection collect: [ :each | each value ]
	
String streamContents: [ :str | 
	(NBexp >> #blockLocalTemp) symbolicBytecodes 
		do: [ :each | str << each printString;cr  ]
	 ]

"
Class {
	#name : #NBexp,
	#superclass : #TestCase,
	#instVars : [
		'block',
		'x',
		'stream'
	],
	#category : #'myBecher-Block'
}

{ #category : #'3-accessing shared variables' }
NBexp >> accessingSharedVariables [
	| t |
	^ String streamContents: [ :st |  
		t := 42.
		self executeBlock: [ st print: t. st cr. t := 99. st print: t. st cr ].
		self executeBlock: [ st print: t. st cr. t := 66. st print: t. st cr. ].
		self executeBlock: [ st print: t. st cr. ]
		 ]
]

{ #category : #'9-explicit return' }
NBexp >> arg: aBlock [
	| res |
	self traceCr: 'arg start'.
	res := self executeBlock: aBlock.
	self traceCr: 'arg end'.
	^ res
]

{ #category : #'7-block allocation' }
NBexp >> blockLocalTemp [
	| collection |
	collection := OrderedCollection new.
	#(1 2 3) do: [ :index |
		| temp |
		temp := index.
		collection add: [ temp ] ].
	^ collection collect: [ :each | each value ]
]

{ #category : #'7-block allocation' }
NBexp >> blockLocalTemp2 [
	"self new blockLocalTemp2"
	| collection |
	collection := OrderedCollection new.
	#(1 2 3) do: [ :index |
		| temp bloc context |
		temp := index.
		bloc := [ temp ].
		index = 2 ifTrue: [ context := thisContext copy. self halt. ].
		"why when I look at the context it is nil?
		It should not be the context of the [temp] definition because we are a bit after 
		but I do not get why it is nil."
		collection add: [ temp ] ].
	^ collection collect: [ :each | each value ]
]

{ #category : #'7-block allocation' }
NBexp >> blockOutsideTemp [
	| collection temp |
	collection := OrderedCollection new.
	#(1 2 3) do: [ :index | 
		temp := index.
		collection add: [ temp ] ].
	^ collection collect: [ :each | each value ]
]

{ #category : #'9-explicit return' }
NBexp >> contents [ 
	^ stream contents
]

{ #category : #'9-explicit return' }
NBexp >> defineBlock [
	| res |
	self traceCr: 'defineBlock start'.
	res := self arg: [
					        self traceCr: 'block start'.
                            1 isZero ifFalse: [ ^ 33 ].
                            self traceCr: 'block end'. ].
	self traceCr: 'defineBlock end'.
	^ res
]

{ #category : #'9-explicit return' }
NBexp >> defineBlockWithInspect [
	| res |
	self traceCr: 'defineBlock start'.
	res := self arg: [ thisContext home inspect.
					        self traceCr: 'block start'.
                            1 isZero ifFalse: [ ^ 33 ].
                            self traceCr: 'block end'. ].
	self traceCr: 'defineBlock end'.
	^ res
]

{ #category : #'9-explicit return' }
NBexp >> executeBlock: aBlock [
	"endless loop on purpose! If you do not pass an escaping block you are dead."
	| res |
	self traceCr: 'executeBlock start'.
	res := self executeBlock: aBlock value.
	self traceCr: 'executeBlock loops so should never print that one'.
	^  res
]

{ #category : #'5-arguments' }
NBexp >> executeBlockAndIgnoreArgument: arg [
	^ block value
]

{ #category : #'6-self binding' }
NBexp >> executeBlockInAnotherInstance6: aBlock [
	^ NBexp2 new executeBlockInAnotherInstance6: aBlock
]

{ #category : #initialization }
NBexp >> initialize [
	x := 123.
	stream := '' writeStream 
]

{ #category : #'9-explicit return' }
NBexp >> jumpingOut [

	#(1 2 3 4) do: [:each |
					each = 3
						ifTrue: [^ 3]].
	^ 42
]

{ #category : #'6-self binding' }
NBexp >> selfIsCapturedToo [
	^ String 	
			streamContents: [ :st | 
					self executeBlockInAnotherInstance6: [ st print: self ; print: x ] ]
]

{ #category : #'2-changing value' }
NBexp >> setVariableAndChangingVariableBlock [
	| t |
	t := 42.
	^ self executeBlock: [ t := 2008. t ]
]

{ #category : #'1-variable lookup' }
NBexp >> setVariableAndDefineBlock [
	| t |
	t := 42.
	^ self executeBlock: [ t ]
]

{ #category : #'8-outliving' }
NBexp >> sharing [
	| a |
	[ a := 0 ] value.
	^ a
]

{ #category : #'9-explicit return' }
NBexp >> start [
	"self new start"
	| res |
	self traceCr: 'start start'.
	res := self defineBlock.
	self traceCr: 'start end'.
	^ res
]

{ #category : #'3-accessing shared variables' }
NBexp >> testAccessingSharedVariables [

	self assert: self accessingSharedVariables equals: '42
99
99
66
66
'
]

{ #category : #'5-arguments' }
NBexp >> testArg5 [

	self assert: (self testArg5: 'foo') equals: 'foo'
]

{ #category : #'5-arguments' }
NBexp >> testArg5: arg [
	^ String streamContents: [ :st |  
		block := [ st << arg ].
		self executeBlockAndIgnoreArgument: 'zork']
]

{ #category : #'7-block allocation' }
NBexp >> testBlockLocalTemp [
	
	self assert: self blockLocalTemp asArray equals: #(1 2 3)
]

{ #category : #'7-block allocation' }
NBexp >> testBlockOutsideTemp [
	
	self assert: self blockOutsideTemp asArray equals: #(3 3 3)
]

{ #category : #'9-explicit return' }
NBexp >> testJumpingOut [

	self assert: self jumpingOut equals: 3
]

{ #category : #'6-self binding' }
NBexp >> testSelfIsCapturedToo [
	
	self assert: self selfIsCapturedToo equals: 'NBexp>>#testSelfIsCapturedToo123'
]

{ #category : #'2-changing value' }
NBexp >> testSetVariableAndChangingVariableBlock [

	self assert: self setVariableAndChangingVariableBlock equals: 2008
]

{ #category : #'1-variable lookup' }
NBexp >> testSetVariableAndDefineBlock [

	self assert: self setVariableAndDefineBlock equals: 42
]

{ #category : #'8-outliving' }
NBexp >> testSharing [
	self assert: self sharing equals: 0
]

{ #category : #'9-explicit return' }
NBexp >> testStart [

	self assert: (self start; contents) equals: 'start start
defineBlock start
arg start
executeBlock start
block start
start end
'
]

{ #category : #'8-outliving' }
NBexp >> testTwoBlockArray [
	
	| array |
	array := self twoBlockArray.
	self assert: array second value equals: 0.
	
	array first value.
	self assert: array second value equals: 2
]

{ #category : #'9-explicit return' }
NBexp >> testValueWithExitBreak [
	| val |
	[ :break |
	    1 to: 10 do: [ :i |
			         val := i.
			         val = 4 ifTrue: [ break value ] ] ] valuePassingEscapingBlock.
	self assert: val equals: 4
]

{ #category : #'4-lookup at execution time' }
NBexp >> testVariableLookupIsDoneAtExecution [

	self assert: self variableLookupIsDoneAtExecution equals: '69'
]

{ #category : #'9-explicit return' }
NBexp >> testWithExplicitReturn [
	self assert: self withExplicitReturn equals: 'one
two'
]

{ #category : #'9-explicit return' }
NBexp >> traceCr: aString [

	stream nextPutAll: aString; cr
]

{ #category : #'8-outliving' }
NBexp >> twoBlockArray [
	| a |
	a := 0.
	^ {[ a := 2] . [a]}
]

{ #category : #'4-lookup at execution time' }
NBexp >> variableLookupIsDoneAtExecution [
	
	^ String streamContents: [ :st |  
		| t |
		t := 42.
		block := [ st print: t ].
		t := 69.
		self executeBlock: block ]
]

{ #category : #'9-explicit return' }
NBexp >> withExplicitReturn [
	^ String streamContents: [:str | 
		str nextPutAll: 'one'; cr.
		0 isZero ifTrue: [ str nextPutAll: 'two'. ^ str contents ].
		str nextPutAll: 'not printed']
]
