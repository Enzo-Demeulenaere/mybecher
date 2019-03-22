Extension { #name : #RBProgramNode }

{ #category : #'*BlueInk-Enlumineur' }
RBProgramNode >> hasComments [
	"Answer whether the receiver as comments"
	
	^ self comments isNotEmpty
	
]
