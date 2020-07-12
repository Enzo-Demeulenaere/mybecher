Class {
	#name : #MBSortTest,
	#superclass : #TestCase,
	#instVars : [
		'sorter'
	],
	#category : #'myBecher-Sort'
}

{ #category : #tests }
MBSortTest >> setUp [ 
	super setUp.
	sorter := MBSorter new.
]

{ #category : #tests }
MBSortTest >> sort: aCollection [ 

	^ (sorter
		flattenHierarchyTree: (sorter createHierarchyTreeOf: aCollection)
		on: OrderedCollection new
		indent: '') asArray
		
	
]

{ #category : #tests }
MBSortTest >> testCreateHierarchyTreeOf [
	"Empty."
	self assert: (sorter createHierarchyTreeOf: #()) isEmpty.
	"Single class."
	self assert: { Model -> #() } = (sorter createHierarchyTreeOf: { Model }).
	"Single class + 1 subclass"
	self assert: { Model->{CustomHelp->#()} } = (sorter createHierarchyTreeOf: { Model. CustomHelp. }).
	"Single class + 2 subclasses"
	self assert:  {Model->{CustomHelp->{AnnouncementsHelp->#()}}} = (sorter createHierarchyTreeOf: { Model. CustomHelp. AnnouncementsHelp }).
	"Superclass, class, subclass"
	self assert: { Model->{CustomHelp->{AnnouncementsHelp->#()}} } = (sorter createHierarchyTreeOf: { Model. CustomHelp. AnnouncementsHelp}).
	"Two 'unrelated' classes"
	self assert: {Model->#() . SmallInteger->#()} = (sorter createHierarchyTreeOf: { Model. SmallInteger }).
	"Two 'unrelated' classes and a common ancestor"
	self assert: {Model->#() . SmallInteger->#() . ProtoObject->#()} = (sorter createHierarchyTreeOf: { Model. SmallInteger. ProtoObject }).
]

{ #category : #tests }
MBSortTest >> testEmpty [
	
	self assert: (self sort: #()) isEmpty.

]

{ #category : #tests }
MBSortTest >> testFlattenHierarchyTreeOnIndent [
	| flatten |
	flatten := [:coll | (sorter
		flattenHierarchyTree: (sorter createHierarchyTreeOf: coll)
		on: OrderedCollection new
		indent: '') asArray ].
	"Empty collection."
	self assert: (flatten value: #()) isEmpty.
	"Single class."
	self assert: #('Model') equals: (flatten value: {Model}).
	"Single class + subclass."
	self assert: #('Browser' '  HierarchyBrowser') equals: (flatten value: {Model. Model}).
	"Single class + 2 subclasses"
	self assert: #('Model' '  HierarchyModel' '  FileContentsModel') equals: (flatten value: { Model. Model. Model. }).
	"Superclass, class, subclass"
	self assert: #('CodeHolder' '  Model' '    HierarchyModel') equals: (flatten value: { Model. Model. Model. }).
	"Two 'unrelated' classes"
	self assert: #('Model' 'SmallInteger') equals: (flatten value: { Model. SmallInteger }).
	"Two 'unrelated' classes and a common ancestor"
	self assert: #('Model' 'SmallInteger' 'ProtoObject') equals: (flatten value: { Model. SmallInteger. ProtoObject }).
]

{ #category : #tests }
MBSortTest >> testSingleValue [
	
	self assert: (self sort: { Model }) equals: #('Model')
]

{ #category : #tests }
MBSortTest >> testSubclasses [


	| sorting | 
	sorting := MalTopologicalSorting new. 
	sorting
		addNodesFrom: RBProgramNode childrenBlock: [ :class | class subclasses ].
	sorting run collect: [:each | each model].
]
