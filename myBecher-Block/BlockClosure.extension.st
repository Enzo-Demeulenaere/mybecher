Extension { #name : #BlockClosure }

{ #category : #'*myBecher-Block' }
BlockClosure >> valuePassingEscapingBlock [
	  self value: [ ^ nil ]
]
