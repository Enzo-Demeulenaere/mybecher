Class {
	#name : #ClassHierarchyPrinter,
	#superclass : #Object,
	#instVars : [
		'theClass'
	],
	#category : #'myBecher-Sort-ForPharo'
}

{ #category : #accessing }
ClassHierarchyPrinter >> forClass: aClass [ 
	theClass := aClass
]

{ #category : #printing }
ClassHierarchyPrinter >> print [
	^ self printHierarchy
]

{ #category : #'as yet unclassified' }
ClassHierarchyPrinter >> printHierarchy [
	"Answer a description containing the names and instance variable names 
	of all of the subclasses and superclasses of the class."

	| aStream index |
	index := 0.
	aStream := WriteStream on: (String new: 16).
	theClass allSuperclasses reverseDo: 
		[:aClass | 
		aStream crtab: index.
		index := index + 1.
		aStream nextPutAll: aClass name.
		aStream space.
		aStream print: aClass instVarNames].
	aStream cr.
	self printSubclassesOn: aStream level: index.
	^aStream contents
]

{ #category : #'as yet unclassified' }
ClassHierarchyPrinter >> printSubclassesOn: aStream level: level [ 

	self printSubclassesOn: aStream level: level filter: nil
]

{ #category : #'as yet unclassified' }
ClassHierarchyPrinter >> printSubclassesOn: aStream level: level filter: filterCollection [
	"As part of the algorithm for printing a description of the receiver, print the
	subclass on the file stream, aStream, indenting level times. 
	An optional filterCollection restricts printing to contained classes only."
	
	| subclassNames |
	filterCollection ifNotNil: [ (filterCollection includes: theClass) ifFalse: [ ^theClass ]].
	aStream crtab: level.
	aStream nextPutAll: theClass name.
	aStream space; print: theClass instVarNames.
	theClass == Class
		ifTrue: 
			[aStream crtab: level + 1; nextPutAll: '[ ... all the Metaclasses ... ]'.
			^self].
	subclassNames := theClass subclasses asSortedCollection:[:c1 :c2| c1 name <= c2 name].
	"Print subclasses in alphabetical order"
	subclassNames do:
		[:subclass | subclass printSubclassesOn: aStream level: level + 1 filter: filterCollection]
]
