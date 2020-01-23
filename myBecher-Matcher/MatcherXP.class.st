Class {
	#name : #MatcherXP,
	#superclass : #Object,
	#category : #'myBecher-Matcher'
}

{ #category : #accessing }
MatcherXP >> test1 [ 
	| searcher |
	searcher := RBParseTreeSearcher new.
	searcher
		matches: 'current isRoot'
		do: [ :aNode :answer | answer add: aNode ; yourself].
	searcher executeTree: (MatcherXP >> #level) ast initialAnswer: Set new.
	searcher answer.
]
