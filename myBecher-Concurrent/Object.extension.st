Extension { #name : #Object }

{ #category : #'*myBecher-Concurrent' }
Object >> crTracePriority [
	self crTrace: '[', Processor activePriority printString, ']', self printString
]
