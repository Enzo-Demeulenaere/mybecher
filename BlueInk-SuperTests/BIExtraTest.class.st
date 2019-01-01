Class {
	#name : #BIExtraTest,
	#superclass : #BIConfigurableFormatterFormattingTest,
	#instVars : [
		'configurationSelector'
	],
	#category : #'BlueInk-SuperTests'
}

{ #category : #hooks }
BIExtraTest >> formatter [
	^ self formatterClass new
		installNewContext: (self perform: configurationSelector)
		yourself
]

{ #category : #hooks }
BIExtraTest >> formatterClass [
	^ BIExtrasConfigurableFormatter
]

{ #category : #'source - result - new lines and tabulated' }
BIExtraTest >> newLineAfterCommentZoneNoCommentStillHaveANewLine [

	| x |
	x := 2.
	x := x + 1.
	^ x
]

{ #category : #'source - result - new lines and tabulated' }
BIExtraTest >> newLineAfterCommentZoneSimple [
	"I'm a rather simple method but already we can check some pretty printing points."

	| x |
	x := 2.
	x := x + 1.
	^ x
]

{ #category : #'source - result - new lines and tabulated' }
BIExtraTest >> newLineAfterCommentZoneSimpleNoExtraSpace [
	"There should be no space at the end of the line and only tab to start with."

	| x |
	x := 2.
	x := x + 1.
	^ x
]

{ #category : #'source - result - new lines and tabulated' }
BIExtraTest >> newLineAfterCommentZoneWithTwoSubsequentComments [
	"first comment"
	"second comment"

	^ 'there should only one empty line'
]

{ #category : #configurations }
BIExtraTest >> newLinesHaveCommentZoneConfiguration [
	"Here we can control explicitely the configuration we want."
	"
	String streamContents: [:s |
			BIPrettyPrinterContext new storeOn: s]  
	"
	^ BIPrettyPrinterContext new
		formatCommentWithStatements: false;
		indentString: '	';	"we use a tab to indent method body"
		newEmptyLineAfterMethodCommentZone ; "equivalent to"
			newLinesAfterMethodComment: 2
			"
			We do two line return: one for the empty line and one for the method body start.
			After the comments (even empty) we let one empty line
			"

]

{ #category : #configurations }
BIExtraTest >> noEmptyLineAfterCommentsConfiguration [
	"Here we can control explicitely the configuration we want."
	"
	String streamContents: [:s |
			BIPrettyPrinterContext new storeOn: s]  
	"
	^ BIPrettyPrinterContext new
		formatCommentWithStatements: false;
		newLinesAfterMethodComment: 1
			"After the comments (even empty) we don't let one empty line.
			We just issue one new line for the method body"
]

{ #category : #'source - result - no newline' }
BIExtraTest >> noNewLineAfterCommentZoneNoComment [
	| x |
	x := 2.
	x := x + 1.
	^ x
]

{ #category : #'source - result - no newline' }
BIExtraTest >> noNewLineAfterCommentZoneWithTwoSubsequentComments [
	"first comment"
	"second comment"
	^ 'there should only one empty line'
]

{ #category : #'source - result - no newline' }
BIExtraTest >> noNewLinesSimple [
	"I'm a rather simple method but already we can check some pretty printing points."
	| x |
	x := 2.
	x := x+1.
	^ x.
]

{ #category : #'source - raw methods' }
BIExtraTest >> rawSimple [ 
	"I'm a rather simple method but already we can check some pretty printing points."
|x|
x:=2.
x:=x+1.
^x.
]

{ #category : #'source - raw methods' }
BIExtraTest >> rawSimpleFunkyExtraSpaces [     
  "There should be no space at the end of the line and only tab to start with."

  | x |
  x := 2.  
     x := x + 1.  
	^ x  
]

{ #category : #'source - raw methods' }
BIExtraTest >> rawSimpleNoComment [
| x |
x := 2.
x := x + 1.
^ x
]

{ #category : #'source - raw methods' }
BIExtraTest >> rawWithTwoSubsequentComments [
	"first comment"
	"second comment"
	
	^ 'there should only one empty line'
]

{ #category : #'tests - new lines' }
BIExtraTest >> testNewLineAfterCommentZoneWhenNoComment [

	configurationSelector := #newLinesHaveCommentZoneConfiguration.
	self 
		validate: #rawSimpleNoComment 
		isFormattedAs: #newLineAfterCommentZoneNoCommentStillHaveANewLine.
	
]

{ #category : #'simple tests' }
BIExtraTest >> testNewLineBetweenTopCommentsIsInitialized [

	self assert: BIExtrasConfigurableFormatter new newLinesBetweenTopComments equals: 1
]

{ #category : #'tests - new lines' }
BIExtraTest >> testNewLinesAfterCommentZone [

	configurationSelector := #newLinesHaveCommentZoneConfiguration.
	self 
		validate: #rawWithTwoSubsequentComments 
		isFormattedAs: #newLineAfterCommentZoneWithTwoSubsequentComments.
	self 
		validate: #rawSimple 
		isFormattedAs: #newLineAfterCommentZoneSimple.
	self 
		validate: #rawSimpleFunkyExtraSpaces 
		isFormattedAs: #newLineAfterCommentZoneSimpleNoExtraSpace.
	
]

{ #category : #'tests - no newlines' }
BIExtraTest >> testNoNewLineAfterCommentZoneWhenNoComment [

	configurationSelector := #noEmptyLineAfterCommentsConfiguration.
	self 
		validate: #rawSimpleNoComment 
		isFormattedAs: #noNewLineAfterCommentZoneNoComment
	
]

{ #category : #'tests - no newlines' }
BIExtraTest >> testNoNewLineAfterWithTwoSubsequentComments [

	configurationSelector := #noEmptyLineAfterCommentsConfiguration.
	self 
		validate: #rawWithTwoSubsequentComments 
		isFormattedAs: #noNewLineAfterCommentZoneWithTwoSubsequentComments

]

{ #category : #'tests - new lines' }
BIExtraTest >> testnewLineAfterWithTwoSubsequentComments [

	configurationSelector := #newLinesHaveCommentZoneConfiguration.
	self 
		validate: #rawWithTwoSubsequentComments 
		isFormattedAs: #newLineAfterCommentZoneWithTwoSubsequentComments.

]

{ #category : #utils }
BIExtraTest >> validate: aRawSelector isFormattedAs: aSelector [
	"We compare that the pretty printed value of the method whose selector is aRawSelector is the same as the one of aSelector."

	| tree1 source |
	tree1 := RBParser parseMethod: (self class sourceCodeAt: aRawSelector).
	tree1 selector: aSelector.
	"I patched the selector so that I can compare a method with a different name but the same body."
	source := self formatter format: tree1.
	self assert: source equals: (self class sourceCodeAt: aSelector)
]
