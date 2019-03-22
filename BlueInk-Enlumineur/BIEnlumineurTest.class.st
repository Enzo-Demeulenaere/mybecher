Class {
	#name : #BIEnlumineurTest,
	#superclass : #BIConfigurableFormatterFormattingTest,
	#instVars : [
		'configurationSelector'
	],
	#category : #'BlueInk-Enlumineur'
}

{ #category : #'result/raw - temp with space' }
BIEnlumineurTest >> aloneTemporaries [
	| a b c |
	^ self
]

{ #category : #'result/raw - temp with space' }
BIEnlumineurTest >> aloneTemporariesAndNewLineAfter [
	| a b c |
	a := b + c.
	^ a
]

{ #category : #configurations }
BIEnlumineurTest >> contextClass [
	^ BIExtendedPrettyPrinterContext
]

{ #category : #'result/raw - temp with space' }
BIEnlumineurTest >> emptyTemporaries [
	^ self
]

{ #category : #hooks }
BIEnlumineurTest >> formatter [
	^ self formatterClass new
		installNewContext: (self perform: configurationSelector)
		yourself
]

{ #category : #hooks }
BIEnlumineurTest >> formatterClass [
	^ BIEnlumineurConfigurableFormatter
]

{ #category : #'result - long selectors' }
BIEnlumineurTest >> methodWithTooMany: aParameter
	default: aDefaultValue
	optional: optional
	andCrazy: aStringOrSymbolOrNil [
	"A possible variation."
	"Probably an average comment."

	^ self printString
]

{ #category : #'result - long selectors' }
BIEnlumineurTest >> methodWithTooManyArguments: aParameter default: aDefaultValue optional: optional andCrazy: aStringOrSymbolOrNil [
	"A possible variation."
	"Probably an average comment."

	^ self printString
]

{ #category : #'result - new lines and tabulated' }
BIEnlumineurTest >> newLineAfterCommentZoneNoCommentStillHaveANewLine [

	| x |
	x := 2.
	x := x + 1.
	^ x
]

{ #category : #'result - new lines and tabulated' }
BIEnlumineurTest >> newLineAfterCommentZoneSimple [
	"I'm a rather simple method but already we can check some pretty printing points."

	| x |
	x := 2.
	x := x + 1.
	^ x
]

{ #category : #'result - new lines and tabulated' }
BIEnlumineurTest >> newLineAfterCommentZoneSimpleNoExtraSpace [
	"There should be no space at the end of the line and only tab to start with."

	| x |
	x := 2.
	x := x + 1.
	^ x
]

{ #category : #'result - new lines and tabulated' }
BIEnlumineurTest >> newLineAfterCommentZoneWithTwoSubsequentComments [
	"first comment"
	"second comment"

	^ 'there should only one empty line'
]

{ #category : #configurations }
BIEnlumineurTest >> newLinesAfterCommentZoneConfiguration [
	"Here we can control explicitely the configuration we want."

	"
	String streamContents: [:s |
			BIPrettyPrinterContext new storeOn: s]  
	"

	^ self contextClass new
		formatCommentWithStatements: false;
		indentString: '	';
		newLinesAfterCommentZone: 1
]

{ #category : #configurations }
BIEnlumineurTest >> noEmptyLineAfterCommentsConfiguration [
	"Here we can control explicitely the configuration we want."

	" String streamContents: [:s |
			BIPrettyPrinterContext new storeOn: s]"

	^ self contextClass new
		formatCommentWithStatements: false;
		newLinesAfterCommentZone: 0. "no empty line"
]

{ #category : #'result - no newline' }
BIEnlumineurTest >> noNewLineAfterCommentZoneNoComment [
	| x |
	x := 2.
	x := x + 1.
	^ x
]

{ #category : #'result - no newline' }
BIEnlumineurTest >> noNewLineAfterCommentZoneWithTwoSubsequentComments [
	"first comment"
	"second comment"
	^ 'there should only one empty line'
]

{ #category : #'result - no newline' }
BIEnlumineurTest >> noNewLinesSimple [
	"I'm a rather simple method but already we can check some pretty printing points."
	| x |
	x := 2.
	x := x+1.
	^ x.
]

{ #category : #configurations }
BIEnlumineurTest >> noSpaceForTemporaries [
	"Here we can control explicitely the configuration we want."

	" String streamContents: [:s |
			BIPrettyPrinterContext new storeOn: s]"

	^ self contextClass new
		formatCommentWithStatements: false;
		newLinesAfterCommentZone: 0. 
	" for the moment there is no possibility to not have space i.e. |a b c| 
	we only support | a b c |"
]

{ #category : #'result - terminating period' }
BIEnlumineurTest >> noTerminatingPeriod [
	| a b c |
	b := 10.
	c := 20.
	a := b + c.
	a ifNil: [ b := 30 ].
	^ a
]

{ #category : #configurations }
BIEnlumineurTest >> noTerminatingPeriodConfiguration [
	"Here we can control explicitely the configuration we want."

	" String streamContents: [:s |
			BIPrettyPrinterContext new storeOn: s]"

	^ self contextClass new
		formatCommentWithStatements: false;
		newLinesAfterCommentZone: 0; "no empty line"
		periodsAtEndOfBlock: false
]

{ #category : #'result/raw - complex block' }
BIEnlumineurTest >> notWorkingReceiverAndMessageInFlowAllMethodsSelect: aBlock [ 
	"Answer a SortedCollection of each method that, when used as the block  
	argument to aBlock, gives a true result."
	| aCollection |
	aCollection := OrderedCollection new.
	self allBehaviorsDo: [ :class | class
												selectorsAndMethodsDo: [:sel :m | (aBlock value: m)
																									ifTrue: [aCollection
																													add: (self createMethodNamed: sel realParent: class)]]].
	^ aCollection
]

{ #category : #'result/raw - temp with space' }
BIEnlumineurTest >> rawAloneTemporaries [
	| a b c |
	^ self
]

{ #category : #'result/raw - temp with space' }
BIEnlumineurTest >> rawAloneTemporariesAndNewLineAfter [
	| a b c |a := b + c.^ a
]

{ #category : #'result/raw - temp with space' }
BIEnlumineurTest >> rawEmptyTemporaries [
	| | 
	^ self
]

{ #category : #'source - raw methods' }
BIEnlumineurTest >> rawMethodWithTooMany: aParameter 
	default: aDefaultValue 
	optional: optional 
	andCrazy: aStringOrSymbolOrNil [
	"A possible variation."
	"Probably an average comment."

	^ self printString
]

{ #category : #'source - raw methods' }
BIEnlumineurTest >> rawMethodWithTooManyArguments: aParameter default: aDefaultValue optional: optional andCrazy: aStringOrSymbolOrNil [
	"A possible variation."
	"Probably an average comment."

	^ self printString
]

{ #category : #'source - raw methods' }
BIEnlumineurTest >> rawSimple [ 
	"I'm a rather simple method but already we can check some pretty printing points."
|x|
x:=2.
x:=x+1.
^x.
]

{ #category : #'source - raw methods' }
BIEnlumineurTest >> rawSimpleFunkyExtraSpaces [     
  "There should be no space at the end of the line and only tab to start with."

  | x |
  x := 2.  
     x := x + 1.  
	^ x  
]

{ #category : #'source - raw methods' }
BIEnlumineurTest >> rawSimpleNoComment [
| x |
x := 2.
x := x + 1.
^ x
]

{ #category : #'result - terminating period' }
BIEnlumineurTest >> rawTerminatingPeriod [
	| a b c |
	b := 10. c:=20.
	a := b + c.
	a ifNil: [ b:=30. ].
	^ a.
]

{ #category : #'source - raw methods' }
BIEnlumineurTest >> rawWithTwoSubsequentComments [
	"first comment"
	"second comment"
	
	^ 'there should only one empty line'
]

{ #category : #'result/raw - complex block' }
BIEnlumineurTest >> receiverOnNextIndentAllMethodsSelect: aBlock [ 
	"Answer a SortedCollection of each method that, when used as the block  
	argument to aBlock, gives a true result."
	| aCollection |
	aCollection := OrderedCollection new.
	self allBehaviorsDo: [:class | 
		class selectorsAndMethodsDo: [:sel :m | 
			(aBlock value: m)
				ifTrue: [ aCollection add: (self createMethodNamed: sel realParent: class)]]].
	^ aCollection
]

{ #category : #configurations }
BIEnlumineurTest >> selectorsOnMultipleLines [
	^ self contextClass new
		formatCommentWithStatements: false;
		indentString: '	';
		"we use a tab to indent method body"
			newEmptyLineAfterMethodCommentZone;
		methodSignatureOnMultipleLines: true
]

{ #category : #configurations }
BIEnlumineurTest >> selectorsOnOneLine [
	^ self contextClass new
		formatCommentWithStatements: false;
		indentString: '	';
		"we use a tab to indent method body"
			newEmptyLineAfterMethodCommentZone;
		methodSignatureOnMultipleLines: false
]

{ #category : #configurations }
BIEnlumineurTest >> spaceAndNewLinesForTemporaries [
	"for the moment there is no possibility to not have space i.e. |a b c| 
	we only support | a b c |"

	" String streamContents: [:s |
			BIPrettyPrinterContext new storeOn: s]"

	^ self contextClass new
		newLinesAfterTemporaries: 1;
		newLinesAfterCommentZone: 0.

]

{ #category : #configurations }
BIEnlumineurTest >> spaceForTemporaries [
	"Here we can control explicitely the configuration we want."

	" String streamContents: [:s |
			BIPrettyPrinterContext new storeOn: s]"

	^ self contextClass new
		formatCommentWithStatements: false;
		newLinesAfterCommentZone: 0. 
	" for the moment there is no possibility to not have space i.e. |a b c| 
	we only support | a b c |"
]

{ #category : #'result - terminating period' }
BIEnlumineurTest >> terminatingPeriod [
	| a b c |
	b := 10. 
	c := 20.
	a := b + c.
	a ifNil: [ b := 30. ].
	^ a.
]

{ #category : #'tests - temp' }
BIEnlumineurTest >> testEmptyTemporaries [

	configurationSelector := #spaceAndNewLinesForTemporaries.
	self 
		validate: #rawEmptyTemporaries 
		isFormattedAs: #emptyTemporaries
	
]

{ #category : #'tests - new lines' }
BIEnlumineurTest >> testNewLineAfterCommentZoneWhenNoComment [

	configurationSelector := #newLinesAfterCommentZoneConfiguration.
	self 
		validate: #rawSimpleNoComment 
		isFormattedAs: #newLineAfterCommentZoneNoCommentStillHaveANewLine.
	
]

{ #category : #'simple tests' }
BIEnlumineurTest >> testNewLineBetweenTopCommentsIsInitialized [

	self assert: BIEnlumineurConfigurableFormatter new newLinesBetweenTopComments equals: 1
]

{ #category : #'tests - new lines' }
BIEnlumineurTest >> testNewLinesAfterCommentZone [

	configurationSelector := #newLinesAfterCommentZoneConfiguration.
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
BIEnlumineurTest >> testNoNewLineAfterCommentZoneWhenNoComment [

	configurationSelector := #noEmptyLineAfterCommentsConfiguration.
	self 
		validate: #rawSimpleNoComment 
		isFormattedAs: #noNewLineAfterCommentZoneNoComment
	
]

{ #category : #'tests - no newlines' }
BIEnlumineurTest >> testNoNewLineAfterWithTwoSubsequentComments [

	configurationSelector := #noEmptyLineAfterCommentsConfiguration.
	self 
		validate: #rawWithTwoSubsequentComments 
		isFormattedAs: #noNewLineAfterCommentZoneWithTwoSubsequentComments

]

{ #category : #'tests - terminating period' }
BIEnlumineurTest >> testNoTerminatingTemporaries [

	configurationSelector := #noTerminatingPeriodConfiguration.
	self 
		validate: #rawTerminatingPeriod 
		isFormattedAs: #noTerminatingPeriod

	
]

{ #category : #'tests - long selectors' }
BIEnlumineurTest >> testSelectorOnMultipleLines [

	configurationSelector := #selectorsOnMultipleLines.
	self 
		validate: #rawMethodWithTooManyArguments:default:optional:andCrazy: 
		isFormattedAs: #methodWithTooMany:default:optional:andCrazy:
	
]

{ #category : #'tests - long selectors' }
BIEnlumineurTest >> testSelectorOnOneLine [

	configurationSelector := #selectorsOnOneLine.
	self 
		validate: #rawMethodWithTooManyArguments:default:optional:andCrazy: 
		isFormattedAs: #rawMethodWithTooManyArguments:default:optional:andCrazy:
	
]

{ #category : #'tests - temp' }
BIEnlumineurTest >> testSpaceForTemporaries [

	configurationSelector := #noEmptyLineAfterCommentsConfiguration.
	self 
		validate: #rawAloneTemporaries 
		isFormattedAs: #aloneTemporaries
	
]

{ #category : #'tests - temp' }
BIEnlumineurTest >> testSpaceForTemporariesAndNewLineAfter [

	configurationSelector := #noEmptyLineAfterCommentsConfiguration.
	self 
		validate: #rawAloneTemporariesAndNewLineAfter 
		isFormattedAs: #aloneTemporariesAndNewLineAfter 
	
]

{ #category : #'tests - new lines' }
BIEnlumineurTest >> testnewLineAfterWithTwoSubsequentComments [

	configurationSelector := #newLinesAfterCommentZoneConfiguration.
	self 
		validate: #rawWithTwoSubsequentComments 
		isFormattedAs: #newLineAfterCommentZoneWithTwoSubsequentComments.

]

{ #category : #utils }
BIEnlumineurTest >> validate: aRawSelector isFormattedAs: aSelector [
	"We compare that the pretty printed value of the method whose selector is aRawSelector is the same as the one of aSelector."

	| tree1 source |
	tree1 := RBParser parseMethod: (self class sourceCodeAt: aRawSelector).
	tree1 selector: aSelector.
	"I patched the selector so that I can compare a method with a different name but the same body."
	source := self formatter format: tree1.
	self assert: source equals: (self class sourceCodeAt: aSelector)
]
