Class {
	#name : #BIExtraTest,
	#superclass : #BIConfigurableFormatterFormattingTest,
	#instVars : [
		'configurationSelector'
	],
	#category : #'BlueInk-SuperTests'
}

{ #category : #configurations }
BIExtraTest >> advancedPrettyPrinterConfiguration [
	"Here we can control explicitely the configuration we want."
	"
	String streamContents: [:s |
			BIPrettyPrinterContext new storeOn: s]  
	"
	^ 
	
BIPrettyPrinterContext new
	formatCommentWithStatements: false;
	
	indentString: '	';
	"we use a tab to indent method body"

	newLinesAfterMethodPattern: 1;
		"Comments are put on the line after the signature without empty line"
	
	newLinesAfterMethodComment: 1;
		"After the comments (even empty) we let one empty line"
	
	indentsForKeywords: 1;
	keepBlockInMessage: true;
	lineUpBlockBrackets: false;
	maxLineLength: 70;
	methodSignatureOnMultipleLines: false;
	minimumNewLinesBetweenStatements: 1;
	multiLineMessages: #(#ifTrue:ifFalse: #ifFalse:ifTrue: #ifTrue: #ifFalse: #on:do: #ensure: #ifCurtailed:);
	newLineAfterCascade: true;
	newLineBeforeFirstCascade: true;
	newLineBeforeFirstKeyword: false;

	
	newLinesAfterTemporaries: 1;
	numberOfArgumentsForMultiLine: 4;
	oneLineMessages: #(#to: #to:do: #to:by: #to:by:do:);
	periodsAtEndOfBlock: false;
	periodsAtEndOfMethod: false;
	retainBlankLinesBeforeComments: true;
	retainBlankLinesBetweenStatements: false;
	selectorAndArgumentCombinedMaxSize: 40;
	
	stringFollowingReturn: ' ' ;
	"a return is separated by a space ^a => ^ a"
	
	stringInsideBlocks: ' ' ;
	stringInsideParentheses: '';
	traditionalBinaryPrecedenceArray: #(#($| $& $?) #($= $~ $< $>) #($- $+) #($* $/ $% $\) #($@));
	useBasicCommentFormat: true;
	useTraditionalBinaryPrecedenceForParentheses: true
	

]

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
	^ 
	
BIPrettyPrinterContext new
	formatCommentWithStatements: false;
	
	indentString: '	';
	"we use a tab to indent method body"

	newLinesAfterMethodPattern: 1;
		"Comments are put on the line after the signature without empty line"
	
	newLinesAfterMethodComment: 1
		"After the comments (even empty) we let one empty line"

]

{ #category : #configurations }
BIExtraTest >> noEmptyLineAfterCommentsConfiguration [
	"Here we can control explicitely the configuration we want."
	"
	String streamContents: [:s |
			BIPrettyPrinterContext new storeOn: s]  
	"
	^ 
	
BIPrettyPrinterContext new
		newLinesAfterMethodComment: 1
		"After the comments (even empty) we let one empty line"
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

{ #category : #configurations }
BIExtraTest >> setAdvancedConfiguration [

	configurationSelector := #advancedPrettyPrinterConfiguration
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
