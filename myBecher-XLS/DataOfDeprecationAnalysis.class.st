Class {
	#name : #DataOfDeprecationAnalysis,
	#superclass : #Object,
	#category : #'myBecher-XLS'
}

{ #category : #'data who are you' }
DataOfDeprecationAnalysis >> applicationDeveloperString [

	^'Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes

Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Uncertain
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Uncertain
Yes'
]

{ #category : #'data about configuration' }
DataOfDeprecationAnalysis >> classDeprecationString [

	^ 'N/A
Yes
Yes
No
Yes
Yes
Yes
Yes
Yes
No
Yes
Yes
N/A
No
No
N/A
No
Yes
No
No
N/A
Yes
Yes
N/A
No
Yes
Yes
Yes
N/A
Yes
No
N/A
Yes
Yes
No
No
Yes
Yes
No
Yes
Yes
N/A
Yes
N/A
N/A
Yes'
]

{ #category : #'data about configuration' }
DataOfDeprecationAnalysis >> configurationRaiseWarningString [

	^ 'N/A
No
Yes
Yes
Yes
Yes
Yes
Yes
No
Yes
Yes
No
N/A
Yes
Yes
N/A
Yes
Yes
Yes
Yes
N/A
Yes
Yes
N/A
Yes
No
Yes
Yes
N/A
No
No
N/A
No
Yes
No
No
Yes
No
No
No
Yes
N/A
Yes
N/A
N/A
Yes'
]

{ #category : #'data about configuration' }
DataOfDeprecationAnalysis >> configurationRewritingByDefaultString [

	^ 'N/A
Yes
No
No
No
Yes
Yes
Yes
Yes
No
No
Yes
N/A
No
Yes
N/A
Yes
Yes
No
Yes
N/A
No
No
N/A
No
No
Yes
No
N/A
Yes
No
N/A
Yes
Yes
Yes
No
Yes
Yes
Yes
Yes
Yes
N/A
Yes
N/A
N/A
Yes'
]

{ #category : #queries }
DataOfDeprecationAnalysis >> countingYesNoNA: columnName [
	"self new countingYesNoNA: #doYouKnowIn >>> #(43 0 3)"
	| q1 | 
	q1 := self treat: columnName.
	^ { (q1 select: [ :each | each = 'Yes' ]) size .
	  (q1 select: [ :each | each = 'No' ]) size . (q1 select: [ :each | each = 'N/A' ]) size }
		
]

{ #category : #queries }
DataOfDeprecationAnalysis >> countingYesNoUncertain: columnName [
	"self new countingYesNoUncertain: #applicationDeveloper >>> #(43 0 3)"
	| q1 | 
	q1 := self treat: columnName.
	^ { (q1 select: [ :each | each = 'Yes' ]) size .
	  (q1 select: [ :each | each = 'No' ]) size . (q1 select: [ :each | each = 'Uncertain' or: [each = '']  ]) size }
		
]

{ #category : #'data user' }
DataOfDeprecationAnalysis >> didHelpString [

	^ 'N/A
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
No
Yes
No
N/A
Yes
No
N/A
Yes
Yes
No
Yes
Yes
No
Yes
Yes
No
Yes
Yes
Yes
N/A
Yes
No
N/A
Yes
No
Yes
No
Yes
Yes
No
Yes
Yes
N/A
Yes
N/A
N/A
Yes'
]

{ #category : #'data as library dev' }
DataOfDeprecationAnalysis >> didYouWriteString [

	^ 'N/A
Yes
Yes
No
Yes
Yes
Yes
Yes
Yes
No
Yes
No
N/A
No
No
N/A
Yes
Yes
No
No
No
No
No
No
No
Yes
Yes
No
N/A
Yes
No
N/A
No
No
No
No
No
No
No
Yes
No
N/A
Yes
No
N/A
Yes'
]

{ #category : #'data user' }
DataOfDeprecationAnalysis >> doYouKnowInString [

	^ 'N/A
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
N/A
Yes
Yes
N/A
Yes
Yes
Yes
Yes
Yes
No
Yes
Yes
Yes
Yes
Yes
Yes
N/A
Yes
No
N/A
Yes
Yes
Yes
Yes
Yes
Yes
No
Yes
Yes
N/A
Yes
No
N/A
Yes'
]

{ #category : #'data user' }
DataOfDeprecationAnalysis >> doYouSeeValueInString [

	^ 'Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes'
]

{ #category : #'data who are you' }
DataOfDeprecationAnalysis >> frameworkDeveloperString [

	^'Yes
Yes
Yes
Uncertain
Yes
Yes
Yes
Yes
Yes
Yes
Yes
No
Yes
Uncertain
No
Yes
Uncertain
Yes
No
Yes
Yes
Uncertain
Yes
No
No
Yes
Yes
No
No
Yes
Yes
Uncertain
Yes
Yes
No
No
No
Uncertain
Yes
Uncertain
No
No
Uncertain
Yes
Uncertain
No'
]

{ #category : #'data user' }
DataOfDeprecationAnalysis >> frequencyString [

	^ 'Often
Very often
Often
Not often
Often
Often
Very often
Often
Very often
From time to time
Very often
Often
Very often
From time to time
Very often
Not often
Often
Often
Not often
From time to time
Often
From time to time
Often
Not often
From time to time
Very often
Often
Often
Often
From time to time
Often
From time to time
Often
Often
From time to time
Often
From time to time
From time to time
From time to time
Often
Very often
From time to time
Not often
Often
From time to time
Not often'
]

{ #category : #'data as library dev' }
DataOfDeprecationAnalysis >> howEasyString [

	^ '
Easy
Easy

Medium
Very easy
Very easy
Medium
Medium

Medium





Medium
Medium




Medium


Medium
Easy


Easy


Easy

Difficult




Easy


Easy


Medium'
]

{ #category : #'data who are you' }
DataOfDeprecationAnalysis >> libraryDeveloperString [

	^'Yes
Yes
Yes
Uncertain
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Uncertain
Yes

Yes
Yes
Yes
Yes
Yes
Uncertain
Uncertain
No
No
Yes
Yes
No
No
No
Yes
No
Yes
Yes
Yes
Yes
Uncertain
Yes
Yes
Yes
Yes
Yes
Yes
Yes
Uncertain
Yes'
]

{ #category : #queries }
DataOfDeprecationAnalysis >> question1Stats [
	"self new question1Stats"
	^ { #applicationDeveloper -> (self countingYesNoUncertain: #applicationDeveloper).
		#libraryDeveloper -> (self countingYesNoUncertain: #libraryDeveloper).
		#frameworkDeveloper -> (self countingYesNoUncertain: #frameworkDeveloper) }

]

{ #category : #queries }
DataOfDeprecationAnalysis >> question1StatsCrossed [
	"I want to know both App and library"
	"self new question1StatsCrossed"
	| res appdev libdev |
	res := 0.
	appdev := self treat: #applicationDeveloper.
	libdev := self treat: #libraryDeveloper.
	appdev with: libdev do: [ :app :lib | 
		(app = 'Yes') & (lib = 'Yes')
			ifTrue: [ res := res + 1 ]
		].
	^ res
	
]

{ #category : #queries }
DataOfDeprecationAnalysis >> question2Stats [
	"self new question2Stats"
	
	^ ( self treatString: self frequencyString) asBag asDictionary


]

{ #category : #queries }
DataOfDeprecationAnalysis >> question3HelpStats [
	"self new question3HelpStats"
	
	^  self countingYesNoNA: #didHelp
]

{ #category : #queries }
DataOfDeprecationAnalysis >> question3KnowStats [
	"self new question2Stats"
	
	^  self countingYesNoNA: #doYouKnowIn
]

{ #category : #queries }
DataOfDeprecationAnalysis >> question4EasyStats [
	"self new question4EasyStats"
	
	^ ( self treatString: self howEasyString ) asBag asDictionary
]

{ #category : #queries }
DataOfDeprecationAnalysis >> question4WriteStats [
	"self new question4WriteStats"
	
	^  self countingYesNoNA: #didYouWrite
]

{ #category : #queries }
DataOfDeprecationAnalysis >> question5DefaultConfigurationStats [
	"self new question5DefaultConfigurationStats"
	
	^  self countingYesNoNA: #configurationRewritingByDefault
]

{ #category : #queries }
DataOfDeprecationAnalysis >> question5RaisingWarningStats [
	"self new question5RaisingWarningStats #(24 12 10)"
	
	^  self countingYesNoNA: #configurationRaiseWarning
]

{ #category : #queries }
DataOfDeprecationAnalysis >> question6ClassStats [
	"self new question6ClassStats #(24 12 10)"
	
	^  self countingYesNoNA: #classDeprecation
]

{ #category : #cleaning }
DataOfDeprecationAnalysis >> treat: columnName [

	| str res| 
	res := OrderedCollection new. 
	str := (self perform: (columnName, 'String') asSymbol) readStream.
	[ str atEnd ] whileFalse: 
		[ res add: (str upTo: Character cr) ].
	^ res
	
]

{ #category : #prototype }
DataOfDeprecationAnalysis >> treatAppDeveloper [

	| str res| 
	res := OrderedCollection new. 
	str := self applicationDeveloperString readStream.
	[ str atEnd ] whileFalse: 
		[ res add: (str upTo: Character cr) ].
	^ res
	
]

{ #category : #cleaning }
DataOfDeprecationAnalysis >> treatString: aString [ 

	| str res| 
	res := OrderedCollection new. 
	str := aString readStream.
	[ str atEnd ] whileFalse: 
		[ res add: (str upTo: Character cr) ].
	^ res
	
]
