Class {
	#name : #BIExtrasConfigurableFormatter,
	#superclass : #BIConfigurableFormatter,
	#category : #'BlueInk-SuperTests'
}

{ #category : #'private-formatting' }
BIExtrasConfigurableFormatter >> formatMethodCommentFor: aMethodNode [

	originalSource isNil
		ifTrue: [ ^ self ].
	aMethodNode comments
		do: [ :each | 
			self useBasicCommentFormat
				ifTrue: [ self basicFormatCommentFor: each ]
				ifFalse: [ self resizeCommentFor: each startingAt: 0 ].
			self newLines: self newLinesAfterMethodComment
			].
	
]
