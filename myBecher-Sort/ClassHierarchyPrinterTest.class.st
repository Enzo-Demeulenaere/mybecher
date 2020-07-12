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
ClassHierarchyPrinterTest >> testPrintHierarchyOfPointWithFilteredClasses [

	printer forClass: Point. 
	printer filteredClasses: { ProtoObject }.
	self assert: printer print equals: '
ProtoObject #()
	Object #()

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
