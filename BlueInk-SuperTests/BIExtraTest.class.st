Class {
	#name : #BIExtraTest,
	#superclass : #BIConfigurableFormatterFormattingTest,
	#category : #'BlueInk-SuperTests'
}

{ #category : #'instance creation' }
BIExtraTest >> rawSimple [ 
	"I'm a rather simple method but already we can check some pretty printing points."
|x|
x:=2.
x:=x + 1.
^x.
]

{ #category : #'instance creation' }
BIExtraTest >> simple [
	"I'm a rather simple method but already we can check some pretty printing points."

	| x |
	x := 2.
	x := x + 1.
	^ x
]

{ #category : #tests }
BIExtraTest >> test [ 

	self validate: #rawSimple isFormattedAs: #simple

]

{ #category : #utils }
BIExtraTest >> validate: aRawSelector isFormattedAs: aSelector [
	"We compare that the pretty printed value of the method whose selector is aRawSelector is the same as the one of aSelector."
	
	| tree1 source |
	tree1 := RBParser parseMethod: (self class sourceCodeAt: aRawSelector).
	tree1 selector: aSelector. 
	"I patched the selector so that I can compare a method with a different name but the same body."
	source := self formatterClass new format: tree1.
	self assert: source equals: (self class sourceCodeAt: aSelector)
]
