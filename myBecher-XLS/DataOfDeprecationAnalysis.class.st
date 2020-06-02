Class {
	#name : #DataOfDeprecationAnalysis,
	#superclass : #Object,
	#category : #'myBecher-XLS'
}

{ #category : #'data question1 ' }
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

{ #category : #queries }
DataOfDeprecationAnalysis >> countingYesNoUncertain: columnName [
	"self new countingYesNoUncertain: #applicationDeveloper >>> #(43 0 3)"
	| q1 | 
	q1 := self treat: columnName.
	^ { (q1 select: [ :each | each = 'Yes' ]) size .
	  (q1 select: [ :each | each = 'No' ]) size . (q1 select: [ :each | each = 'Uncertain' or: [each = '']  ]) size }
		
]

{ #category : #'data question2' }
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

{ #category : #'data question2' }
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

{ #category : #'data question2' }
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

{ #category : #'data question2' }
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

{ #category : #'data question1 ' }
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

{ #category : #'data question2' }
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

{ #category : #'data question1 ' }
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
DataOfDeprecationAnalysis >> question2Stats [
	"self new question2Stats"
	
	^ ( self treatString: self frequencyString) asBag asDictionary


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
