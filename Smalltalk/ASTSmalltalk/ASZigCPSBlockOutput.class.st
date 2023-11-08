"
I output BlockClosures
"
Class {
	#name : #ASZigCPSBlockOutput,
	#superclass : #ASZigCPSOutput,
	#instVars : [
		'methodGenerator',
		'block'
	],
	#category : #'ASTSmalltalk-CodeGen'
}

{ #category : #accessing }
ASZigCPSBlockOutput >> block [
	^ methodGenerator 	block
]

{ #category : #compiling }
ASZigCPSBlockOutput >> methodGenerator [

	^ methodGenerator
]

{ #category : #accessing }
ASZigCPSBlockOutput >> methodGenerator: anOutput block: anInteger [

	methodGenerator := anOutput.
	block := anInteger
]

{ #category : #accessing }
ASZigCPSBlockOutput >> prefix [

	^ 'B'
]

{ #category : #visiting }
ASZigCPSBlockOutput >> visitReturnSelf [
	self nextPutAll: 'RETURNSELF';endStatement 
]