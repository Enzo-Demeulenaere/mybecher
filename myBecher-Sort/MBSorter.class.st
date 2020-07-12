Class {
	#name : #MBSorter,
	#superclass : #Object,
	#category : #'myBecher-Sort'
}

{ #category : #'as yet unclassified' }
MBSorter >> createHierarchyTreeOf: col [

	"Create a tree from a flat collection of classes"
	| transformed |
	transformed := col collect: [:ea | 
		| childs indexes |
		childs := col select: [:class | class isTrait not and: [class superclass = ea]].
		indexes := childs collect: [:child | col indexOf: child].
		ea -> indexes].
	transformed copy do: [:ea |
		ea value: (ea value collect: [:idx | 
			| val |
			val := transformed at: idx.
			transformed at: idx put: nil.
			val])].
	^ transformed select: [:ea | ea notNil].

]

{ #category : #'as yet unclassified' }
MBSorter >> flattenHierarchyTree: classHierarchy on: col indent: indent [
	^ self
		flattenHierarchyTree: classHierarchy
		on: col
		indent: indent
		by: '  '
]

{ #category : #'as yet unclassified' }
MBSorter >> flattenHierarchyTree: classHierarchy on: col indent: indent by: indentChars [
	"Recursively add to col the names in classHierarchy indenting to show the hierarchical relationship. Use indentChars to do the indenting: spaces, tabs, etc."
	| plusIndent |
	plusIndent := indentChars.
	classHierarchy do: [:assoc |
		| class childs |
		class := assoc key.
		col add: indent , class name.
		childs := assoc value.
		self
			flattenHierarchyTree: childs
			on: col
			indent: indent , plusIndent
			by: indentChars].
	^ col
]

{ #category : #'as yet unclassified' }
MBSorter >> hierarchicalClassList [
	"self new hierarchicalClassList"
	"classNames are an arbitrary collection of classNames of the system.
	Reorder those class names so that they are sorted and indended by inheritance"
	| classes |
		
	classes := RBProgramNode withAllSubclasses.
	^ self
		flattenHierarchyTree: (self createHierarchyTreeOf: classes)
		on: OrderedCollection new
		indent: ''.
]

{ #category : #'as yet unclassified' }
MBSorter >> printHierarchyOf: class [
	"Answer a description containing the names and instance variable names 
	of all of the subclasses and superclasses of the class."

	| aStream index |
	index := 0.
	aStream := WriteStream on: (String new: 16).
	class allSuperclasses reverseDo: 
		[:aClass | 
		aStream crtab: index.
		index := index + 1.
		aStream nextPutAll: aClass name.
		aStream space.
		aStream print: aClass instVarNames].
	aStream cr.
	class printSubclassesOn: aStream level: index.
	^aStream contents
]
