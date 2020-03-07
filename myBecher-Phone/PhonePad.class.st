Class {
	#name : #PhonePad,
	#superclass : #Object,
	#category : #'myBecher-Phone'
}

{ #category : #decode }
PhonePad >> decode: aCharacter and: anInteger [ 
	
	^ (aCharacter codePoint + anInteger - 1) asCharacter
]
