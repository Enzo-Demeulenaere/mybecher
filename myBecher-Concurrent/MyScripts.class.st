Class {
	#name : #MyScripts,
	#superclass : #Object,
	#category : #'myBecher-Concurrent'
}

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
MyScripts >> script2 [

	[1 to: 10 do: [:i| i trace. ' 'trace ]] fork.
  [11 to: 20 do: [:i| i trace. ' 'trace ]] fork.

]

{ #category : #scripts }
MyScripts >> script3 [
	[1 to: 10 do: [:i| i trace. ' ' trace. Processor yield ]] fork.
	[11 to: 20 do: [:i| i trace. ' ' trace. Processor yield ]] fork.
]
