Extension { #name : #RBMethodNode }

{ #category : #'*BlueInk-Enlumineur' }
RBMethodNode >> argumentSize [
	"Return the cumulted length of the parameters (yes parameters are called arguments in Pharo - not good!). It does not count spaces and the selectors"
	
	^ self arguments sum: [ :each | each name size ]
]

{ #category : #'*BlueInk-Enlumineur' }
RBMethodNode >> selectorSize [
	"Return the length of the selector. It does not take into length of parameters"
	
	^ selector size
]

{ #category : #'*BlueInk-Enlumineur' }
RBMethodNode >> signatureSize [
	"Return the full length of the method signature (called with a strange name in Pharo: the patterned selector."
	
	^ self selectorSize + self argumentSize
]
