Class {
	#name : #ClassHierarchyPrinterTest,
	#superclass : #TestCase,
	#instVars : [
		'printer'
	],
	#category : #'myBecher-Sort-ForPharo'
}

{ #category : #tests }
ClassHierarchyPrinterTest >> setUp [ 
	super setUp.
	printer := ClassHierarchyPrinter new.
]

{ #category : #tests }
ClassHierarchyPrinterTest >> testPrintHierarchyOfPoint [

	printer forClass: Point. 
	self assert: printer print equals: '
ProtoObject #()
	Object #()

		Point #(#x #y)'
]

{ #category : #tests }
ClassHierarchyPrinterTest >> testPrintHierarchyOfPointNoSuperclasses [

	printer 
		forClass: Point;
		doNotShowSuperclasses.
	self assert: printer print equals: '
Point #(#x #y)'
]

{ #category : #tests }
ClassHierarchyPrinterTest >> testPrintHierarchyOfRectangle [

	printer forClass: Rectangle. 
	self assert: printer print equals: '
ProtoObject #()
	Object #()

		Rectangle #(#origin #corner)
			CharacterBlock #(#stringIndex #text #textLine)'
]

{ #category : #tests }
ClassHierarchyPrinterTest >> testPrintHierarchyOfRectangleNoSuperclasses [

	printer 
		forClass: Rectangle; 
		doNotShowSuperclasses.
	self assert: printer print equals: '
Rectangle #(#origin #corner)
	CharacterBlock #(#stringIndex #text #textLine)'
]

{ #category : #tests }
ClassHierarchyPrinterTest >> testPrintHierarchyOfRectangleWithFilteredClasses [

	printer forClass: Rectangle. 
	printer limitedToClasses: { Rectangle }.
	self assert: printer print equals: '
ProtoObject #()
	Object #()

		Rectangle #(#origin #corner)'
]
