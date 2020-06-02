Class {
	#name : #DataOfDeprecationAnalysis,
	#superclass : #Object,
	#category : #'myBecher-XLS'
}

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
DataOfDeprecationAnalysis >> question1Stats [
	"self new question1Stats"
	| q1 | 
	q1 := self treatAppDeveloper.
	^ { (q1 select: [ :each | each = 'Yes' ]) size .
	  (q1 select: [ :each | each = 'No' ]) size . (q1 select: [ :each | each = 'Uncertain' or: [each = '']  ]) size }
		
]

{ #category : #'as yet unclassified' }
DataOfDeprecationAnalysis >> treatAppDeveloper [

	| str res| 
	res := OrderedCollection new. 
	str := self applicationDeveloperString readStream.
	[ str atEnd ] whileFalse: 
		[ res add: (str upTo: Character cr) ].
	^ res
	
]
