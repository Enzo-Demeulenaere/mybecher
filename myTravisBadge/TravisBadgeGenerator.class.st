"
```
TravisBadgeGenerator new for: 'Booklet-AMiniSchemeInPharo' 
```

```
TravisBadgeGenerator new listFor: #('Booklet-ConcurrentProgramming' 'Booklet-Smacc' 'Booklet-AMiniSchemeInPharo') 
```
"
Class {
	#name : #TravisBadgeGenerator,
	#superclass : #Object,
	#category : #myTravisBadge
}

{ #category : #'as yet unclassified' }
TravisBadgeGenerator class >> generateReadme [

	^ self new listFor: 
			#(
			'Booklet-AMiniSchemeInPharo'
			'Booklet-APharoThingsTutorial'
			'Booklet-BuildingMemoryGameWithBloc'
			'Booklet-CallStackManagement'
			'Booklet-ClassCommandLine'
			'Booklet-Commander' 
			'Booklet-DataFrame'
			'Booklet-ConcurrentProgramming' 
			'Booklet-FunWithInterpreters'
			'Booklet-Glorp'
			'Booklet-LLVMCompilationWithPharo'
			'Booklet-ManagingCode'
			'Booklet-Magritte'
			'Booklet-Mocking'
			'Booklet-OPAL'
			'Booklet-PetitParser'
			'Booklet-PharoChosenPieces'
			'Booklet-PharoVirtualMachine'
			'Booklet-PharoWithStyle'
			'Booklet-Smacc' 
			'Booklet-Scraping'
		 	'Booklet-STON'
			'Booklet-Rewriter'
			'Booklet-AReflectiveKernel'
			'Booklet-TestingInPharo'
			'Booklet-Voyage'
			'Booklet-ZincHTTP'
			'BuildingApplicationWithSpec2'
			'PatternsOfDesign'
			'PharoByExample80'
			'TinyBlog-EN'
			'TinyBlog-Tutorial'
				) 

]

{ #category : #'instance creation' }
TravisBadgeGenerator >> for: aString [

	^ String streamContents: [:s | s for: aString on: s ]
]

{ #category : #'instance creation' }
TravisBadgeGenerator >> for: aString on: s [

		s nextPutAll: '#### '; nextPutAll: aString.
		s cr.
		s nextPutAll: '[![Build status](https://travis-ci.com/SquareBracketAssociates/', aString,'.svg?branch=master)](https://travis-ci.com/github/SquareBracketAssociates/', aString,')'.
		s 
			nextPutAll: ' [';
			nextPutAll: aString ;
			nextPutAll: '](https://github.com/SquareBracketAssociates/' ;
			nextPutAll: aString; 
			nextPutAll: ')' 
		
]

{ #category : #'instance creation' }
TravisBadgeGenerator >> listFor: aCollection [ 

	^ String streamContents: [ :s |
		aCollection 
			do: [ :each | self for: each on: s ]
			separatedBy: [ s cr; cr ]
		
		]
]
