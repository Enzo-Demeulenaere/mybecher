"
RecursionLock exists to protect shared resources via critical regions. 
The difference between the critical regions supplied by Semaphore and RecursionLock is what happens in the following case:

	lock critical: [lock critical: [Transcript cr; show: 'entered']]
	
If 'lock' is a Semaphore forMutualExclusion, the current process deadlocks.  
If 'lock' is a RecursionLock, the process can enter recursively into the lock and do not deadlock.

"
Class {
	#name : #MyRecursionLock,
	#superclass : #Object,
	#instVars : [
		'semaphore',
		'owner'
	],
	#category : #'myBecher-Concurrent-recursionLock'
}

{ #category : #initialization }
MyRecursionLock >> critical: aBlock [ 
	"Evaluate aBlock only if the resource represented by the receiver is not already in use by another process. If it is, wait on the receiver's semaphore until the resource is available. If the resource is already in use by the current process, execution proceeds. Answer the result of executing 
	the block."

	| activeProcess |
	activeProcess := Processor activeProcess.
	^activeProcess == owner
		ifTrue: [aBlock value]
		ifFalse: [semaphore
				critical: 
					[owner := activeProcess.
					aBlock ensure: [owner := nil]]]
]

{ #category : #initialization }
MyRecursionLock >> initialize [

	super initialize.
	semaphore := Semaphore forMutualExclusion
]
