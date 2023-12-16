Class {
	#name : 'MatcherTest',
	#superclass : 'TestCase',
	#category : 'myBecher-DS-Fun',
	#package : 'myBecher-DS',
	#tag : 'Fun'
}

{ #category : 'as yet unclassified' }
MatcherTest >> testGoodMatches [

	| matcher |
	matcher := DSMatcher new.
	self assert: (matcher matches: '(( 1 ( 1 )))').
]

{ #category : 'as yet unclassified' }
MatcherTest >> testGoodMatchesSequences [

	| matcher |
	matcher := DSMatcher new.
	self assert: (matcher matches: '(( 1 (9) ( 1 )) (9))')
]

{ #category : 'as yet unclassified' }
MatcherTest >> testWrongMatches [

	| matcher |
	matcher := DSMatcher new.
	self deny: (matcher matches:  ')').
	self deny: (matcher matches: '((( 1 ( 1 )))')
]
