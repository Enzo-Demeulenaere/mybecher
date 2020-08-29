Class {
	#name : #PragmaAnnotationTypeTest,
	#superclass : #TestCase,
	#instVars : [
		'atPragma',
		'anotherAtPragma',
		'yetAnotherAtPragma',
		'atPutPragma'
	],
	#category : #'myBecher-MyPragma-Test'
}

{ #category : #utils }
PragmaAnnotationTypeTest class >> methodWithPragma [
	<forPragmaTest: #toto withArg2: 2 andArg3: true>
	
]

{ #category : #running }
PragmaAnnotationTypeTest >> setUp [
	super setUp.
	ForPragmaTestPragma initialize.
	"we compile the method so that a method announcement is raised."
	self class removeSelector: #methodWithPragma.
	self class 
		compile: 'methodWithPragma
	<forPragmaTest: #toto withArg2: 2 andArg3: true>
	' 	classified: 'utils'.




	atPragma := Pragma for: (Object methodDict at: #at:) selector: #primitive: arguments: (Array with: 60).
	anotherAtPragma := Pragma for: (Object methodDict at: #at:) selector: #primitive: arguments: (Array with: 60).
	yetAnotherAtPragma := Pragma for: (Object methodDict at: #at:) selector: #primitive: arguments: (Array with: 60).
	atPutPragma := Pragma for: (Object methodDict at: #at:) selector: #primitive: arguments: (Array with: 61).

]

{ #category : #tests }
PragmaAnnotationTypeTest >> testArgumentAt [
	| pragma |
	pragma := (self class >> #methodWithPragma) pragmas anyOne.
	self assert: (pragma argumentAt: 1) equals: #toto.
	self assert: (pragma argumentAt: 2) equals: 2.
	self assert: (pragma argumentAt: 3)
]

{ #category : #tests }
PragmaAnnotationTypeTest >> testArgumentNamed [
	| pragma |
	pragma := (self class >> #methodWithPragma) pragmas anyOne.
	self assert: (pragma argumentNamed: #testPragmaArg1) equals: #toto.
	self assert: (pragma argumentNamed: #arg2) equals: 2.
	self assert: (pragma argumentNamed: #arg3).
	self should: [ pragma argumentNamed: #nonExisting ] raise: Error
]

{ #category : #tests }
PragmaAnnotationTypeTest >> testArgumentNamedIfNone [
	| pragma |
	pragma := (self class >> #methodWithPragma) pragmas anyOne.
	self assert: (pragma argumentNamed: #arg3 ifNone: [ false ]).
	self deny: (pragma argumentNamed: #nonExisting ifNone: [ false ])
]

{ #category : #tests }
PragmaAnnotationTypeTest >> testCopy [
	| copy |
	copy := atPragma copy.

	self deny: atPragma identicalTo: copy.
	self assert: atPragma method identicalTo: copy method.
	self assert: atPragma selector identicalTo: copy selector.
	self assert: atPragma arguments identicalTo: copy arguments
]

{ #category : #tests }
PragmaAnnotationTypeTest >> testEqual [
	self assert: atPragma equals: atPragma.
	self assert: atPragma equals: anotherAtPragma.
	self assert: anotherAtPragma equals: atPragma.
	self assert: atPragma equals: anotherAtPragma.
	self assert: anotherAtPragma equals: yetAnotherAtPragma.
	self assert: yetAnotherAtPragma equals: atPragma.

	self deny: atPragma equals: atPutPragma
]

{ #category : #tests }
PragmaAnnotationTypeTest >> testHash [
	self assert: atPragma hash equals: atPragma hash.
	self assert: atPragma hash equals: anotherAtPragma hash.
	self assert: anotherAtPragma hash equals: atPragma hash.
	self assert: atPragma hash equals: anotherAtPragma hash.
	self assert: anotherAtPragma hash equals: yetAnotherAtPragma hash.
	self assert: yetAnotherAtPragma hash equals: atPragma hash
]
