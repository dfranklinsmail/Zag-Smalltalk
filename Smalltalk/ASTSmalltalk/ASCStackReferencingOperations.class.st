"
I am the superclass of all the operations that referencce the top elements of the stack
"
Class {
	#name : 'ASCStackReferencingOperations',
	#superclass : 'ASCOperations',
	#instVars : [
		'stack'
	],
	#category : 'ASTSmalltalk-CodeGen',
	#package : 'ASTSmalltalk',
	#tag : 'CodeGen'
}

{ #category : 'data flow instructions' }
ASCStackReferencingOperations >> markReferences [

	^ self subclassResponsibility
]

{ #category : 'stack' }
ASCStackReferencingOperations >> resultStack: anASStack [

	^ self subclassResponsibility
]
