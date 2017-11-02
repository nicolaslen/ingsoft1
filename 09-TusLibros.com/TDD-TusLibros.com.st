!classDefinition: #CartTest category: #'TDD - TusLibros.com'!
TestCase subclass: #CartTest
	instanceVariableNames: 'aCatalogWithAProduct aCartWithACatalog anItemIncludedInTheCatalog anItemNotIncludedInTheCart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDD - TusLibros.com'!

!CartTest methodsFor: 'as yet unclassified' stamp: 'JL 10/30/2017 21:24:27'!
setUp

		anItemIncludedInTheCatalog := 'aProduct'.
		anItemNotIncludedInTheCart := 'anotherProduct'.
	
		aCatalogWithAProduct := Dictionary new.
		aCatalogWithAProduct at: anItemIncludedInTheCatalog put: 10 * peso.
		
		aCartWithACatalog := Cart with: aCatalogWithAProduct.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'JL 10/30/2017 21:27:18'!
test01NewCartsAreCreatedEmpty

	self assert: aCartWithACatalog isEmpty.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'JL 10/30/2017 19:40:02'!
test02CanNotAddItemsThatDoNotBelongToCatalog
	self
		should: [ aCartWithACatalog addItem: 'anItemAbsentInTheCatalog' ]
		raise: Error
		withExceptionDo: [ :exception |
			self assert: exception messageText = Cart itemNotIntoTheCatalogError.
			self assert: aCartWithACatalog isEmpty ].! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'JL 10/30/2017 21:21:20'!
test03AfterAddingAnItemTheCartsIsNotEmptyAnymore
	
		aCartWithACatalog addItem: anItemIncludedInTheCatalog.
		
		self deny: (aCartWithACatalog isEmpty)! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'JL 10/30/2017 19:14:15'!
test04CanNotAddNonPositiveNumberOfItems
	
		self 	should: [ aCartWithACatalog addItem: anItemIncludedInTheCatalog quantity: -1. ]
				raise: Error
				withExceptionDo: [ :exception |
					self assert: exception messageText = Cart quantityCanNotBeNegative.
					self assert: aCartWithACatalog isEmpty.
					]
! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'JL 10/30/2017 19:16:25'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

		self 	should: [ aCartWithACatalog addItem: 'anItemAbsentInTheCatalog' quantity: 2 ]
				raise: Error
				withExceptionDo: [ :exception |
					self assert: exception messageText = Cart itemNotIntoTheCatalogError.
					self assert: aCartWithACatalog isEmpty.
					]! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'JL 10/30/2017 19:24:42'!
test06CartRemembersAddedItems

		aCartWithACatalog addItem: anItemIncludedInTheCatalog.
		
		self assert: (aCartWithACatalog includes: anItemIncludedInTheCatalog).! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'JL 10/30/2017 19:34:34'!
test07CartDoesNotHoldNotAddedItems

		aCartWithACatalog addItem: anItemIncludedInTheCatalog.
		
		self deny: (aCartWithACatalog includes: anItemNotIncludedInTheCart).! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'JL 10/30/2017 19:38:43'!
test08CartRemembersTheNumberOfAddedItems

		aCartWithACatalog addItem: anItemIncludedInTheCatalog quantity: 2.
		
		self assert: ((aCartWithACatalog quantityOf: anItemIncludedInTheCatalog) = 2).! !


!classDefinition: #CashierTest category: #'TDD - TusLibros.com'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'anItemIncludedInTheCatalog anItemNotIncludedInTheCart aCatalogWithAProduct aCartWithACatalog aCartWithAProduct'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDD - TusLibros.com'!

!CashierTest methodsFor: 'as yet unclassified' stamp: 'JL 11/1/2017 18:36:16'!
setUp

		anItemIncludedInTheCatalog := 'aProduct'.
		anItemNotIncludedInTheCart := 'anotherProduct'.
		aCatalogWithAProduct := Dictionary new.
		aCatalogWithAProduct at: anItemIncludedInTheCatalog put: 1*peso.
		
		aCartWithACatalog := Cart with: aCatalogWithAProduct.

		aCartWithAProduct := Cart with: aCatalogWithAProduct.
		aCartWithAProduct addItem: anItemIncludedInTheCatalog.! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'JL 11/1/2017 18:36:40'!
test01CanNotCheckoutAnEmptyCart

	| anEmptyCart aCashier aCreditCard aTodayDate|
	
	aCashier := Cashier new.
	anEmptyCart := aCartWithACatalog.
	aTodayDate := Date today.
	aCreditCard := CreditCard expiringOn: (Date tomorrow).
	
	self
		should: [ aCashier checkout: anEmptyCart date: aTodayDate withCreditCard: aCreditCard ]
		raise: Error
		withExceptionDo: [ :exception |
			self assert: exception messageText = Cashier canNotCheckoutAnEmptyCart .
			self assert: aCashier saleBook isEmpty ].! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'JL 10/30/2017 20:16:14'!
