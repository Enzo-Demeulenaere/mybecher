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
		'menuBar'
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
StProjectLoader >> initializePresenters [ 

	projectList := self newTreeTable.


	menuBar := self newButtonBar.
	menuBar add: (SpButtonPresenter new label: 'Cancel'; action: [ self close ]; yourself).
	menuBar add: (SpButtonPresenter new label: 'Ok'; action: [ self boo ]; yourself)
	
	
]
