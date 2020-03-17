"
| b |
b := Bird new.
b fly

>>> 'I''m flying!'
"
Class {
	#name : #Bird,
	#superclass : #Object,
	#traits : 'TFlyingAbility',
	#classTraits : 'TFlyingAbility classTrait',
	#category : #'myBecher-Traits'
}
