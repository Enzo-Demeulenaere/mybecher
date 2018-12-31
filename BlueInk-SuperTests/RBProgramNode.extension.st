Extension { #name : #RBProgramNode }

{ #category : #'*BlueInk-SuperTests' }
RBProgramNode >> hasComments [
	"Answer whether the receiver as comments"
	
	^ self comments isNotEmpty
	
]
