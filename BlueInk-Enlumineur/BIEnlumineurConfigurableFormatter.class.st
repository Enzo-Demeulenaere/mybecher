"
Todo:

API should be better
	newLineBeforeXY -> wantsNewLineBeforeXY
	
	newLines: -> emitNewLines:
	

"
Class {
	#name : #BIEnlumineurConfigurableFormatter,
	#superclass : #BIConfigurableFormatter,
	#instVars : [
		'newLinesBetweenTopComments',
		'newLinesAfterSignature',
		'newLinesAfterCommentZone'
	],
	#category : #'BlueInk-Enlumineur'
}

{ #category : #'private-formatting' }
BIEnlumineurConfigurableFormatter >> emitNonTabulatedNewLines: anInteger [

	anInteger	 timesRepeat: [ codeStream cr ].
	lineStart := codeStream position.
	
]

{ #category : #'low operations' }
BIEnlumineurConfigurableFormatter >> emitTabs [ 
	indent timesRepeat: [ codeStream nextPutAll: self indentString ]
]

{ #category : #'private-formatting' }
BIEnlumineurConfigurableFormatter >> emitTabulatedNewLinesAfterEndOfCommentZone [
	self newLines: self newLinesAfterMethodComment
]

{ #category : #'private-formatting' }
BIEnlumineurConfigurableFormatter >> emitTabulatedNewLinesAfterMethodPattern [
	self newLines: self newLinesAfterMethodPattern
]

{ #category : #'private-formatting' }
BIEnlumineurConfigurableFormatter >> formatMethodBodyFor: aMethodNode [
	
	self emitTabs.
	self formatPragmasFor: aMethodNode.
	self visitNode: aMethodNode body
]

{ #category : #'private-formatting' }
BIEnlumineurConfigurableFormatter >> formatMethodCommentFor: aMethodNode [

	originalSource isNil
		ifTrue: [ ^ self ].
	aMethodNode comments
				do: [ :each | 
					self useBasicCommentFormat
						ifTrue: [ self basicFormatCommentFor: each ]
						ifFalse: [ self resizeCommentFor: each startingAt: 0 ] ]
				separatedBy: [ self newLines: self newLinesBetweenTopComments ].
	self emitNonTabulatedNewLines: 1. 
	"We have finished the comments and we create the beginning of next line being empty or not"
]

{ #category : #'private-formatting' }
BIEnlumineurConfigurableFormatter >> formatMethodPatternFor: aMethodNode [
	aMethodNode arguments isEmpty
		ifTrue: [ codeStream nextPutAll: aMethodNode selector ]
		ifFalse: [ 
			(self needsMethodSignatureOnMultipleLinesFor: aMethodNode)
				ifTrue: [ self privateFormatMethodPatternMultiLineFor: aMethodNode ]
				ifFalse: [ self privateFormatMethodPatternMonoLineFor: aMethodNode ] ].
	"We position the cursor on a new line being empty or not"
	self newLine
]

{ #category : #'low operations' }
BIEnlumineurConfigurableFormatter >> increaseIndent [

	indent := indent + 1
]

{ #category : #initialization }
BIEnlumineurConfigurableFormatter >> initialize [

	super initialize.
	self installNewContext: BIExtendedPrettyPrinterContext new.
]

{ #category : #private }
BIEnlumineurConfigurableFormatter >> needsMethodSignatureOnMultipleLinesFor: aMethodNode [

	^ self methodSignatureOnMultipleLines
		ifTrue: [ aMethodNode signatureSize >  self selectorAndArgumentCombinedMaxSize ]
		ifFalse: [ false ]
]

{ #category : #'configuration options' }
BIEnlumineurConfigurableFormatter >> newLinesAfterCommentZone [
			
	^ context newLinesAfterCommentZone
]

{ #category : #'configuration options' }
BIEnlumineurConfigurableFormatter >> newLinesAfterSignature [
			
	^ context newLinesAfterSignature
]

{ #category : #'configuration options' }
BIEnlumineurConfigurableFormatter >> newLinesBetweenTopComments [
			
	^ context newLinesBetweenTopComments
]

{ #category : #private }
BIEnlumineurConfigurableFormatter >> privateFormatMethodPatternMultiLineFor: aMethodNode [
	| selectors arguments |
	arguments := aMethodNode arguments.
	selectors := aMethodNode selectorParts.
	codeStream nextPutAll: selectors first.
	self space.
	self visitArgumentNode: arguments first.
	self newLine. 
	self
		with: selectors allButFirst
		and: arguments allButFirst
		do: [ :key :arg | 
			codeStream nextPutAll: self indentString.
			codeStream nextPutAll: key.
			self space.
			self visitArgumentNode: arg ]
		separatedBy: [ self characterSeparatorMethodSignatureFor: aMethodNode ]
]

{ #category : #'configuration options' }
BIEnlumineurConfigurableFormatter >> sizeOfLongLine [
	"Returns the number of characters after which we consider that we have a long line."
	"In the future we may compute, and also turn it into a configuration parameter."
	 
	^ 66
]

{ #category : #'low operations' }
BIEnlumineurConfigurableFormatter >> tab [ 
	indent timesRepeat: [ codeStream nextPutAll: self indentString ]
]

{ #category : #visiting }
BIEnlumineurConfigurableFormatter >> visitMethodNode: aMethodNode [

	self formatMethodPatternFor: aMethodNode. "after, cursor is at beginning of line."
	
	self emitNonTabulatedNewLines: self newLinesAfterSignature. 
		"zero for comment glued or one for an empty line"
	
	self increaseIndent.
	
	aMethodNode hasComments 
		ifTrue: [ 
			self emitTabs. 
			self formatMethodCommentFor: aMethodNode
			"after, cursor is at beginning of line." ].
	
	self emitNonTabulatedNewLines: self newLinesAfterCommentZone.
	self formatMethodBodyFor: aMethodNode
]
