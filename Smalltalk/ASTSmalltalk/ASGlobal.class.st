"
I represent a global (most likely a class)
"
Class {
	#name : #ASGlobal,
	#superclass : #ASVariable,
	#category : #'ASTSmalltalk-AST'
}

{ #category : #compiling }
ASGlobal >> tell: aCompiler youAreSent: aSymbol [

	aCompiler sent: aSymbol toGlobal: name
]