Class {
	#name : #CountingManualInterpreter,
	#superclass : #Object,
	#instVars : [
		'count'
	],
	#category : #'myBecher-MetaASTVisitor'
}

{ #category : #initialize }
CountingManualInterpreter >> initialize [ 
	super initialize.
	count := 0
]

{ #category : #accessing }
CountingManualInterpreter >> numberOfMessages [

	^ count
]

{ #category : #visiting }
CountingManualInterpreter >> visitArrayNode: aRBArrayNode [ 
	^ self
]

{ #category : #visiting }
CountingManualInterpreter >> visitAssignmentNode: aRBAssignmentNode [ 
	aRBAssignmentNode value acceptVisitor: self
	
]

{ #category : #visiting }
CountingManualInterpreter >> visitLiteralValueNode: aRBLiteralValueNode [ 
		^ self
]

{ #category : #visiting }
CountingManualInterpreter >> visitMessageNode: aRBMessageNode [ 
		count := count + 1.
		aRBMessageNode receiver acceptVisitor: self.
		aRBMessageNode arguments do: [ :each | each acceptVisitor: self ]
		
]

{ #category : #visiting }
CountingManualInterpreter >> visitMethodNode: aRBMethodNode [ 
	
	aRBMethodNode statements do: [ :each | each acceptVisitor: self ]
]

{ #category : #visiting }
CountingManualInterpreter >> visitReturnNode: aRBReturnNode [ 
	aRBReturnNode value acceptVisitor: self
]

{ #category : #visiting }
CountingManualInterpreter >> visitSelfNode: aRBMethodNode [ 
	
	^ self
]

{ #category : #visiting }
CountingManualInterpreter >> visitVariableNode: aRBVariableNode [ 
	^ self
]
