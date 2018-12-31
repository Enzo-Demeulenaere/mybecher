Class {
	#name : #BIExtrasConfigurableFormatter,
	#superclass : #BIConfigurableFormatter,
	#instVars : [
		'newLinesBetweenTopComments'
	],
	#category : #'BlueInk-SuperTests'
}

{ #category : #'private-formatting' }
BIExtrasConfigurableFormatter >> formatMethodBodyFor: aMethodNode [
	self
		indentAround: [ 
			self newLines: self newLinesAfterMethodPattern.
			self formatMethodCommentFor: aMethodNode.
			self formatPragmasFor: aMethodNode.
			self visitNode: aMethodNode body ]
]

{ #category : #'private-formatting' }
BIExtrasConfigurableFormatter >> formatMethodCommentFor: aMethodNode [

	originalSource isNil
		ifTrue: [ ^ self ].
	aMethodNode comments
		do: [ :each | 
			self useBasicCommentFormat
				ifTrue: [ self basicFormatCommentFor: each ]
				ifFalse: [ self resizeCommentFor: each startingAt: 0 ]]
		separatedBy: [ self newLines: self newLinesBetweenTopComments ].
	self newLines: self newLinesAfterMethodComment
]

{ #category : #initialization }
BIExtrasConfigurableFormatter >> initialize [ 	

	super initialize. 
	self newLinesBetweenTopComments: 1.
]

{ #category : #'private-formatting' }
BIExtrasConfigurableFormatter >> newLinesBetweenTopComments [
			
	^ newLinesBetweenTopComments
]

{ #category : #'private-formatting' }
BIExtrasConfigurableFormatter >> newLinesBetweenTopComments: anInteger [
	"This variable control the number of lines separating the first top comments of a method.
	Usually the value should be 1 to indicate that comments should be stacked one after the others."
	
	newLinesBetweenTopComments := anInteger
]
