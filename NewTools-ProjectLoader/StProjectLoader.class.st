"
```
StProjectLoader new openWithSpec
```
"
Class {
	#name : #StProjectLoader,
	#superclass : #StPresenter,
	#instVars : [
		'projectList',
		'menuBar',
		'loadedProjects',
		'loadableProjects'
	],
	#category : #'NewTools-ProjectLoader'
}

{ #category : #specs }
StProjectLoader class >> defaultSpec [ 

	^ SpBoxLayout newVertical 
			add: #projectList;
			add: #menuBar withConstraints: [ :constraints | constraints height: self toolbarHeight ];
			yourself
]

{ #category : #specs }
StProjectLoader class >> toolbarHeight [

	^ 30
]

{ #category : #initialization }
StProjectLoader >> boo [

	^ self inform: 'Boo is executed'
]

{ #category : #initialization }
StProjectLoader >> initialize [

	super initialize.
	loadableProjects := { Project named: 'Microdown' . Project named: 'Roassal3.0' }
]

{ #category : #initialization }
StProjectLoader >> initializePresenters [ 

	projectList := self newTreeTable.
	projectList addColumn:
			((SpCheckBoxTableColumn title: ' ' evaluated: [ :class | self loadedProjects includes: class ])
				onActivation: [ :class | self loadedProjects add: class ];
				onDeactivation: [ :class | self loadedProjects remove: class ];
				width: 20;
				yourself).
				
   projectList addColumn: (SpCompositeTableColumn new
			title: 'Name';
			addColumn: (SpImageTableColumn evaluated: [ :each | 
				self iconNamed: #glamorousFolder ]);
			addColumn: (SpStringTableColumn evaluated: [ :each | each name])).

	menuBar := self newButtonBar.
	menuBar add: (SpButtonPresenter new label: 'Cancel'; action: [ self close ]; yourself).
	menuBar add: (SpButtonPresenter new label: 'Ok'; action: [ self boo ]; yourself)
	
	
]

{ #category : #initialization }
StProjectLoader >> loadableProjects [

	^ loadableProjects
]

{ #category : #initialization }
StProjectLoader >> loadedProjects [

	^ loadedProjects
]
