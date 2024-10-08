"
I am an inline block, but I'm used to inline a Method

Returns from me are stack adjustment and branch to the return point
"
Class {
	#name : 'ASCMethodBlock',
	#superclass : 'ASCCompilableUnitBlock',
	#instVars : [
		'theMethod',
		'primitive',
		'selector'
	],
	#category : 'ASTSmalltalk-CodeGen',
	#package : 'ASTSmalltalk',
	#tag : 'CodeGen'
}

{ #category : 'adding' }
ASCMethodBlock >> copyStackFrom: aBasicBlock [

	stack := aBasicBlock stack.
	self nameStack: theMethod arguments.
	^ stack
]

{ #category : 'as yet unclassified' }
ASCMethodBlock >> label [

	^ label ifNil: [
		  label := String streamContents: [ :s |
			           s
				           nextPutAll: super label;
				           nextPut: $_;
				           print: theMethod ] ]
]

{ #category : 'accessing' }
ASCMethodBlock >> primitive: anInteger [

	primitive := anInteger.

]

{ #category : 'accessing' }
ASCMethodBlock >> selector [

	^ selector
]

{ #category : 'as yet unclassified' }
ASCMethodBlock >> theMethod: aMethodAST [

	theMethod := aMethodAST
]