test02CalculatedTotallsCorrect! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'JL 11/1/2017 18:36:53'!
test03CantCheckoutWithExpiredCard

	| aCashier aCreditCard aTodayDate aCartWithAnItem |
	aCashier := Cashier new.
	aCartWithAnItem := aCartWithAProduct.
	aTodayDate := Date today.
	aCreditCard := CreditCard expiringOn: (Date yesterday).
	
	self
		should: [ aCashier checkout: aCartWithAnItem date: aTodayDate withCreditCard: aCreditCard ]
		raise: Error
		withExceptionDo: [ :exception |
			self assert: exception messageText = Cashier canNotCheckoutWithExpiredCard .
			self assert: aCashier saleBook isEmpty ].! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'JL 10/30/2017 20:16:44'!
test04CheckoutRegisterASale! !


!classDefinition: #Cart category: #'TDD - TusLibros.com'!
Object subclass: #Cart
	instanceVariableNames: 'items catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDD - TusLibros.com'!

!Cart methodsFor: 'as yet unclassified' stamp: 'JL 10/30/2017 18:55:38'!
addItem: anItem 

	self addItem: anItem quantity: 1.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'JL 10/30/2017 21:28:35'!
addItem: anItem quantity: aQuantity 
	
	(catalog includesKey: anItem) ifFalse: [ ^self error: self class itemNotIntoTheCatalogError ].
	(aQuantity < 1) ifTrue: [ ^self error: self class quantityCanNotBeNegative ].
		
	items at: anItem put: aQuantity.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'JL 10/30/2017 21:09:53'!
catalog

	^catalog! !

!Cart methodsFor: 'as yet unclassified' stamp: 'JL 10/30/2017 19:31:40'!
includes: anItem 
	^items includesKey: anItem.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'JL 10/30/2017 18:54:11'!
initializeWith: aCatalog
	
	items := Dictionary new.
	catalog := aCatalog .! !

!Cart methodsFor: 'as yet unclassified' stamp: 'JL 10/26/2017 21:29:18'!
isEmpty
	^ (self itemsQuantity) = 0.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'JL 11/1/2017 18:44:57'!
items

	^items keys.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'JL 10/26/2017 21:26:34'!
itemsQuantity
	^items size.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'JL 10/30/2017 19:00:05'!
quantityOf: anItem 
	
	^items at: anItem.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'TDD - TusLibros.com'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'as yet unclassified' stamp: 'JL 10/30/2017 18:47:01'!
itemNotIntoTheCatalogError

	^'The item is not in the Catalog'! !

!Cart class methodsFor: 'as yet unclassified' stamp: 'JL 10/30/2017 19:14:42'!
quantityCanNotBeNegative

	^'The quantity can not be negative'! !

!Cart class methodsFor: 'as yet unclassified' stamp: 'JL 10/30/2017 18:38:02'!
with: aCatalog

	^self new initializeWith: aCatalog.! !


!classDefinition: #Cashier category: #'TDD - TusLibros.com'!
Object subclass: #Cashier
	instanceVariableNames: 'saleBook merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDD - TusLibros.com'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'JL 11/1/2017 19:03:58'!
checkout: aCart date: aDate withCreditCard: aCreditCard

	| aCatalog orderCost |
	
	aCatalog := aCart catalog.
	aCart isEmpty ifTrue: [^self error: (self class canNotCheckoutAnEmptyCart)].
	(aCreditCard isExpiredOn: aDate) ifTrue: [^self error: (self class canNotCheckoutWithExpiredCard)].
	
	
	orderCost := 0.00 * peso.
	aCart items do: [ :anItem | orderCost := orderCost + (aCatalog at: anItem) ].
	
	merchantProcessor creditCard: aCreditCard charge: orderCost.
	
	aCart items do: [ :anItem | saleBook addItem: anItem ].
	
	^orderCost.! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'JL 10/30/2017 19:52:19'!
initialize
	
	saleBook := OrderedCollection new.! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'JL 10/30/2017 21:38:56'!
saleBook

	^saleBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #'TDD - TusLibros.com'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'as yet unclassified' stamp: 'JL 10/30/2017 21:37:44'!
canNotCheckoutAnEmptyCart
	
	^'Can not checkout an empty cart'! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'JL 11/1/2017 18:06:17'!
canNotCheckoutWithExpiredCard
	
	^'Can not checkout with an expired credit card'.! !


!classDefinition: #CreditCard category: #'TDD - TusLibros.com'!
Object subclass: #CreditCard
	instanceVariableNames: 'expireDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDD - TusLibros.com'!

!CreditCard methodsFor: 'as yet unclassified' stamp: 'JL 10/30/2017 21:33:15'!
initializeExpiringOn: aDate

	expireDate := aDate.! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'JL 11/1/2017 18:32:44'!
isExpiredOn: aDate

	^expireDate < aDate.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #'TDD - TusLibros.com'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'JL 10/30/2017 21:34:29'!
expiringOn: aDate

	^self new initializeExpiringOn: aDate.! !
