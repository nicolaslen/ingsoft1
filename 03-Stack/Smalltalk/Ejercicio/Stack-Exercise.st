!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:31'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/8/2012 08:20'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:33'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'First'.
	secondPushedObject := 'Second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:35'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:36'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:36'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'firstElement size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'JL 9/18/2017 15:10:54'!
initialize
	firstElement := OOStackNullElement new.
	size := 0.
	^self.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'JL 9/18/2017 17:36:03'!
isEmpty
	
	^ firstElement isEmpty.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'JL 9/18/2017 17:37:37'!
pop
	| element |
	
	element := self topElement.
	firstElement := element next.
	size := size - 1.
	^element value.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'JL 9/18/2017 17:41:12'!
push: anElement
	|element|
	
	element := OOStackNotNullElement init: anElement withNext: self topElement.
	firstElement := element.
	size := size + 1.
	^self.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'JL 9/18/2017 17:10:39'!
size
	
	^size.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'JL 9/18/2017 17:35:46'!
top
	
	^firstElement value.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'JL 9/18/2017 17:37:08'!
topElement
	
	^firstElement.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'JL 9/18/2017 14:28:06'!
new
	
	^super new initialize! !

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #OOStackElement category: #'Stack-Exercise'!
Object subclass: #OOStackElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackElement methodsFor: 'as yet unclassified' stamp: 'JL 9/18/2017 15:11:39'!
isEmpty
	
	^self subclassResponsibility.! !

!OOStackElement methodsFor: 'as yet unclassified' stamp: 'JL 9/18/2017 17:46:09'!
next
	 ^self subclassResponsibility.! !

!OOStackElement methodsFor: 'as yet unclassified' stamp: 'JL 9/18/2017 16:19:57'!
value
	 ^self subclassResponsibility.! !


!classDefinition: #OOStackNotNullElement category: #'Stack-Exercise'!
OOStackElement subclass: #OOStackNotNullElement
	instanceVariableNames: 'value nextStackElement'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackNotNullElement methodsFor: 'as yet unclassified' stamp: 'JL 9/18/2017 16:49:14'!
init: anElement withNextElement: stackElement

	value := anElement.
	nextStackElement := stackElement.! !

!OOStackNotNullElement methodsFor: 'as yet unclassified' stamp: 'JL 9/18/2017 15:43:30'!
isEmpty
	
	^false.! !

!OOStackNotNullElement methodsFor: 'as yet unclassified' stamp: 'JL 9/18/2017 16:18:53'!
next

	^nextStackElement.! !

!OOStackNotNullElement methodsFor: 'as yet unclassified' stamp: 'JL 9/18/2017 16:20:13'!
value
	
	^value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackNotNullElement class' category: #'Stack-Exercise'!
OOStackNotNullElement class
	instanceVariableNames: ''!

!OOStackNotNullElement class methodsFor: 'as yet unclassified' stamp: 'JL 9/18/2017 16:59:41'!
init: anElement withNext: nextStackElement
	|element|
	element := super new.
	^element init: anElement withNextElement: nextStackElement.
! !


!classDefinition: #OOStackNullElement category: #'Stack-Exercise'!
OOStackElement subclass: #OOStackNullElement
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackNullElement methodsFor: 'as yet unclassified' stamp: 'JL 9/18/2017 15:43:36'!
isEmpty
	
	^true.! !

!OOStackNullElement methodsFor: 'as yet unclassified' stamp: 'JL 9/18/2017 17:42:50'!
next
	
	self error: OOStack stackEmptyErrorDescription .! !

!OOStackNullElement methodsFor: 'as yet unclassified' stamp: 'JL 9/18/2017 17:45:36'!
value
	self error: OOStack stackEmptyErrorDescription.! !
