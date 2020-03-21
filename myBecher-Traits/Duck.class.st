Class {
	#name : #Duck,
	#superclass : #Object,
	#traits : 'TFlyingAbility + TSpeakingAbility',
	#classTraits : 'TFlyingAbility classTrait + TSpeakingAbility classTrait',
	#category : #'myBecher-Traits'
}

{ #category : #operations }
Duck >> quack [

	^ 'QUACK'
]

{ #category : #operations }
Duck >> speak [

	^ self quack
]
