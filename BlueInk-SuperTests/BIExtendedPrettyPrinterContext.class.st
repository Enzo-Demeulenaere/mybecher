Class {
	#name : #BIExtendedPrettyPrinterContext,
	#superclass : #BIPrettyPrinterContext,
	#instVars : [
		'newLinesAfterCommentZone',
		'newLinesBetweenTopComments',
		'newLinesAfterSignature'
	],
	#category : #'BlueInk-SuperTests'
}

{ #category : #accessing }
BIExtendedPrettyPrinterContext >> initialize [ 
	super initialize.
	self newLinesBetweenTopComments: 1. "we want each comments to start on a separate line"
	self newLinesAfterCommentZone: 1. "we want comments to be separated by an empty line"
	self newLinesAfterSignature: 0. "we want to have comment without extra empty line"
	
]

{ #category : #accessing }
BIExtendedPrettyPrinterContext >> newLinesAfterCommentZone [
	"return the number of empty lines after the top comments"
	
	^ newLinesAfterCommentZone
]

{ #category : #accessing }
BIExtendedPrettyPrinterContext >> newLinesAfterCommentZone: anInteger [
	"return the number of empty lines after the top comments: to have a empty line then use 1. To have code glued to comment use 0."
	
	newLinesAfterCommentZone := anInteger
]

{ #category : #accessing }
BIExtendedPrettyPrinterContext >> newLinesAfterSignature [
	"Return the number of new empty lines after the signature."
	
	^ newLinesAfterSignature
	
]

{ #category : #accessing }
BIExtendedPrettyPrinterContext >> newLinesAfterSignature: anInteger [
	"Return the number of new empty lines after the signature."
	
	newLinesAfterSignature := anInteger
	
]

{ #category : #accessing }
BIExtendedPrettyPrinterContext >> newLinesBetweenTopComments [
	"Return the number of empty lines between the top comments: usually the comments are starting on each line."
	
	^ newLinesBetweenTopComments
]

{ #category : #accessing }
BIExtendedPrettyPrinterContext >> newLinesBetweenTopComments: anInteger [

	newLinesBetweenTopComments := anInteger
]
