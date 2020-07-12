Class {
	#name : #ClassHierarchyPrinter,
	#superclass : #Object,
	#instVars : [
		'theClass',
		'excludedClasses',
		'limitedToClasses',
		'stream'
	],
	#category : #'myBecher-Sort-ForPharo'
}

{ #category : #accessing }
ClassHierarchyPrinter >> excludedClasses: aCollection [

	excludedClasses := aCollection
]

{ #category : #accessing }
ClassHierarchyPrinter >> filteredClasses: aCollection [

	filteredClasses := aCollection
]

{ #category : #accessing }
ClassHierarchyPrinter >> forClass: aClass [ 
	theClass := aClass
]

{ #category : #initialization }
ClassHierarchyPrinter >> initialize [ 	
	super initialize.
	excludedClasses := #().
	limitedToClasses := #().
	stream := (String new: 100) writeStream
]

{ #category : #accessing }
ClassHierarchyPrinter >> limitedToClasses: aCollection [

	limitedToClasses := aCollection
]

{ #category : #accessing }
ClassHierarchyPrinter >> on: aStream [

	stream := aStream
]

{ #category : #printing }
ClassHierarchyPrinter >> print [
	"Answer a description containing the names and instance variable names 
	of all of the subclasses and superclasses of the class."

	| index |
	index := 0.
	theClass allSuperclasses
		reverseDo: [ :aClass | 
			self printClass: aClass level: index.
			index := index + 1 ].
	stream cr.
	self printSubclassesOf: theClass level: index.
	^ stream contents
]

{ #category : #printing }
ClassHierarchyPrinter >> printClass: aClass level: index [
	stream crtab: index.
	stream nextPutAll: aClass name.
	stream
		space;
		print: aClass instVarNames
]

{ #category : #printing }
ClassHierarchyPrinter >> printSubclassesOf: aClass level: level [
	"As part of the algorithm for printing a description of the receiver, print the
	subclass on the file stream, aStream, indenting level times."

	| sortedSubclasses |
	self printClass: aClass level: level.
	aClass == Class
		ifTrue: [ stream
				crtab: level + 1;
				nextPutAll: '[ ... all the Metaclasses ... ]'.
			^ self ].
	sortedSubclasses := aClass subclasses
		asSortedCollection: [ :c1 :c2 | c1 name <= c2 name ].
	sortedSubclasses
		do: [ :subclass | self printSubclassesOf: subclass level: level + 1 ]
]
