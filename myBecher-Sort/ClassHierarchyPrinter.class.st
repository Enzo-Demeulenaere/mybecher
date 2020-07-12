Class {
	#name : #ClassHierarchyPrinter,
	#superclass : #Object,
	#instVars : [
		'theClass',
		'filteredClasses'
	],
	#category : #'myBecher-Sort-ForPharo'
}

{ #category : #accessing }
ClassHierarchyPrinter >> filteredClasses: aCollection [

	filteredClasses := aCollection
]

{ #category : #accessing }
ClassHierarchyPrinter >> forClass: aClass [ 
	theClass := aClass
]

{ #category : #printing }
ClassHierarchyPrinter >> initialize [ 	
	super initialize.
	filteredClasses  := #()
]

{ #category : #printing }
ClassHierarchyPrinter >> print [
	"Answer a description containing the names and instance variable names 
	of all of the subclasses and superclasses of the class."

	| index |
	index := 0.
	^ String streamContents: [ :aStream | 
		theClass allSuperclasses reverseDo: 
			[ :aClass | 
				aStream crtab: index.
				index := index + 1.
				aStream nextPutAll: aClass name.
				aStream space.
				aStream print: aClass instVarNames ].
		aStream cr.
		self printSubclassesOf: theClass on: aStream level: index.
	 ]
]

{ #category : #printing }
ClassHierarchyPrinter >> printSubclassesOf: aClass on: aStream level: level [
	"As part of the algorithm for printing a description of the receiver, print the
	subclass on the file stream, aStream, indenting level times."
	
	| sortedSubclasses |
	aStream crtab: level.
	aStream nextPutAll: aClass name.
	aStream space; print: aClass instVarNames.
	aClass == Class
		ifTrue: 
			[ aStream crtab: level + 1; nextPutAll: '[ ... all the Metaclasses ... ]'.
			^ self ].
	sortedSubclasses := aClass subclasses asSortedCollection: [ :c1 :c2 | c1 name <= c2 name ].
	"Print subclasses in alphabetical order"
	sortedSubclasses do:
		[ :subclass | self printSubclassesOf: subclass on: aStream level: level + 1 ]
]
