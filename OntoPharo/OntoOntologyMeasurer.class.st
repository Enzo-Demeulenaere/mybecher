"
An Ontology Based class for String measures 
"
Class {
	#name : #OntoOntologyMeasurer,
	#superclass : #Object,
	#category : #'OntoPharo-Ontology'
}

{ #category : #operations }
OntoOntologyMeasurer >> hammingDistanceOf: aWord with: anotherWord [
	
	| distance lenmax |
		
	"length of the more long string"
	lenmax := ({ aWord contents size . anotherWord contents size } asSortedCollection: [ :a :b | a > b ]) first.
	
	"calcul of the distance"
	distance := 0.
	1 to: lenmax do: [ :pos | ((aWord contents at: pos) ~=  (anotherWord contents at: pos)) ifTrue: [ distance := distance + 1 ] ].
	^distance
]

{ #category : #operations }
OntoOntologyMeasurer >> levenshteinDistanceOf: aWord with: anotherWord [

	"this method is based on levenshtein Distance (LD) "
	| stab cost |
	
	"if a string is empty, answer the length of the another string"
 	(aWord contents size = 0) ifTrue: [ ^anotherWord contents size ].
	(anotherWord contents size = 0) ifTrue: [ ^aWord contents size ].
	
	stab := Matrix rows: (anotherWord contents size + 1) columns: (aWord contents size + 1).
	1 to: stab columnCount  do: [ :i | stab at: 1 at: i put: (i - 1) ].
	1 to: stab rowCount  do: [ :i | stab at: i at: 1 put: (i - 1) ].
	
	2 to: stab columnCount do: [ :i |
		2 to: stab rowCount do: [ :j |
				((aWord contents at: i - 1) = (anotherWord contents at: j - 1)) ifTrue: [ cost := 0 ] ifFalse: [ cost := 1].
				stab at: j at: i put: ({ (stab at: j at: (i - 1)) + 1 . (stab at: (j - 1) at: i) + 1 . ((stab at: (j - 1) at: (i - 1)) + cost) } asSortedCollection: [ :a :b | a < b ]) first. ] ].
	^stab at: stab rowCount at: stab columnCount
]
