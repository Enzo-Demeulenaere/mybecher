Extension { #name : #Collection }

{ #category : #'*myBecher-mooc' }
Collection >> flattenInto: result [
	self do: [ :item | item flattenInto: result ]
]
