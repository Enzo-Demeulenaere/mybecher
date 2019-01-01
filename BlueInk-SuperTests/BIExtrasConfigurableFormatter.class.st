"
Todo:

API should be better
	newLineBeforeXY -> wantsNewLineBeforeXY
	
	newLines: -> emitNewLines:
	

"
Class {
	#name : #BIExtrasConfigurableFormatter,
	#superclass : #BIConfigurableFormatter,
	#instVars : [
		'newLinesBetweenTopComments'
	],
	#category : #'BlueInk-SuperTests'
}

{ #category : #'private-formatting' }
BIExtrasConfigurableFormatter >> emitNonTabulatedNewLines: anInteger [

	anInteger	 timesRepeat: [ codeStream cr ].
	lineStart := codeStream position.
	
]

{ #category : #'private-formatting' }
BIExtrasConfigurableFormatter >> emitTabulatedNewLinesAfterEndOfCommentZone [
	self newLines: self newLinesAfterMethodComment
]

{ #category : #'private-formatting' }
BIExtrasConfigurableFormatter >> emitTabulatedNewLinesAfterMethodPattern [
	self newLines: self newLinesAfterMethodPattern
]

{ #category : #'private-formatting' }
BIExtrasConfigurableFormatter >> formatMethodBodyFor: aMethodNode [
	
	self tab.
	self formatPragmasFor: aMethodNode.
	self visitNode: aMethodNode body
]

{ #category : #'private-formatting' }
BIExtrasConfigurableFormatter >> formatMethodCommentFor: aMethodNode [

	originalSource isNil
		ifTrue: [ ^ self ].
	aMethodNode comments
				do: [ :each | 
					self useBasicCommentFormat
						ifTrue: [ self basicFormatCommentFor: each ]
						ifFalse: [ self resizeCommentFor: each startingAt: 0 ] ]
				separatedBy: [ self newLines: self newLinesBetweenTopComments ] 
]

{ #category : #'private-formatting' }
BIExtrasConfigurableFormatter >> formatMethodPatternFor: aMethodNode [
	aMethodNode arguments isEmpty
		ifTrue: [ codeStream nextPutAll: aMethodNode selector ]
		ifFalse: [ 
			(self needsMethodSignatureOnMultipleLinesFor: aMethodNode)
				ifTrue: [ self privateFormatMethodPatternMultiLineFor: aMethodNode ]
				ifFalse: [ self privateFormatMethodPatternMonoLineFor: aMethodNode ] ]
]

{ #category : #'low operations' }
BIExtrasConfigurableFormatter >> increaseIndent [

	indent := indent + 1
]

{ #category : #initialization }
BIExtrasConfigurableFormatter >> initialize [ 	

	super initialize. 
	self newLinesBetweenTopComments: 1.
]

{ #category : #'configuration options' }
BIExtrasConfigurableFormatter >> newLinesBetweenTopComments [
			
	^ newLinesBetweenTopComments
]

{ #category : #'configuration options' }
BIExtrasConfigurableFormatter >> newLinesBetweenTopComments: anInteger [
	"This variable control the number of lines separating the first top comments of a method.
	Usually the value should be 1 to indicate that comments should be place on following line one after the others."
	
	newLinesBetweenTopComments := anInteger
]

{ #category : #'configuration options' }
BIExtrasConfigurableFormatter >> sizeOfLongLine [
	"Returns the number of characters after which we consider that we have a long line."
	"In the future we may compute, and also turn it into a configuration parameter."
	 
	^ 66
]

{ #category : #'low operations' }
BIExtrasConfigurableFormatter >> tab [ 
	indent timesRepeat: [ codeStream nextPutAll: self indentString ]
]

{ #category : #visiting }
BIExtrasConfigurableFormatter >> visitMethodNode: aMethodNode [
	
	| totalNumberOfLinesAfterCommentZone |
	totalNumberOfLinesAfterCommentZone := self newLinesAfterMethodComment + 1.
	self formatMethodPatternFor: aMethodNode.
	self emitNonTabulatedNewLines: 1.
	self increaseIndent.
	
	aMethodNode hasComments 
		ifTrue: [ 
			self tab. 
			"we separate the tab emission from the increase to be able to generate a line with a single tab
when the comment are empty"
			self formatMethodCommentFor: aMethodNode ]
		ifFalse: [totalNumberOfLinesAfterCommentZone := totalNumberOfLinesAfterCommentZone - 1 ].
	
	self emitNonTabulatedNewLines: totalNumberOfLinesAfterCommentZone - 1.
	self formatMethodBodyFor: aMethodNode
]
