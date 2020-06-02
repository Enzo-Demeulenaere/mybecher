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
