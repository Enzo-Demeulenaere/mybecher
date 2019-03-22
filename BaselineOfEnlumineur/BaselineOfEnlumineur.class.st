Class {
	#name : #BaselineOfEnlumineur,
	#superclass : #BaselineOf,
	#category : #BaselineOfEnlumineur
}

{ #category : #baselines }
BaselineOfEnlumineur >> baseline: spec [
	<baseline>

	spec for: #pharo do: [
		spec package: 'BlueInk-Enlumineur' ]
]
