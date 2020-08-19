Class {
	#name : #Xtractor,
	#superclass : #Object,
	#instVars : [
		'textArea',
		'editingMode'
	],
	#category : #'myBecher-Xtractor'
}

{ #category : #api }
Xtractor >> bestNodeInString: source 
	at: selectionInterval 
	editingMode: aRubEditingMode 
	shouldFavourExpressions: isFavouringExpressions 
	onError: aBlock [
	"Find the best node in the source text in the identified selection area"
	
	| ast node start stop |
	source ifEmpty: aBlock.
	start := selectionInterval first min: source size.
	stop := selectionInterval last min: source size.
	
	ast := aRubEditingMode parseSource: source.
	
	ast ifNotNil: [ 
		"If there is no text selection"
		(selectionInterval isEmpty and: [ isFavouringExpressions and: [ 
			(source at: (stop + 1 min: source size)) isAlphaNumeric not ]]) ifTrue: [ 
				"If there is white space or statement terminator, try to backup to find a better node"		
				[stop > 0 and: [('.;' includes: (source at: stop)) or: [(source at: stop) isSeparator ]]]
					whileTrue: [ start := stop := stop - 1 ].
				start := stop].
		
		node := ast bestNodeFor: (start to: stop).
		
		node ifNil: [ 
			node := RBParseErrorNodeVisitor
				visit: ast 
				detect: [ :n | n intersectsInterval: (start to: start)]
				ifNone: [ ^aBlock value ]].
		
		node isFaulty ifTrue: [ 
			node allChildren size = 1 ifTrue: [ 
				(aRubEditingMode parseExpression: (node value padLeftTo: source size)) 
					ifNil: [ ^node ] 
					ifNotNil: [ :newNode |
						ast replaceNode: node withNode: newNode.
						node := newNode ].
				].
			
			node := RBGenericNodeVisitor 
				visit: node 
				detect: [ :n | n intersectsInterval: (start to: start) ] 
				ifNone: [ node ] ] ].
	

	^node

]

{ #category : #api }
Xtractor >> bestNodeInTextAreaOnError: aBlock [
	"Find the best node in the editor text area at the current pointer location"

	| start stop source |
	start := self textArea startIndex.
	stop := self textArea stopIndex.

	source := self textArea string.

	^ self
		bestNodeInString: source
		at: (start to: stop)
		editingMode: self editingMode
		shouldFavourExpressions: true
		onError: aBlock
]

{ #category : #configuring }
Xtractor >> code [

	editingMode := RubSmalltalkCodeMode new
]

{ #category : #accessing }
Xtractor >> editingMode [
	^ editingMode
]

{ #category : #accessing }
Xtractor >> editingMode: anObject [
	editingMode := anObject
]

{ #category : #api }
Xtractor >> findSelectorFromAST [
	"Try to make a selector out of the current text selection"

	| node fallbackBlock |
	fallbackBlock := [ ^ nil ].
	node := self bestNodeInTextAreaOnError: fallbackBlock.
	
	node isMethod ifFalse: [ 
		(node isValue and: [ node value isSymbol ]) ifTrue: [ ^node value ].
				
		[ node isMessage ] whileFalse: [ 
	 		(node := node parent) ifNil: fallbackBlock ]].
	
	^node selector
]

{ #category : #initialization }
Xtractor >> initialize [

	super initialize. 
	self code
]

{ #category : #configuring }
Xtractor >> scripting [

	editingMode := RubSmalltalkScriptingMode new
]

{ #category : #api }
Xtractor >> selectedSelector [
	"Try to make a selector out of the current text selection"

	^ self selectedSelectorWithRecursionDepth: 0
]

{ #category : #api }
Xtractor >> selectedSelectorWithRecursionDepth: depth [

	| node selectorFromAst |
	
	depth > 1 ifTrue: [ ^ nil ].
	
	self hasSelection ifFalse: [ 
		selectorFromAst := self findSelectorFromAST.
		^ selectorFromAst 
			ifNotNil: [ 
				selectorFromAst ]
			ifNil: [ 
				self selectWord.
				^ self selectedSelectorWithRecursionDepth: depth + 1 ] ].
	
	"why not using editingMode because it hides away the specific parser expression."
	node := RBParser parseFaultyExpression: self selection string.
	node
		nodesDo: [ :n | 
			n isMessage
				ifTrue: [ ^ n selector ].
			n isVariable
				ifTrue: [ ^ n name ].
			n isLiteralNode
				ifTrue: [ ^ n value ] ].
	"fall back"
	^ self selection string asSymbol
]

{ #category : #accessing }
Xtractor >> textArea [
	^ textArea
]

{ #category : #accessing }
Xtractor >> textArea: anObject [
	textArea := anObject
]
