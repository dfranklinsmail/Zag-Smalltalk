"
Clean up stack and return nil
"
Class {
	#name : 'ASCReturnNil',
	#superclass : 'ASCNonStackReferencingOperations',
	#category : 'ASTSmalltalk-CodeGen',
	#package : 'ASTSmalltalk',
	#tag : 'CodeGen'
}

{ #category : 'accessing' }
ASCReturnNil >> next [

	^ nil
]

{ #category : 'code generation' }
ASCReturnNil >> outputTo: output [

	^ output visitReturnNil
]

{ #category : 'stack' }
ASCReturnNil >> resultStack: anASStack [

	^ (anASStack at: #self) drop pushClass: UndefinedClass
]

{ #category : 'instance creation' }
ASCReturnNil >> with: ignored [


]
