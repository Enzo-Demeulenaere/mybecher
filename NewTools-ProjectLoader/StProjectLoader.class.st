"
```
StProjectLoader new openWithSpec
```
"
Class {
	#name : #StProjectLoader,
	#superclass : #StPresenter,
	#instVars : [
		'loadedProjects',
		'loadableProjects',
		'menuBarPresenter',
		'projectListPresenter'
	],
	#category : #'NewTools-ProjectLoader'
}

{ #category : #specs }
StProjectLoader class >> defaultSpec [ 

	^ SpBoxLayout newVertical 
			add: #projectListPresenter;
			add: #menuBarPresenter withConstraints: [ :constraints | constraints height: self toolbarHeight ];
			yourself
]

{ #category : #specs }
StProjectLoader class >> toolbarHeight [

	^ 30
]

{ #category : #actions }
StProjectLoader >> boo [

	^ self inform: 'Boo is executed'
]

{ #category : #initialization }
StProjectLoader >> initialize [
	loadedProjects := OrderedCollection new.
	loadableProjects := { Project named: 'Microdown' . Project named: 'Roassal3.0' }.
	super initialize.
	
]

{ #category : #initialization }
StProjectLoader >> initializePresenters [ 

	projectListPresenter := self newTable.
	projectListPresenter addColumn:
			((SpCheckBoxTableColumn title: ' ' evaluated: [ :class | self loadedProjects includes: class ])
				onActivation: [ :class | self loadedProjects add: class ];
				onDeactivation: [ :class | self loadedProjects remove: class ];
				width: 20;
				yourself).
				
   projectListPresenter addColumn: (SpCompositeTableColumn new
			title: 'Name';
			addColumn: (SpImageTableColumn evaluated: [ :each | 
				self iconNamed: #glamorousFolder ]);
			addColumn: (SpStringTableColumn evaluated: [ :each | each name])).
	projectListPresenter items: loadableProjects.

	menuBarPresenter := self newButtonBar.
	menuBarPresenter add: (SpButtonPresenter new label: 'Cancel'; action: [ self delete ]; yourself).
	menuBarPresenter add: (SpButtonPresenter new label: 'Ok'; action: [ self boo ]; yourself)
	
	
]

{ #category : #initialization }
StProjectLoader >> initializeWindow: aWindowPresenter [
	aWindowPresenter title: 'Optional project loader'
]

{ #category : #accessing }
StProjectLoader >> loadableProjects [

	^ loadableProjects
]

{ #category : #accessing }
StProjectLoader >> loadableProjects: aColl [

	loadableProjects := aColl
]

{ #category : #accessing }
StProjectLoader >> loadedProjects [

	^ loadedProjects
]
