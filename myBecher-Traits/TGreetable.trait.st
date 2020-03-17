Trait {
	#name : #TGreetable,
	#category : #'myBecher-Traits'
}

{ #category : #running }
TGreetable >> greeting [

	^ 'Hello ', self name
]
