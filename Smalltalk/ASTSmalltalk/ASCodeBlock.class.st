"
I represent a block of code.

"
Class {
	#name : 'ASCodeBlock',
	#superclass : 'Object',
	#instVars : [
		'body',
		'locals'
	],
	#category : 'ASTSmalltalk-AST',
	#package : 'ASTSmalltalk',
	#tag : 'AST'
}

{ #category : 'tests - instance creation' }
ASCodeBlock class >> locals: locals body: body [

	^ self new
		  locals: locals;
		  body: body
]

{ #category : 'comparing' }
ASCodeBlock >> = other [

	^ self class = other class and: [ 
		locals = other locals and: [ body = other body ] ]
]

{ #category : 'accessing' }
ASCodeBlock >> addStatement: anASStatement [

	body add: anASStatement
]

{ #category : 'accessing' }
ASCodeBlock >> body [
	^ body
]

{ #category : 'accessing' }
ASCodeBlock >> body: aCollection [

	body := aCollection asASSequence
]

{ #category : 'accessing' }
ASCodeBlock >> children [

	^ OrderedCollection newFrom: body
]

{ #category : 'initialization' }
ASCodeBlock >> initialize [

	super initialize.
	locals := #(  ).
	body := ASSequence new
]

{ #category : 'testing' }
ASCodeBlock >> isASRef [
	^false
]

{ #category : 'testing' }
ASCodeBlock >> isASVariable [
	^ false
]

{ #category : 'accessing' }
ASCodeBlock >> locals [

	^ locals
]

{ #category : 'accessing' }
ASCodeBlock >> locals: aCollection [

	locals := aCollection asArray
]

{ #category : 'printing' }
ASCodeBlock >> printOn: s [

	locals isEmpty ifFalse: [
		s << ' locals: #('.
		locals do: [ :local | s << local ] separatedBy: [ s << ' ' ].
		s << ')' ].
	s << ' body: {'.
	body printOn: s.
	s << '}'
]

{ #category : 'accessing' }
ASCodeBlock >> roots [
	| roots |
	roots := OrderedCollection new.
	roots add: self.
	^ roots
]
