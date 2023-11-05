Class {
	#name : #DSMatcher,
	#superclass : #Object,
	#instVars : [
		's'
	],
	#category : #'myBecher-DS-Fun'
}

{ #category : #initialization }
DSMatcher >> initialize [ 
	super initialize.
	s := DSStack new.
]

{ #category : #initialization }
DSMatcher >> matches: aCollection [

	| opening closing |
	opening := #( $( ).
	closing := #( $) ).
	aCollection do: [ :aChar |
		(opening includes: aChar) 
			ifTrue: [  s push: aChar ]
			ifFalse:  [ (closing includes: aChar)
							 ifTrue: [ 
								s isEmpty ifTrue: [ ^ false ].
							 "here we can have couple () {} .... [] but we do not manage it for now"
								s top = $( ifFalse: [ ^ false ]. 
							s pop
							 ] ] ].
	^ s isEmpty
]
