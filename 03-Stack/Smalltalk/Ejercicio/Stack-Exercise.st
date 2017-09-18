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
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'NL 9/17/2017 20:05:33'!
emptyCheck

	stack isEmpty ifTrue: [self error: (OOStack stackEmptyErrorDescription)].! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'NL 9/17/2017 19:24:15'!
initialize

	stack := OrderedCollection new.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'NL 9/17/2017 19:41:16'!
isEmpty

	^stack isEmpty.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'NL 9/17/2017 21:43:41'!
pop
	self subclassResponsibility.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'NL 9/17/2017 19:43:45'!
push: elementToAdd

	stack addFirst: elementToAdd.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'NL 9/17/2017 20:07:26'!
size

	^stack size.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'NL 9/17/2017 20:05:44'!
top
	self emptyCheck.
	^stack at: 1.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!OOStack class methodsFor: 'as yet unclassified' stamp: 'NL 9/17/2017 19:23:38'!
new
	
	^super new initialize.
	
 ! !


!classDefinition: #OOStackNoVacio category: #'Stack-Exercise'!
OOStack subclass: #OOStackNoVacio
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackNoVacio methodsFor: 'as yet unclassified' stamp: 'NL 9/17/2017 21:44:58'!
isEmpty
	
	^false.! !

!OOStackNoVacio methodsFor: 'as yet unclassified' stamp: 'NL 9/17/2017 21:42:14'!
pop
	^stack removeFirst.! !


!classDefinition: #OOStackVacio category: #'Stack-Exercise'!
OOStack subclass: #OOStackVacio
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackVacio methodsFor: 'as yet unclassified' stamp: 'NL 9/17/2017 21:45:13'!
isEmpty

	^true.! !

!OOStackVacio methodsFor: 'as yet unclassified' stamp: 'NL 9/17/2017 21:42:57'!
pop

	self error: (OOStack stackEmptyErrorDescription)! !
