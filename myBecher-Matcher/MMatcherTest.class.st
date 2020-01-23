Class {
	#name : #MMatcherTest,
	#superclass : #TestCase,
	#instVars : [
		'searcher',
		'level'
	],
	#category : #'myBecher-Matcher'
}

{ #category : #accessing }
MMatcherTest >> level [
	| current |
	level := 0.
	current := self resolve.
	[ current isRoot ] whileFalse: [
		level := level + 1.
	current := current parent ].
	^ level
]

{ #category : #accessing }
MMatcherTest >> search [

	searcher executeTree: (MMatcherTest >> #level) ast initialAnswer: OrderedCollection new.
]

{ #category : #accessing }
MMatcherTest >> setUp [
	super setUp.
	searcher := RBParseTreeSearcher new.
]

{ #category : #accessing }
MMatcherTest >> testNoVariable [

	searcher
		matches: 'current isRoot'
		do: [ :aNode :answer | answer add: aNode ; yourself].
	self search.
	self assert: searcher answer first class equals: RBMessageNode.
	self assert: searcher answer first printString equals: 'RBMessageNode(current isRoot)'
]

{ #category : #accessing }
MMatcherTest >> testNoVariableLevelMultipleMatches [

	searcher
		matches: 'level'
		do: [ :aNode :answer | answer add: aNode ; yourself].
	self search.
	self assert: searcher answer size equals: 4 
]

{ #category : #accessing }
MMatcherTest >> testNoVariableMultipleMatches [

	searcher
		matches: 'current'
		do: [ :aNode :answer | answer add: aNode ; yourself].
	self search.
	self assert: searcher answer size equals: 4.
	self assert: (searcher answer collect: [ :each | each start ]) asArray equals: #(34 62 116 127)
]

{ #category : #accessing }
MMatcherTest >> testSelectorVariableMultipleMatches [

	searcher
		matches: 'current `selector'
		do: [ :aNode :answer | answer add: aNode ; yourself].
	self search.
	self assert: searcher answer size equals: 2.
	self assert: searcher answer printString equals: 'an OrderedCollection(RBMessageNode(current isRoot) RBMessageNode(current parent))'
]
