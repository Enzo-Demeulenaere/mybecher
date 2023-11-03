Class {
	#name : #FlattenIntoTest,
	#superclass : #TestCase,
	#category : #'myBecher-mooc'
}

{ #category : #tests }
FlattenIntoTest >> testBasic [ 

	self assert: #((1 2) (3) 4) flatten equals: #(1 2 3 4).
	self assert: #(((1 2) 5) (3) 4) flatten equals: #(1 2 5 3 4).
	self assert: #((1 nil 2) nil (3) 4) flatten equals: #(1 2 3 4).
]

{ #category : #tests }
FlattenIntoTest >> testBasicEliminatingNil [

	self assert: #((1 nil 2) nil (3) 4) flatten equals: #(1 2 3 4).
	self assert: #(((1 nil 2)) nil (3) 4) flatten equals: #(1 2 3 4).
	self assert: #(nil) flatten equals: #()

]
