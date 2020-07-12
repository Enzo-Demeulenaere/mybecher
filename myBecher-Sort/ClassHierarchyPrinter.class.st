Class {
	#name : #ClassHierarchyPrinter,
	#superclass : #Object,
	#instVars : [
		'theClass',
		'excludedClasses',
		'limitedToClasses',
		'stream',
		'level',
		'index',
		'showSuperclasses',
		'showState'
	],
	#category : #'myBecher-Sort-ForPharo'
}

{ #category : #accessing }
ClassHierarchyPrinter >> doNotShowState [

	showState := false
]

{ #category : #accessing }
ClassHierarchyPrinter >> doNotShowSuperclasses [

	showSuperclasses := false
]

{ #category : #accessing }
ClassHierarchyPrinter >> excludedClasses: aCollection [
	"To set the classes that we do not want to see printed."
	excludedClasses := aCollection
]

{ #category : #'public API' }
ClassHierarchyPrinter >> forClass: aClass [ 
	theClass := aClass
]

{ #category : #initialization }
ClassHierarchyPrinter >> initialize [ 	
	super initialize.
	excludedClasses := #().
	limitedToClasses := #().
	index := 0.
	showSuperclasses := true.
	showState := true.
	stream := (String new: 100) writeStream
]

{ #category : #accessing }
ClassHierarchyPrinter >> limitedToClasses: aCollection [
	"To set the only classes that should be printed."
	
	limitedToClasses := aCollection
]

{ #category : #accessing }
ClassHierarchyPrinter >> on: aStream [

	stream := aStream
]

{ #category : #'public API' }
ClassHierarchyPrinter >> print [
	"Answer a description containing the names and instance variable names 
	of all of the subclasses and superclasses of the class."
	
	showSuperclasses 
		ifTrue: [ self printSuperclasses ].
	self printSubclassesOf: theClass.
	^ stream contents
]

{ #category : #printing }
ClassHierarchyPrinter >> printClass: aClass [
	"Print a single line in the printout."
	stream crtab: index.
	stream nextPutAll: aClass name.
	showState ifTrue: [ stream space; print: aClass instVarNames ]
]

{ #category : #printing }
ClassHierarchyPrinter >> printSubclassesOf: aClass [
	"As part of the algorithm for printing a description of the receiver, print the
	subclass on the file stream, aStream, indenting level times."

	| sortedSubclasses |
	limitedToClasses ifNotEmpty: [ 
			(limitedToClasses includes: aClass) 
				ifFalse: [ ^ self ]
			].
	(excludedClasses includes: aClass)
		ifTrue: [ ^ self ].
		
	self printClass: aClass.
	aClass == Class
		ifTrue: [ stream
				crtab: level + 1;
				nextPutAll: '[ ... all the Metaclasses ... ]'.
			^ self ].
	sortedSubclasses := aClass subclasses
		asSortedCollection: [ :c1 :c2 | c1 name <= c2 name ].
	sortedSubclasses do: [ :subclass | 
			index := index + 1.
			self printSubclassesOf: subclass ]
]

{ #category : #printing }
ClassHierarchyPrinter >> printSuperclasses [

	theClass allSuperclasses
		reverseDo: [ :aClass | 
			self printClass: aClass.
			index := index + 1 ].
	stream cr.	"to spot the requested class."
]

{ #category : #accessing }
ClassHierarchyPrinter >> showSuperclasses [

	showSuperclasses := true
]
