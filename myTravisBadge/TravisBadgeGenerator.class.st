Class {
	#name : #TravisBadgeGenerator,
	#superclass : #Object,
	#category : #myTravisBadge
}

{ #category : #'instance creation' }
TravisBadgeGenerator >> for: aString [

	^ String streamContents: [:s |
			s nextPutAll: '#### '; nextPutAll: aString;
				nextPutAll: '
[https://github.com/SquareBracketAssociates/', aString, '](https://github.com/SquareBracketAssociates/', aString;
nextPutAll: ')

[![Build status](https://travis-ci.org/SquareBracketAssociates/', aString,'.svg?branch=master)](https://travis-ci.org/github/SquareBracketAssociates/', aString,')' ]
]
