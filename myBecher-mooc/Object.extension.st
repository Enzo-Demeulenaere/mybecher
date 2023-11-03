Extension { #name : #Object }

{ #category : #'*myBecher-mooc' }
Object >> flatten [
	^ (OrderedCollection streamContents: [ :stream | self flattenInto: stream ]) asArray
]

{ #category : #'*myBecher-mooc' }
Object >> flatten: anObject [
	^ (OrderedCollection streamContents: [ :stream | anObject flattenInto: stream ]) asArray
]

{ #category : #'*myBecher-mooc' }
Object >> flattenInto: anObject [
	anObject nextPut: self
]
