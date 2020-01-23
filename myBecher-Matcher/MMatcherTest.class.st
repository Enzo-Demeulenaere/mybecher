Class {
	#name : #MMatcherTest,
	#superclass : #TestCase,
	#category : #'myBecher-Matcher'
}

{ #category : #accessing }
MMatcherTest >> level [
   | level current |
   level := 0.
   current := self resolve.
   [ current isRoot ] whileFalse: [
		level := level + 1.
	current := current parent ].
^ level
]

{ #category : #accessing }
MMatcherTest >> testNoVariable [
	| searcher |
	searcher := RBParseTreeSearcher new.
	searcher
		matches: 'current isRoot'
		do: [ :aNode :answer | answer add: aNode ; yourself].
	searcher executeTree: (MMatcherTest >> #level) ast initialAnswer: OrderedCollection new.
	self assert: searcher answer first class equals: RBMessageNode.
	self assert: searcher answer first printString equals: 'RBMessageNode(current isRoot)'
]
