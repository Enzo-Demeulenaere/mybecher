Class {
	#name : #MyScripts,
	#superclass : #Object,
	#category : #'myBecher-Concurrent'
}

{ #category : #scripts }
MyScripts >> BenScript1 [

	| trace semaphore p1 p2 |
	semaphore := Semaphore new.
	trace := [ :message | ('@{1} {2}' format: { Processor activePriority. message }) crTrace ].
	p1 := [
	   trace value: 'Process 1a waits for signal on semaphore'. 
	   semaphore wait.
	   trace value: 'Process 1b received signal and terminates' ] forkAt: 20.
	p2 := [
	   trace value: 'Process 2a up to signalling semaphore'. 
	   semaphore signal.
	   trace value: 'Process 2b continues and terminates' ] forkAt: 30.
]

{ #category : #scripts }
MyScripts >> BenScript2 [

	| trace semaphore p1 p2 |
	semaphore := Semaphore new.
	trace := [ :message | ('@{1} {2}' format: { Processor activePriority. message }) crTrace ].
	p1 := [
	   trace value: 'Process 1a waits for signal on semaphore'. 
	   semaphore wait.
	   trace value: 'Process 1b received signal and terminates' ] forkAt: 30.
	p2 := [
	   trace value: 'Process 2a up to signalling semaphore'. 
	   semaphore signal.
	   trace value: 'Process 2b continues and terminates' ] forkAt: 20.
]

{ #category : #scripts }
MyScripts >> BenScript3 [

	| trace semaphore p1 p2 p3 |
	semaphore := Semaphore new.
	trace := [ :message | ('@{1} {2}' format: { Processor activePriority. message }) crTrace ].
	p1 := [
	   trace value: 'Process 1a waits for signal on semaphore'. 
	   semaphore wait.
	   trace value: 'Process 1b received signal and terminates' ] forkAt: 30.
	p2 := [
	   trace value: 'Process 2a up to signalling semaphore'. 
	   semaphore signal.
	   trace value: 'Process 2b continues and terminates' ] forkAt: 20.
   p3 := [
	   trace value: 'Process 3a works and terminates'. 
		] forkAt: 20.
]

{ #category : #scripts }
MyScripts >> BenScript4 [

	| trace semaphore p1 p2 |
	semaphore := Semaphore new.
	trace := [ :message | ('@{1} {2}' format: { Processor activePriority. message }) traceCr ].
	p1 := [
		trace value: 'Process 1a waits for signal on semaphore'. 
		semaphore wait.
		trace value: 'Process 1b received signal and terminates' ] forkAt: 30.
	p2 := [
		trace value: 'Process 2a signals semaphore'. 
		semaphore signal.
		trace value: 'Process 2b continues and terminates' ] forkAt: 20.
	trace value: 'Original process pre-yield'.
	Processor yield.
	trace value: 'Original process post-yield'. 
]

{ #category : #scripts }
MyScripts >> BenScript5 [

	| trace semaphore p1 p2 |
	semaphore := Semaphore new.
	trace := [ :message | ('@{1} {2}' format: { Processor activePriority. message }) traceCr ].
	p1 := [
		trace value: 'Process 1a waits for signal on semaphore'. 
		semaphore wait.
		trace value: 'Process 1b received signal and terminates' ] forkAt: 30.
	p2 := [
		trace value: 'Process 2a signals semaphore'. 
		semaphore signal.
		trace value: 'Process 2b continues and terminates' ] forkAt: 20.
	trace value: 'Original process pre-yield'.
	1 milliSecond wait.
	trace value: 'Original process post-yield'. 
]

{ #category : #scripts }
MyScripts >> PharoIsCoolScriptDifferentPriority [
	| semaphore p1 p2 p3 |
	semaphore := Semaphore new.
	p1 := [ 'Pharo ' trace ] forkAt: 35.
	p2 := [ ' is ' trace.
			semaphore wait.
			' super ' trace.
			semaphore signal ] forkAt: 38.
	p3 := [ ' really ' trace.
			semaphore signal.
			semaphore wait.
			' cool!' traceCr ] forkAt: 35
]

{ #category : #scripts }
MyScripts >> PharoIsCoolScriptSamePriority [
	| semaphore p1 p2 p3 |
	semaphore := Semaphore new.
	p1 := [ 'Pharo ' trace ] forkAt: 11.
	p2 := [ 'is ' trace.
			semaphore wait.
			' super ' trace.
			semaphore signal ] forkAt: 11.
	p3 := [ 'really ' trace.
			semaphore signal.
			semaphore wait.
			'cool!' traceCr ] forkAt: 11.
]

{ #category : #scripts }
MyScripts >> script1 [

	| lock counter |
	lock := Semaphore new.
	counter := 3000.
	[ 10 timesRepeat: [
		lock wait.
		counter := counter + 100.
		counter crTrace.
		lock signal ]
		] fork.
	
	[ 10 timesRepeat: [
		counter := counter - 100.
		counter crTrace. 
		lock signal. 
		lock wait ]
	] fork
]

{ #category : #scripts }
MyScripts >> script1WithMutex [

	| lock counter |
	lock := Mutex new.
	counter := 3000.
	[ 10 timesRepeat: [ Processor yield.
	lock critical: [ counter := counter + 100.
					counter crTrace ] ]
	] fork.

	[ 10 timesRepeat: [ Processor yield.
	lock critical: [ counter := counter - 100.
					counter crTrace ] ]
	] fork
]

{ #category : #scripts }
MyScripts >> script2NoYield [
	| trace |
	trace := [ :message | ('@{1} {2}' format: { Processor activePriority. message }) crTrace ].
	[1 to: 10 do: [:i| trace value: i ]] fork.
 	[1 to: 10 do: [:i| trace value: i ]] fork.

]

{ #category : #scripts }
MyScripts >> script2NoYield2 [
	| trace |
	trace := [ :message | ('@{1} {2}' format: { Processor activePriority. message }) crTrace ].
	[3 timesRepeat: [ trace value: 3 ]] forkAt: 12.
	[3 timesRepeat: [ trace value: 2 ]] forkAt: 13.
	[3 timesRepeat: [ trace value: 1 ]] forkAt: 14.


]

{ #category : #scripts }
MyScripts >> script2Yield2 [
	| trace |
	trace := [ :message | ('@{1} {2}' format: { Processor activePriority. message }) crTrace ].
	[3 timesRepeat: [ trace value: 3. Processor yield  ]] forkAt: 12.
	[3 timesRepeat: [ trace value: 2. Processor yield  ]] forkAt: 13.
	[3 timesRepeat: [ trace value: 1. Processor yield  ]] forkAt: 14.


]

{ #category : #scripts }
MyScripts >> script3 [
	[1 to: 10 do: [:i| i trace. ' ' trace. Processor yield ]] fork.
	[11 to: 20 do: [:i| i trace. ' ' trace. Processor yield ]] fork.
]

{ #category : #scripts }
MyScripts >> script4 [
	[ 1 to: 10 do: [ :i |
  i trace; trace: ' '.
  Processor yield ] ] fork.

[ 101 to: 110 do: [ :i |
  i trace; trace: ' '.
  Processor yield ] ] fork
]
