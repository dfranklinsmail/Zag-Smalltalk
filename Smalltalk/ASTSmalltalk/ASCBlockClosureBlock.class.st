"
I am the first block in a method.

All the other blocks that are created are ASCBasicBlock or ASCReturnBlock
"
Class {
	#name : 'ASCBlockClosureBlock',
	#superclass : 'ASCReturnBlock',
	#instVars : [
		'primitive',
		'returnBlocks',
		'selector'
	],
	#category : 'ASTSmalltalk-CodeGen',
	#package : 'ASTSmalltalk',
	#tag : 'CodeGen'
}

{ #category : 'adding' }
ASCBlockClosureBlock >> addBlock: anASCReturnBlock [

	self halt.
	^ returnBlocks
		  at: anASCReturnBlock
		  ifAbsentPut: [ returnBlocks size + 1 ]
]

{ #category : 'accessing' }
ASCBlockClosureBlock >> context [

	^ context
]

{ #category : 'data flow instructions' }
ASCBlockClosureBlock >> flowForLocals [

	^ ASFlowNil
]

{ #category : 'data flow instructions' }
ASCBlockClosureBlock >> flowForTemporaries [

	^ self shouldNotImplement
]

{ #category : 'testing' }
ASCBlockClosureBlock >> hasContextOnEntry [

	^ sourceElements hasContext
]

{ #category : 'API' }
ASCBlockClosureBlock >> initContext [

	context := ASContext forBasicBlock: self
]

{ #category : 'API' }
ASCBlockClosureBlock >> initParameterNamed: aSymbol [

	| source |
	stack := stack initParameterNamed: aSymbol.
	source := ASFlowParameter new.
	^ stack data: source
]

{ #category : 'API' }
ASCBlockClosureBlock >> initSelf: targetClass [

	| source |
	stack := stack initSelf.
	source := ASFlowParameter new class: targetClass.
	^ stack data: source
]

{ #category : 'initialization' }
ASCBlockClosureBlock >> initialize [

	super initialize.
	returnBlocks := Dictionary new.
	method := self
]

{ #category : 'initialization' }
ASCBlockClosureBlock >> labelExtra: s [

]

{ #category : 'accessing' }
ASCBlockClosureBlock >> locals: locals parameters: arguments [

	arguments do: [ :each | self initParameterNamed: each ].
	locals do: [ :each | self initLocalNamed: each ].
	sourceElements := stack.
	maxDepth := 0
]

{ #category : 'writing' }
ASCBlockClosureBlock >> outputTo: output [

	output
		outputMethodDefinition: self label
		primitive: primitive
		methods: { self } , returnBlocks keys.
	output outputMethodStart: self.
	^ self outputRestTo: output
]

{ #category : 'accessing' }
ASCBlockClosureBlock >> primitive: anInteger [

	primitive := anInteger.

]

{ #category : 'printing' }
ASCBlockClosureBlock >> printOn: aStream [

	aStream nextPutAll: '>>'; nextPutAll: self label
]

{ #category : 'accessing' }
ASCBlockClosureBlock >> selector [

	^ selector
]

{ #category : 'accessing' }
ASCBlockClosureBlock >> selector: aString [

	selector := aString.
	label := aString
]

{ #category : 'accessing' }
ASCBlockClosureBlock >> stackDepth [

	^ sourceElements offset
]

{ #category : 'data flow instructions' }
ASCBlockClosureBlock >> updateDataDependencies: ignored [
	" a MethodBlock has no dependencies "

]
