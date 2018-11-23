Class {
	#name : #OntoMessageSeparator,
	#superclass : #Object,
	#category : #'OntoPharo-Extractors'
}

{ #category : #operations }
OntoMessageSeparator >> splitPrefix: aWord [

	"this method separate prefix from a given String with camelCase notation"

	| prefix index collection |
	
	collection := OrderedCollection new.
	collection := self upperCasePositions: aWord.
	
	index := collection at: 1 asInteger.
	prefix := (aWord copyFrom: 1 to: index-1).
	
	^prefix
	
	
]

{ #category : #operations }
OntoMessageSeparator >> splitSuffix: aWord [

	"this method separate suffix from a given String with camelCase notation"

	| suffix index collection size |
	
	collection := OrderedCollection new.
	collection := self upperCasePositions: aWord.
	size := collection size.
	index := collection at: size.
	
	suffix := (aWord copyFrom: index to: (aWord size)).
	
	^suffix
	
	
]

{ #category : #operations }
OntoMessageSeparator >> upperCasePositions: aWord [ 

	"this method ment to get UpperCase leterrs indexes in a String"
	
	| collection char size |	
	
	"collection = '([A-Z][A-Za-z]*)' asRegex matchesIn: aWord."

	collection := OrderedCollection new.
	size := aWord size. 
	
	1 to: size  do: 
	[:k|
		char := aWord at: k.
		(char isUppercase) 
		ifTrue: [ 
			collection  add: k ].	 
	].

	^collection .
]
