Class {
	#name : #BIExtraTest,
	#superclass : #BIConfigurableFormatterFormattingTest,
	#instVars : [
		'configurationSelector'
	],
	#category : #'BlueInk-SuperTests'
}

{ #category : #configuration }
BIExtraTest >> advancedConfiguration [

	configurationSelector := #advancedPrettyPrinterConfiguration
]

{ #category : #configuration }
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
	
	newLinesAfterMethodComment: 2;
	"After the comments we let one empty line"
	
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

{ #category : #configuration }
BIExtraTest >> defaultConfiguration [

	configurationSelector := #prettyPrinterConfiguration
]

{ #category : #configuration }
BIExtraTest >> formatter [
	^ self formatterClass new
		installNewContext: (self perform: configurationSelector)
		yourself
]

{ #category : #configuration }
BIExtraTest >> formatterClass [
	^ BIExtrasConfigurableFormatter
]

{ #category : #configuration }
BIExtraTest >> prettyPrinterConfiguration [
	"Here we can control explicitely the configuration we want."
	"
	String streamContents: [:s |
			BIPrettyPrinterContext new storeOn: s]  
	"
	^ 
	
BIPrettyPrinterContext new
	
]

{ #category : #'simple methods' }
BIExtraTest >> rawSimple [ 
	"I'm a rather simple method but already we can check some pretty printing points."
|x|
x:=2.
x:=x+1.
^x.
]

{ #category : #'simple methods' }
BIExtraTest >> rawSimpleNoCommentStillHaveANewLine [
	| x |
	x := 2.
	x := x + 1.
	^ x
]

{ #category : #'simple methods' }
BIExtraTest >> rawSimpleNoExtraSpace [     
  "There should be no space at the end of the line and only tab to start with."

  | x |
  x := 2.  
     x := x + 1.  
	^ x  
]

{ #category : #'simple methods' }
BIExtraTest >> rawWithTwoSubsequentComments [
	"first comment"
	"second comment"
	
	^ 'there should only one empty line'
]

{ #category : #setUp }
BIExtraTest >> setUp [ 

	self defaultConfiguration 
]

{ #category : #'simple methods' }
BIExtraTest >> simple [
	"I'm a rather simple method but already we can check some pretty printing points."

	| x |
	x := 2.
	x := x + 1.
	^ x
]

{ #category : #'simple methods' }
BIExtraTest >> simpleNoCommentStillHaveANewLine [

	| x |
	x := 2.
	x := x + 1.
	^ x
]

{ #category : #'simple methods' }
BIExtraTest >> simpleNoExtraSpace [
	"There should be no space at the end of the line and only tab to start with."

	| x |
	x := 2.
	x := x + 1.
	^ x
]

{ #category : #tests }
BIExtraTest >> testAdvancedConfiguration [

	self advancedConfiguration.
	self validate: #rawSimple isFormattedAs: #simple.
	self validate: #rawSimpleNoExtraSpace isFormattedAs: #simpleNoExtraSpace.
	
]

{ #category : #tests }
BIExtraTest >> testBroken [


	self validate: #rawSimpleNoCommentStillHaveANewLine isFormattedAs: #simpleNoCommentStillHaveANewLine.
	"self advancedConfiguration.
	self validate: #rawSimpleNoCommentStillHaveANewLine isFormattedAs: #simpleNoCommentStillHaveANewLine
	"
]

{ #category : #tests }
BIExtraTest >> testDefaultConfiguration [

	self defaultConfiguration.
	self validate: #rawSimple isFormattedAs: #simple.
	self validate: #rawSimpleNoExtraSpace isFormattedAs: #simpleNoExtraSpace.

]

{ #category : #'simple tests' }
BIExtraTest >> testNewLineBetweenTopCommentsIsInitialized [

	self assert: BIExtrasConfigurableFormatter new newLinesBetweenTopComments equals: 1
]

{ #category : #tests }
BIExtraTest >> testWithTwoSubsequentComments [


	self validate: #rawWithTwoSubsequentComments isFormattedAs: #withTwoSubsequentComments.

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

{ #category : #'simple methods' }
BIExtraTest >> withTwoSubsequentComments [
	"first comment"
	"second comment"

	^ 'there should only one empty line'
]
