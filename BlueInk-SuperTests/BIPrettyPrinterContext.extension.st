Extension { #name : #BIPrettyPrinterContext }

{ #category : #'*BlueInk-SuperTests' }
BIPrettyPrinterContext >> storeOn: aStream [

	aStream 
		nextPutAll: self class name;
		nextPutAll: ' new' ; cr.
	self class instVarNames sorted
		do: [ :each | 
					aStream tab.
					aStream nextPutAll: each, ': '.
					aStream print: (self instVarNamed: each asSymbol) ]
		separatedBy: [ aStream nextPutAll: ';'; cr. ]
]
