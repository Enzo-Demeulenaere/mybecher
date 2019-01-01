Extension { #name : #BIPrettyPrinterContext }

{ #category : #'*BlueInk-SuperTests' }
BIPrettyPrinterContext >> newEmptyLineAfterMethodCommentZone [

	self newLinesAfterMethodComment: 2
	"
	We do two line return: one for the empty line and one for the method body start.
	After the comments (even empty) we let one empty line
	"
]

{ #category : #'*BlueInk-SuperTests' }
BIPrettyPrinterContext >> noNewEmptyLineAfterMethodCommentZone [

	self newLinesAfterMethodComment: 1
	"After the comments (even empty) we don't let one empty line.
	We just issue one new line for the method body"
]

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
