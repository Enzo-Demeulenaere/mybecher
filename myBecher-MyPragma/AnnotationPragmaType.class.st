Class {
	#name : #AnnotationPragmaType,
	#superclass : #Object,
	#instVars : [
		'method',
		'arguments',
		'selector'
	],
	#classInstVars : [
		'methods'
	],
	#category : #'myBecher-MyPragma-Core'
}

{ #category : #finding }
AnnotationPragmaType class >> allNamed: aSymbol from: aSubClass to: aSuperClass [
	"Answer a collection of all pragmas found in methods of all classes between aSubClass and aSuperClass (inclusive) whose selector is aSymbol."

	^ Array
		streamContents: [ :stream | 
			aSubClass
				withAllSuperclassesDo: [ :class | 
					self
						withPragmasIn: class
						do: [ :pragma | 
							pragma selector = aSymbol
								ifTrue: [ stream nextPut: pragma ] ].
					aSuperClass = class
						ifTrue: [ ^ stream contents ] ] ]
]

{ #category : #finding }
AnnotationPragmaType class >> allNamed: aSymbol from: aSubClass to: aSuperClass sortedByArgument: anInteger [
	"Answer a collection of all pragmas found in methods of all classes between aSubClass and aSuperClass (inclusive) whose keyword is aSymbol, sorted according to argument anInteger."

	^ self allNamed: aSymbol from: aSubClass to: aSuperClass sortedUsing: [ :a :b | (a argumentAt: anInteger) < (b argumentAt: anInteger) ].
]

{ #category : #finding }
AnnotationPragmaType class >> allNamed: aSymbol from: aSubClass to: aSuperClass sortedUsing: aSortBlock [
	"Answer a collection of all pragmas found in methods of all classes between aSubClass and aSuperClass (inclusive) whose keyword is aSymbol, sorted according to aSortBlock."
	
	^ (self allNamed: aSymbol from: aSubClass to: aSuperClass) sort: aSortBlock.
]

{ #category : #finding }
AnnotationPragmaType class >> allNamed: aSymbol in: aClass [
	"Answer a collection of all pragmas found in methods of aClass whose selector is aSymbol."
	
	^ Array streamContents: [ :stream |
		self withPragmasIn: aClass do: [ :pragma |
			pragma selector = aSymbol
				ifTrue: [ stream nextPut: pragma ] ] ].
]

{ #category : #finding }
AnnotationPragmaType class >> allNamed: aSymbol in: aClass sortedByArgument: anInteger [
	"Answer a collection of all pragmas found in methods of aClass whose keyword is aSymbol, sorted according to argument anInteger."

	^ self allNamed: aSymbol in: aClass sortedUsing: [ :a :b | (a argumentAt: anInteger) < (b argumentAt: anInteger) ].
]

{ #category : #finding }
AnnotationPragmaType class >> allNamed: aSymbol in: aClass sortedUsing: aSortBlock [
	"Answer a collection of all pragmas found in methods of aClass whose keyword is aSymbol, sorted according to aSortBlock."
	
	^ (self allNamed: aSymbol in: aClass) sort: aSortBlock.
]

{ #category : #'pragma management' }
AnnotationPragmaType class >> annotatedMethods [

	^ methods 
]

{ #category : #declaration }
AnnotationPragmaType class >> declaredSelector [

	^ self subclassResponsibility
]

{ #category : #'pragma management' }
AnnotationPragmaType class >> doItChunkImported: anAnnouncement [
	self halt.
		
]

{ #category : #'instance creation' }
AnnotationPragmaType class >> for: aMethod selector: aSelector arguments: anArray [
	"Create a pragma in the method @aMethod, pragma whose selector is @aSelector and arguments are @anArray"
	^self new
		method: aMethod;
		selector: aSelector;
		arguments: anArray;
		yourself
]

{ #category : #'pragma management' }
AnnotationPragmaType class >> initialize [
	
	methods := OrderedCollection new.
]

{ #category : #'pragma management' }
AnnotationPragmaType class >> methodAdded: anAnnouncement [ 
	anAnnouncement methodAdded pragmas 
		ifEmpty: [ ^ self ]
		ifNotEmpty: [ :pragma | 
			self halt.
			self registerPragma: pragma 
			 ]  
]

{ #category : #'pragma management' }
AnnotationPragmaType class >> methodModified: anAnnouncement [ 
	self halt. 
		
]

{ #category : #'pragma management' }
AnnotationPragmaType class >> methodRemoved: anAnnouncement [
	
]

{ #category : #private }
AnnotationPragmaType class >> selector: aSymbol arguments: anArray [
	^ self new
		selector: aSymbol;
		arguments: anArray;
		yourself
]

{ #category : #'pragma management' }
AnnotationPragmaType class >> setupEventRegistration [
	"self setupEventRegistration"
	
	SystemAnnouncer uniqueInstance private weak
		when: MethodAdded send: #methodAdded: to: self;
		when: MethodModified send: #methodModified: to: self;
		when: MethodRemoved send: #methodRemoved: to: self;
		when: DoItChunkImported send: #doItChunkImported: to: self.
		
]

{ #category : #private }
AnnotationPragmaType class >> withPragmasIn: aClass do: aBlock [
	aClass selectorsAndMethodsDo: [ :selector :method | method pragmas do: aBlock ].
]

{ #category : #comparing }
AnnotationPragmaType >> = aPragma [

	self == aPragma ifTrue: [^true].
	self species == aPragma species ifFalse: [^false].

	self method = aPragma method ifFalse: [^false].
	self method selector = aPragma method selector ifFalse: [ ^false ].
	self selector = aPragma selector ifFalse: [^false].
	self arguments = aPragma arguments ifFalse: [^false].

	^true.
]

{ #category : #comparing }
AnnotationPragmaType >> analogousCodeTo: anObject [ 
	^self class == anObject class
	  and: [self selector == anObject selector
	  and: [arguments = anObject arguments]]
]

{ #category : #'accessing-pragma' }
AnnotationPragmaType >> argumentAt: anInteger [
	"Answer one of the arguments of the pragma."
	
	^ self arguments at: anInteger.
]

{ #category : #'accessing-pragma' }
AnnotationPragmaType >> argumentNamed: aSymbol [
	"Answer the argument of the pragma after the keyword given as parameter.
	If none, raise an error."

	^ self argumentNamed: aSymbol ifNone: [ self error: 'No argument of this name.' ]
]

{ #category : #'accessing-pragma' }
AnnotationPragmaType >> argumentNamed: aSymbol ifNone: aBlockClosure [
	"Answer the argument of the pragma after the keyword given as parameter.
	If none, return the result of the block given as parameter.
	
	I am more readable than #argumentAt: but also slower."

	^ self argumentAt:
		(self selector keywords
			indexOf: aSymbol asMutator
			ifAbsent: [ ^ aBlockClosure value])
]

{ #category : #'accessing-pragma' }
AnnotationPragmaType >> arguments [
	"Answer the arguments of the receiving pragma. For a pragma defined as <key1: val1 key2: val2> this will answer #(val1 val2)."
	
	^ arguments
]

{ #category : #initialization }
AnnotationPragmaType >> arguments: anArray [
	arguments := anArray
]

{ #category : #testing }
AnnotationPragmaType >> hasLiteral: aLiteral [
	^self selector == aLiteral 
	   or: [arguments hasLiteral: aLiteral]
]

{ #category : #testing }
AnnotationPragmaType >> hasLiteralSuchThat: aBlock [
	"Answer true if litBlock returns true for any literal in the receiver, even if embedded in further array structure.
	 This method is only intended for private use by CompiledMethod hasLiteralSuchThat:"
	^(aBlock value: self selector)
	   or: [arguments hasLiteralSuchThat: aBlock]
]

{ #category : #comparing }
AnnotationPragmaType >> hash [

	| hash |

	hash := self method hash bitXor: self selector hash.
	1 to: self basicSize do: [:index | hash := hash bitXor: (self basicAt: index) hash].

	^hash.
]

{ #category : #querying }
AnnotationPragmaType >> key [
	"Answer the keyword of the pragma (the selector of its message pattern).
	 This accessor provides polymorphism with Associations used for properties."
	^self selector
]

{ #category : #accessing }
AnnotationPragmaType >> message [
	"Answer the message of the receiving pragma."
	
	^ Message selector: self selector arguments: self arguments. 
]

{ #category : #'accessing-method' }
AnnotationPragmaType >> method [
	"Answer the compiled-method containing the pragma."
	
	^ method
]

{ #category : #initialization }
AnnotationPragmaType >> method: aCompiledMethod [
	method := aCompiledMethod
]

{ #category : #'accessing-method' }
AnnotationPragmaType >> methodClass [
	"Answer the class of the method containing the pragma."
	
	^ method methodClass
]

{ #category : #view }
AnnotationPragmaType >> methodSelector [
	"Answer the selector of the method containing the pragma.
	 Do not confuse this with the selector of the pragma's message pattern."
	
	^method selector
]

{ #category : #'accessing-pragma' }
AnnotationPragmaType >> numArgs [
	"Answer the number of arguments in the pragma."

	^ self arguments size.
]

{ #category : #printing }
AnnotationPragmaType >> printOn: aStream [
	aStream nextPut: $<.
	self selector precedence = 1
		ifTrue: [ aStream nextPutAll: self selector ]
		ifFalse: [
			self selector keywords with: self arguments do: [ :key :arg |
				aStream nextPutAll: key; space; print: arg; space ].
			aStream skip: -1 ].
	aStream nextPut: $>.
]

{ #category : #testing }
AnnotationPragmaType >> refersToLiteral: aLiteral [
	^self selector == aLiteral 
	   or: [arguments hasLiteral: aLiteral]
]

{ #category : #accessing }
AnnotationPragmaType >> selector [
	"Answer the selector of the pragma.
	 For a pragma defined as <key1: val1 key2: val2> this will answer #key1:key2:."
	
	^ selector
]

{ #category : #initialization }
AnnotationPragmaType >> selector: aSymbol [
	selector := aSymbol
]

{ #category : #sending }
AnnotationPragmaType >> sendTo: anObject [
	"Send the pragma keyword together with its arguments to anObject and answer the result."
	
	^ anObject perform: self selector withArguments: self arguments
]

{ #category : #processing }
AnnotationPragmaType >> withArgumentsDo: aBlock [
	"Pass the arguments of the receiving pragma into aBlock and answer the result."
	
	^ aBlock valueWithArguments: self arguments
]
