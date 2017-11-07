!classDefinition: #CartInterfaceTest category: #'TDD - TusLibros.com'!
TestCase subclass: #CartInterfaceTest
	instanceVariableNames: 'provider cartInterface'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDD - TusLibros.com'!

!CartInterfaceTest methodsFor: 'as yet unclassified' stamp: 'NL 11/6/2017 16:55:07'!
setUp
	provider _ TestInstancesFactory new.
	
	cartInterface := 
		CartInterface 
			withClients: provider createSomeUsers 
			catalog: provider createCatalogWithSomeProducts 
			cashier: (provider createCashierWithMP: self salesBook: Dictionary new)
! !

!CartInterfaceTest methodsFor: 'as yet unclassified' stamp: 'NL 11/6/2017 16:31:30'!
test01CanNotCreateCartWithInvalidUser

	| aPassword anInvalidUserName aCartInterface |
	anInvalidUserName := provider createInvalidUserName.
	aPassword := provider createPassword.
	
	aCartInterface := cartInterface.
	
	self should: [ aCartInterface createCartForClient: anInvalidUserName password: aPassword ]
		raise: Error
		withExceptionDo: [ :exception |
			self assert: exception messageText = CartInterface invalidUserOrPassword ].
	
! !

!CartInterfaceTest methodsFor: 'as yet unclassified' stamp: 'NL 11/6/2017 16:31:42'!
test02CanNotCreateCartWithInvalidPassword


	| anUserName aCartInterface anInvalidPassword |
	anUserName := provider createUserName.
	anInvalidPassword := provider createInvalidPassword.
	
	aCartInterface := cartInterface.
	
	self should: [ aCartInterface createCartForClient: anUserName password: anInvalidPassword ]
		raise: Error
		withExceptionDo: [ :exception |
			self assert: exception messageText = CartInterface invalidUserOrPassword ].
	
! !

!CartInterfaceTest methodsFor: 'as yet unclassified' stamp: 'NL 11/5/2017 18:07:23'!
test03CreateCartStartsEmpty
	
	| aCartInterface anUserName aPassword aCart aCartId |
	
	anUserName := provider createUserName.
	aPassword := provider createPassword.
	
	aCartInterface := cartInterface.
	aCartId := aCartInterface createCartForClient: anUserName password: aPassword.

	aCart := aCartInterface cartWithId: aCartId.
	
	self assert: aCart isEmpty! !

!CartInterfaceTest methodsFor: 'as yet unclassified' stamp: 'NL 11/5/2017 18:21:39'!
test04CanNotGetACartWithInvalidId
	
	| aCartInterface aCartId |
	
	aCartInterface := cartInterface.
	aCartId := provider createInvalidCartId.

	self should: [	aCartInterface cartWithId: aCartId. ]
		raise: Error
		withExceptionDo: [ :exception |
			self assert: exception messageText = CartInterface invalidId ].! !

!CartInterfaceTest methodsFor: 'as yet unclassified' stamp: 'NL 11/5/2017 18:47:02'!
test05CanNotAddItemToNotCreatedCart
	
	| aCartInterface anInvalidCartId |
	
	aCartInterface := cartInterface.
	
	anInvalidCartId := provider createInvalidCartId.

	self should: [ aCartInterface addToCartWithId: anInvalidCartId item: provider createProduct quantity: 1 ]
		raise: Error
		withExceptionDo: [ :exception |
			self assert: exception messageText = CartInterface invalidId ].! !

!CartInterfaceTest methodsFor: 'as yet unclassified' stamp: 'NL 11/5/2017 18:46:03'!
test06CanNotAddItemAbsentInCatalog
	
	| aCartInterface aCartId |
	
	aCartInterface := cartInterface.
	aCartId := aCartInterface createCartForClient: provider createUserName password: provider createPassword .
	
	self should: [ aCartInterface addToCartWithId: aCartId item: provider createItemAbsentInTheCatalog quantity: 1 ]
		raise: Error
		withExceptionDo: [ :exception |
			self assert: exception messageText = CartInterface itemAbsentInCatalog ].! !

!CartInterfaceTest methodsFor: 'as yet unclassified' stamp: 'NL 11/5/2017 19:17:08'!
test08CartWithItemIsNotEmpty
	
	| aCartInterface aCartId aCart |
	
	aCartInterface := cartInterface.
	aCartId := aCartInterface createCartForClient: provider createUserName password: provider createPassword .
	
	aCartInterface addToCartWithId: aCartId item: provider createProduct quantity: 1.
	
	aCart := aCartInterface cartWithId: aCartId.
	
	self deny: aCart isEmpty
	
	
	! !

!CartInterfaceTest methodsFor: 'as yet unclassified' stamp: 'NL 11/5/2017 19:34:51'!
test09CanNotListCartWithInvalidId
	
	| aCartId aCartInterface |
	aCartInterface := cartInterface.
	aCartId := provider createInvalidCartId.

	self should: [	aCartInterface listCartWithId: aCartId. ]
		raise: Error
		withExceptionDo: [ :exception |
			self assert: exception messageText = CartInterface invalidId ].! !

!CartInterfaceTest methodsFor: 'as yet unclassified' stamp: 'NL 11/5/2017 19:56:24'!
test10ListCartReturnsQuantityOfItem
	
	| aCartInterface aCartId cartItems |
	
	aCartInterface := cartInterface.
	aCartId := aCartInterface createCartForClient: provider createUserName password: provider createPassword .
	
	aCartInterface addToCartWithId: aCartId item: provider createProduct quantity: 10.
	aCartInterface addToCartWithId: aCartId item: provider createAnotherProduct quantity: 15.
	aCartInterface addToCartWithId: aCartId item: provider createOneMoreProduct quantity: 20.
	
	cartItems := aCartInterface listCartWithId: aCartId.
	
	self assert: (cartItems at: provider createProduct) = 10.
	self assert: (cartItems at: provider createAnotherProduct) = 15.
	self assert: (cartItems at: provider createOneMoreProduct) = 20.
	
	! !

!CartInterfaceTest methodsFor: 'as yet unclassified' stamp: 'NL 11/5/2017 21:12:44'!
test11CanNotCheckoutACartWithInvalidId
	
	| aCartId aCartInterface aCreditCard |
	aCartInterface := cartInterface.
	aCartId := provider createInvalidCartId.
	aCreditCard := provider createCreditCard.

	self should: [	aCartInterface checkOutCartWithId: aCartId creditCard: aCreditCard ]
		raise: Error
		withExceptionDo: [ :exception |
			self assert: exception messageText = CartInterface invalidId ].! !

!CartInterfaceTest methodsFor: 'as yet unclassified' stamp: 'NL 11/5/2017 21:14:41'!
test12CanNotCheckoutAnEmptyCart
	
	| aCartId aCartInterface aCreditCard |
	
	aCartInterface := cartInterface.
	aCartId := aCartInterface createCartForClient: provider createUserName password: provider createPassword .
	aCreditCard := provider createCreditCard.

	self should: [	aCartInterface checkOutCartWithId: aCartId creditCard: aCreditCard ]
		raise: Error
		withExceptionDo: [ :exception |
			self assert: exception messageText = CartInterface canNotCheckoutAnEmptyCart ].! !

!CartInterfaceTest methodsFor: 'as yet unclassified' stamp: 'NL 11/6/2017 15:13:05'!
test13CanNotCheckoutWithAnExpiredCreditCard
	
	| aCartId aCartInterface anExpiredCreditCard |
	
	aCartInterface := cartInterface.
	aCartId := aCartInterface createCartForClient: provider createUserName password: provider createPassword .
	anExpiredCreditCard := provider createExpiredCreditCard.
	
	aCartInterface addToCartWithId: aCartId item: provider createProduct quantity: 10.
		
	self should: [	aCartInterface checkOutCartWithId: aCartId creditCard: anExpiredCreditCard ]
		raise: Error
		withExceptionDo: [ :exception |
			self assert: exception messageText = CartInterface canNotCheckoutWithExpiredCard ].! !

!CartInterfaceTest methodsFor: 'as yet unclassified' stamp: 'NL 11/6/2017 18:04:26'!
test14ListPurchasesReturnItemsBought
		
	| aCartId aCartInterface aCreditCard aPassword anUserName purchases |
	aCreditCard := provider createCreditCard.

	aCartInterface := cartInterface.
	anUserName := provider createUserName. 	

	aPassword := provider createPassword.

	aCartId := aCartInterface createCartForClient: provider createUserName password: provider createPassword .
	aCartInterface addToCartWithId: aCartId item: provider createProduct quantity: 10.

	aCartInterface addToCartWithId: aCartId item: provider createAnotherProduct quantity: 15.
	
	aCartInterface checkOutCartWithId: aCartId creditCard: aCreditCard.
	
	purchases := aCartInterface listPurchasesFor: anUserName withPassword: aPassword.
	
	self assert: (purchases at: (provider createProduct)) = 10.
	
	self assert: (purchases at: (provider createAnotherProduct)) = 15.! !


!classDefinition: #CartTest category: #'TDD - TusLibros.com'!
TestCase subclass: #CartTest
	instanceVariableNames: 'provider'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDD - TusLibros.com'!

!CartTest methodsFor: 'as yet unclassified' stamp: 'JL 11/3/2017 20:47:51'!
setUp
	provider _ TestInstancesFactory new.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'JL 11/4/2017 17:47:57'!
test01NewCartsAreCreatedEmpty
	| anEmptyCart |
	anEmptyCart _ provider createEmptyCart.
	self assert: anEmptyCart isEmpty.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'JL 11/4/2017 17:48:16'!
test02CanNotAddItemsThatDoNotBelongToCatalog
	| anEmptyCart anItemAbsentInTheCatalog |
	anEmptyCart _ provider createEmptyCart.
	anItemAbsentInTheCatalog _ provider createItemAbsentInTheCatalog.
	self
		should: [ | anItemAbsentInTheCatalo |
			anEmptyCart addItem: anItemAbsentInTheCatalog ]
		raise: Error
		withExceptionDo: [ :exception |
			self assert: exception messageText = Cart itemNotIntoTheCatalogError.
			self assert: anEmptyCart isEmpty ].! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'JL 11/4/2017 17:47:57'!
test03AfterAddingAnItemTheCartsIsNotEmptyAnymore
	| aCart |
	aCart _ provider createEmptyCart.
	aCart addItem: provider createProduct.
	self deny: aCart isEmpty.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'JL 11/4/2017 17:47:57'!
test04CanNotAddNonPositiveNumberOfItems
	| aCart anItemIncludedInTheCatalog |
	aCart _ provider createEmptyCart.
	anItemIncludedInTheCatalog _ provider createProduct.
	self
		should: [
			aCart
				addItem: anItemIncludedInTheCatalog
				quantity: -1 ]
		raise: Error
		withExceptionDo: [ :exception |
			self assert: exception messageText = Cart quantityCanNotBeNegative.
			self assert: aCart isEmpty ].! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'JL 11/4/2017 17:47:57'!
test05CanNotAddMoreThanOneItemNotSellByTheStore
	| aCart anItemAbsentInTheCatalog |
	aCart _ provider createEmptyCart.
	anItemAbsentInTheCatalog _ provider createAnotherProduct.
	self
		should: [
			aCart
				addItem: anItemAbsentInTheCatalog
				quantity: 2 ]
		raise: Error
		withExceptionDo: [ :exception |
			self assert: exception messageText = Cart itemNotIntoTheCatalogError.
			self assert: aCart isEmpty ].! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'JL 11/4/2017 17:47:26'!
test06CartRemembersAddedItems
	| aCart anItemIncludedInTheCatalog |
	aCart _ provider createCartWithAProduct.
	anItemIncludedInTheCatalog _ provider createProduct.
	self assert: (aCart includes: anItemIncludedInTheCatalog).! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'JL 11/4/2017 17:47:26'!
test07CartDoesNotHoldNotAddedItems
	| aCart anItemNotIncludedInTheCart |
	aCart _ provider createCartWithAProduct.
	anItemNotIncludedInTheCart _ provider createAnotherProduct.
	self deny: (aCart includes: anItemNotIncludedInTheCart).! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'NL 11/5/2017 19:53:59'!
test08CartRemembersTheNumberOfAddedItems
	| aCart anItemIncludedInTheCatalog |
	aCart _ provider createEmptyCart.
	anItemIncludedInTheCatalog _ provider createProduct.
	aCart
		addItem: anItemIncludedInTheCatalog
		quantity: 2.
	self assert: (aCart quantityOf: anItemIncludedInTheCatalog) = 2.

	! !


!classDefinition: #CashierTest category: #'TDD - TusLibros.com'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'aCashier provider debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDD - TusLibros.com'!

!CashierTest methodsFor: 'as yet unclassified' stamp: 'JL 11/4/2017 18:54:03'!
debit: aCost from: aCard

	debitBehavior value: aCost value: aCard.! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'NL 11/5/2017 20:56:21'!
setUp
	provider _ TestInstancesFactory new.
	aCashier _ provider createCashierWithMP: self.! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'NL 11/6/2017 17:39:13'!
test01CanNotCheckoutAnEmptyCart

	debitBehavior _ [ :anAmount :aCard | self fail ].
	
	self
		should: [
			aCashier
				checkout: provider createEmptyCart
				date: provider today
				withCreditCard: provider createCreditCard
				
				client: provider createUserName
				
				 ]
		raise: Error
		withExceptionDo: [ :exception |
			self assert: exception messageText = Cashier canNotCheckoutAnEmptyCart.
			self assert: aCashier salesBook isEmpty ].! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'NL 11/6/2017 17:37:45'!
test02CalculatedTotallsCorrect
	| total |
	
	debitBehavior _ [ :anAmount :aCard | ].

	total _ aCashier
		checkout: provider createCartWithSomeProducts
		date: provider today
		withCreditCard: provider createCreditCard
		
		client: provider createUserName .
	self assert: total = (700 * peso).! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'NL 11/6/2017 17:36:46'!
test03CantCheckoutWithExpiredCard
	
	debitBehavior _ [ :anAmount :aCard | self fail ].
	self
		should: [
			aCashier
				checkout: provider createCartWithAProduct
				date: provider today
				withCreditCard: provider createExpiredCreditCard
				
				client: provider createUserName 
				 ]
		raise: Error
		withExceptionDo: [ :exception |
			self assert: exception messageText = Cashier canNotCheckoutWithExpiredCard.
			self assert: aCashier salesBook isEmpty ].! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'NL 11/6/2017 17:37:28'!
test04CheckoutRegisterASale
	| aSalesBook aCart lastSale |
	
	debitBehavior _ [ :anAmount :aCard |  ].
	aCart := provider createCartWithSomeProducts.
	
	
	aCashier
		checkout: aCart
		date: provider today
		withCreditCard: provider createCreditCard
		
		client: provider createUserName .
	
	aSalesBook := aCashier salesBook.
	lastSale := aSalesBook last.
	self assert: (lastSale cart = aCart).! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'NL 11/6/2017 17:36:54'!
test05CanNotDebitFromStolenCreditCard
	| aStolenCard |

	aStolenCard _ provider createCreditCard.

	debitBehavior _ [ :anAmount :aCard | self error: 'Stolen card' ].

	self
		should: [
			aCashier
				checkout: provider createCartWithSomeProducts
				date: provider today
				withCreditCard: aStolenCard
				
				client: provider createUserName 
				 ]
		raise: Error
		withExceptionDo: [ :exception |
			self assert: exception messageText = Cashier canNotCheckoutWithStoledCard.
			self assert: aCashier salesBook isEmpty ].! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'NL 11/6/2017 17:37:02'!
test06CanNotDebitFromCreditCardWithoutFounds
	| aCreditCardWithoutFounds |
	
	aCreditCardWithoutFounds _ provider createCreditCard.
	debitBehavior _ [ :anAmount :aCard | self error: 'The card has not founds' ].
	self
		should: [
			aCashier
				checkout: provider createCartWithSomeProducts
				date: provider today
				withCreditCard: aCreditCardWithoutFounds
				
				client: provider createUserName
				 ]
		raise: Error
		withExceptionDo: [ :exception |
			self assert: exception messageText = Cashier canNotCheckoutWithCardWithoutFounds.
			self assert: aCashier salesBook isEmpty ].! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'NL 11/6/2017 17:37:14'!
test07CashierChargesCreditCardUsingMerchantProcessor
	| aCreditCard debitedAmount debitedCreditCard total |
	
	aCreditCard := provider createCreditCard.
	
	debitBehavior _ [ :anAmount :aCard | 
		debitedAmount _ anAmount. 
		debitedCreditCard _ aCard ].
	
	total _ aCashier
		checkout: provider createCartWithSomeProducts
		date: provider today
		withCreditCard: aCreditCard
		
		client: provider createUserName.
	
	self assert: debitedCreditCard = aCreditCard.
	self assert: debitedAmount = total.! !


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

!Cart methodsFor: 'as yet unclassified' stamp: 'NL 11/5/2017 19:31:55'!
items

	^items keys.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'JL 10/26/2017 21:26:34'!
itemsQuantity
	^items size.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'NL 11/5/2017 19:32:05'!
itemsWithQuantities

	^items.! !

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


!classDefinition: #CartInterface category: #'TDD - TusLibros.com'!
Object subclass: #CartInterface
	instanceVariableNames: 'users catalog carts lastId cashier salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDD - TusLibros.com'!

!CartInterface methodsFor: 'as yet unclassified' stamp: 'NL 11/5/2017 18:51:03'!
addToCartWithId: aCartId item: anItem quantity: aQuantity

	| aCart |
	aCart := self cartWithId: aCartId.
	
	[ aCart addItem: anItem quantity: aQuantity ] 
		on: Error 
		do: [ :exception |
			(exception messageText = Cart itemNotIntoTheCatalogError) ifTrue: [ ^self error: self class itemAbsentInCatalog ].
			(exception messageText = Cart quantityCanNotBeNegative) ifTrue: [ ^self error: self class invalidQuantity ]
			].! !

!CartInterface methodsFor: 'as yet unclassified' stamp: 'NL 11/6/2017 17:44:29'!
cartWithId: aCartId

	| aSession |
	aSession := carts at: aCartId ifAbsent: [^self error: CartInterface invalidId].
	
	^aSession cart.! !

!CartInterface methodsFor: 'as yet unclassified' stamp: 'NL 11/6/2017 17:17:43'!
checkOutCartWithId: aCartId creditCard: aCreditCard

	| aCart today |
	aCart := self cartWithId: aCartId.
	today := Date today.

	[ cashier checkout: aCart date: today withCreditCard: aCreditCard client: '' ] 
		on: Error 
		do: [ :exception |
			(exception messageText = Cashier canNotCheckoutAnEmptyCart) ifTrue: [ ^self error: self class canNotCheckoutAnEmptyCart ].
			(exception messageText = Cashier canNotCheckoutWithExpiredCard) ifTrue: [ ^self error: self class canNotCheckoutWithExpiredCard ].
			
			].! !

!CartInterface methodsFor: 'as yet unclassified' stamp: 'NL 11/6/2017 17:43:06'!
createCartForClient: aClientId password: aPassword

	self login: aClientId 
		password: aPassword 
		then: 
		[ 
				| aCartId aCart aSessionCart |
	aCartId := self generateCartId.
	
	aCart := Cart with: catalog.
	
	aSessionCart := Session for: aClientId with: aCart.
	
	carts at: aCartId put: aSessionCart.

	^aCartId			
			].
! !

!CartInterface methodsFor: 'as yet unclassified' stamp: 'NL 11/5/2017 19:24:40'!
generateCartId

	lastId := lastId + 1.
	^lastId! !

!CartInterface methodsFor: 'as yet unclassified' stamp: 'NL 11/5/2017 20:59:26'!
initializeWithClients: someClientsWithPasswords 
	catalog: aCatalog 
	cashier: aCashier

	users := someClientsWithPasswords.
	catalog := aCatalog.
	cashier := aCashier.
	
	lastId := 0.
	carts := Dictionary new.! !

!CartInterface methodsFor: 'as yet unclassified' stamp: 'NL 11/5/2017 19:32:56'!
listCartWithId: aCartId

	| aCart |
	aCart := self cartWithId: aCartId.
	
	^aCart itemsWithQuantities! !

!CartInterface methodsFor: 'as yet unclassified' stamp: 'NL 11/6/2017 18:01:51'!
listPurchasesFor: aClientId withPassword: aPassword

	
	^self login: aClientId 
		password: aPassword 
		then: 
		[ | purchases | 
			purchases := Dictionary new.
			
			carts valuesDo: [ :aSession | | aCart itemsWithQuantities aCatalog | 
				
				aCart := aSession cart.
				aCatalog := aCart catalog.
				itemsWithQuantities := aCart itemsWithQuantities.
				itemsWithQuantities keys do: [ :anItem |
					
						
						purchases at: anItem ifPresent: [ purchases at: anItem put: (purchases at: anItem) + (itemsWithQuantities at: anItem) ] ifAbsent: [ purchases at: anItem put: (itemsWithQuantities at: anItem) ].
						
					]
				  ].
			
			^purchases
			].
! !

!CartInterface methodsFor: 'as yet unclassified' stamp: 'NL 11/6/2017 16:37:35'!
login: aClientId password: aPassword then: aBlock

	| passwordOfClient |
	
	passwordOfClient := users at: aClientId ifAbsent: [^self error: CartInterface invalidUserOrPassword ].
	
	(aPassword ~= passwordOfClient) ifTrue: [^self error: CartInterface invalidUserOrPassword ].
	
	^aBlock value.! !

!CartInterface methodsFor: 'as yet unclassified' stamp: 'NL 11/6/2017 16:51:16'!
salesBoughtBy: anUser
	| salesBook |
	^ salesBook select: [ :aSale | | aUser | aSale wasDoneBy: aUser ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartInterface class' category: #'TDD - TusLibros.com'!
CartInterface class
	instanceVariableNames: ''!

!CartInterface class methodsFor: 'as yet unclassified' stamp: 'NL 11/5/2017 21:14:21'!
canNotCheckoutAnEmptyCart

	^'Can not checkout an empty cart'! !

!CartInterface class methodsFor: 'as yet unclassified' stamp: 'NL 11/5/2017 21:39:54'!
canNotCheckoutWithExpiredCard
	^'Can not checkout with an expired credit card'! !

!CartInterface class methodsFor: 'as yet unclassified' stamp: 'NL 11/5/2017 18:16:16'!
invalidId

	^'Invalid Id'! !

!CartInterface class methodsFor: 'as yet unclassified' stamp: 'NL 11/5/2017 18:48:29'!
invalidQuantity

	^'Quantity must be positive'! !

!CartInterface class methodsFor: 'as yet unclassified' stamp: 'NL 11/6/2017 16:29:55'!
invalidUserOrPassword

	^'The user or password is incorrect'! !

!CartInterface class methodsFor: 'as yet unclassified' stamp: 'NL 11/5/2017 18:42:56'!
itemAbsentInCatalog

	^'The item is not present into the catalog of the store'.! !

!CartInterface class methodsFor: 'as yet unclassified' stamp: 'NL 11/5/2017 20:59:46'!
withClients: someClientsWithPasswords catalog: aCatalog cashier: aCashier

	^self new initializeWithClients: someClientsWithPasswords
	 	catalog: aCatalog
		cashier: aCashier	
! !


!classDefinition: #Cashier category: #'TDD - TusLibros.com'!
Object subclass: #Cashier
	instanceVariableNames: 'salesBook merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDD - TusLibros.com'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'NL 11/6/2017 17:38:46'!
checkout: aCart date: aDate withCreditCard: aCreditCard client: aClient

	| aCatalog orderCost aSale |
	
	aCatalog := aCart catalog.
	aCart isEmpty ifTrue: [^self error: (self class canNotCheckoutAnEmptyCart)].
	(aCreditCard isExpiredOn: aDate) ifTrue: [^self error: (self class canNotCheckoutWithExpiredCard)].
	
	
	orderCost := 0.00 * peso.
	aCart items do: [ :anItem | orderCost := (aCatalog at: anItem) * (aCart quantityOf: anItem) + orderCost ].
	
	[ merchantProcessor debit: orderCost from: aCreditCard. ] 
		on: Error 
		do: [ :exception |
			(exception messageText = 'Stolen card') ifTrue: [ ^self error: self class canNotCheckoutWithStoledCard ].
			(exception messageText = 'The card has not founds') ifTrue: [ ^self error: self class canNotCheckoutWithCardWithoutFounds ]				
		].
	
	aSale := Sale for: aClient cart: aCart.

	salesBook add: aSale.
	
	^orderCost.! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'JL 11/4/2017 17:33:01'!
initializeWithMP: aMerchantProcessor salesBook: aSalesBook
	
	salesBook := aSalesBook.
	merchantProcessor := aMerchantProcessor.! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'JL 11/4/2017 17:34:14'!
salesBook
	^ salesBook.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #'TDD - TusLibros.com'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'as yet unclassified' stamp: 'JL 10/30/2017 21:37:44'!
canNotCheckoutAnEmptyCart
	
	^'Can not checkout an empty cart'! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'JL 11/3/2017 16:28:57'!
canNotCheckoutWithCardWithoutFounds
	
	^'The card has not founds'.! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'JL 11/1/2017 18:06:17'!
canNotCheckoutWithExpiredCard
	
	^'Can not checkout with an expired credit card'.! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'JL 11/3/2017 17:02:08'!
canNotCheckoutWithStoledCard
	
	^'Can not checkout with a stoled credit card'.! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'JL 11/4/2017 17:35:14'!
withMP: aMerchantProcessor salesBook: aSalesBook
	
	^self new initializeWithMP: aMerchantProcessor salesBook: aSalesBook.! !


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


!classDefinition: #Sale category: #'TDD - TusLibros.com'!
Object subclass: #Sale
	instanceVariableNames: 'client cart clientId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDD - TusLibros.com'!

!Sale methodsFor: 'as yet unclassified' stamp: 'NL 11/6/2017 17:16:35'!
cart
	
	^cart! !

!Sale methodsFor: 'as yet unclassified' stamp: 'NL 11/6/2017 17:16:30'!
client
	
	^client! !

!Sale methodsFor: 'as yet unclassified' stamp: 'NL 11/6/2017 17:38:06'!
initializeFor: aClient withCart: aCart.
	
	client := aClient.
	cart := aCart.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #'TDD - TusLibros.com'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'as yet unclassified' stamp: 'NL 11/6/2017 17:38:19'!
for: aClient cart: aCart
	
	^self new initializeFor: aClient withCart:aCart.! !


!classDefinition: #Session category: #'TDD - TusLibros.com'!
Object subclass: #Session
	instanceVariableNames: 'client cart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDD - TusLibros.com'!

!Session methodsFor: 'as yet unclassified' stamp: 'NL 11/6/2017 17:45:01'!
cart
	^cart! !

!Session methodsFor: 'as yet unclassified' stamp: 'NL 11/6/2017 17:44:53'!
client
	^client! !

!Session methodsFor: 'as yet unclassified' stamp: 'NL 11/6/2017 17:42:16'!
initializeFor: aClient with: aCart

	client := aClient.
	cart := aCart.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Session class' category: #'TDD - TusLibros.com'!
Session class
	instanceVariableNames: ''!

!Session class methodsFor: 'as yet unclassified' stamp: 'NL 11/6/2017 17:41:49'!
for: aClient with: aCart

	^self new initializeFor: aClient with: aCart! !


!classDefinition: #TestInstancesFactory category: #'TDD - TusLibros.com'!
Object subclass: #TestInstancesFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDD - TusLibros.com'!

!TestInstancesFactory methodsFor: 'as yet unclassified' stamp: 'JL 11/3/2017 18:41:24'!
createAnotherProduct
	^'anotherProduct'! !

!TestInstancesFactory methodsFor: 'as yet unclassified' stamp: 'NL 11/6/2017 15:35:45'!
createAnotherProductPrice

	^15 * peso.! !

!TestInstancesFactory methodsFor: 'as yet unclassified' stamp: 'NL 11/5/2017 18:43:33'!
createCartId

	^1! !

!TestInstancesFactory methodsFor: 'as yet unclassified' stamp: 'JL 11/4/2017 17:47:26'!
createCartWithAProduct
	| aCart |
	aCart _ Cart with: self createCatalogWithAProduct.
	aCart addItem: self createProduct.
	^ aCart.! !

!TestInstancesFactory methodsFor: 'as yet unclassified' stamp: 'JL 11/4/2017 17:47:40'!
createCartWithSomeProducts
	| aCart aProduct anotherProduct oneMoreProduct |
	aCart _ Cart with: self createCatalogWithSomeProducts.
	aProduct _ self createProduct.
	anotherProduct _ self createAnotherProduct.
	oneMoreProduct _ self createOneMoreProduct.
	aCart
		addItem: aProduct
		quantity: 10.
	aCart
		addItem: anotherProduct
		quantity: 20.
	aCart
		addItem: oneMoreProduct
		quantity: 15.
	^ aCart.! !

!TestInstancesFactory methodsFor: 'as yet unclassified' stamp: 'NL 11/5/2017 20:55:19'!
createCashierWithMP: aMerchantProcessor

	^Cashier withMP: aMerchantProcessor salesBook: self createSalesBook.! !

!TestInstancesFactory methodsFor: 'as yet unclassified' stamp: 'NL 11/6/2017 17:05:59'!
createCashierWithMP: aMerchantProcessor salesBook: aSalesBook

	^Cashier withMP: aMerchantProcessor salesBook: aSalesBook.! !

!TestInstancesFactory methodsFor: 'as yet unclassified' stamp: 'NL 11/6/2017 15:36:31'!
createCatalogWithAProduct
	| aCatalogWithAProduct aProduct |
	aProduct _ self createProduct.
	aCatalogWithAProduct _ Dictionary new.
	aCatalogWithAProduct
		at: aProduct
		put: self createProductPrice.
	^ aCatalogWithAProduct.! !

!TestInstancesFactory methodsFor: 'as yet unclassified' stamp: 'NL 11/6/2017 15:37:26'!
createCatalogWithSomeProducts
	| aCatalogWithAProduct aProduct anotherProduct oneMoreProduct |
	aProduct _ self createProduct.
	anotherProduct _ self createAnotherProduct.
	oneMoreProduct _ self createOneMoreProduct.
	aCatalogWithAProduct _ Dictionary new.
	aCatalogWithAProduct
		at: aProduct
		put: self createProductPrice.
	aCatalogWithAProduct
		at: anotherProduct
		put: self createAnotherProductPrice .
	aCatalogWithAProduct
		at: oneMoreProduct
		put: self createOneMoreProductPrice .
	^ aCatalogWithAProduct.! !

!TestInstancesFactory methodsFor: 'as yet unclassified' stamp: 'JL 11/4/2017 17:46:29'!
createCreditCard
	^CreditCard expiringOn: self tomorrow! !

!TestInstancesFactory methodsFor: 'as yet unclassified' stamp: 'JL 11/4/2017 17:47:57'!
createEmptyCart
	^ Cart with: self createCatalogWithAProduct.! !

!TestInstancesFactory methodsFor: 'as yet unclassified' stamp: 'JL 11/4/2017 17:50:39'!
createExpiredCreditCard
	^CreditCard expiringOn: self yesterday! !

!TestInstancesFactory methodsFor: 'as yet unclassified' stamp: 'NL 11/5/2017 18:20:54'!
createInvalidCartId

	^'-1'! !

!TestInstancesFactory methodsFor: 'as yet unclassified' stamp: 'NL 11/5/2017 16:10:24'!
createInvalidPassword

	^'password'! !

!TestInstancesFactory methodsFor: 'as yet unclassified' stamp: 'NL 11/5/2017 17:05:57'!
createInvalidUserName

	^'invalidUserName'! !

!TestInstancesFactory methodsFor: 'as yet unclassified' stamp: 'JL 11/4/2017 17:48:16'!
createItemAbsentInTheCatalog
	^ 'anItemAbsentInTheCatalog'.! !

!TestInstancesFactory methodsFor: 'as yet unclassified' stamp: 'JL 11/3/2017 19:41:28'!
createOneMoreProduct
	^'oneMoreProduct'! !

!TestInstancesFactory methodsFor: 'as yet unclassified' stamp: 'NL 11/6/2017 15:35:54'!
createOneMoreProductPrice

	^20 * peso.! !

!TestInstancesFactory methodsFor: 'as yet unclassified' stamp: 'NL 11/5/2017 15:27:04'!
createPassword

	^'p@s$w0rD'! !

!TestInstancesFactory methodsFor: 'as yet unclassified' stamp: 'JL 11/4/2017 17:47:07'!
createProduct
	^ 'aProduct'.! !

!TestInstancesFactory methodsFor: 'as yet unclassified' stamp: 'NL 11/6/2017 15:36:36'!
createProductPrice

	^10 * peso.! !

!TestInstancesFactory methodsFor: 'as yet unclassified' stamp: 'NL 11/5/2017 20:54:59'!
createSalesBook
	
	^OrderedCollection new.! !

!TestInstancesFactory methodsFor: 'as yet unclassified' stamp: 'NL 11/5/2017 17:13:25'!
createSomeUsers

	| users |
	users := Dictionary new.
	users at: 'Carlitos' put: 'p@s$w0rD'.
	users at: 'Juancito' put: 'p@s$w0rD'.
	
	^users.! !

!TestInstancesFactory methodsFor: 'as yet unclassified' stamp: 'NL 11/5/2017 17:12:15'!
createUserName

	^'Carlitos'! !

!TestInstancesFactory methodsFor: 'as yet unclassified' stamp: 'JL 11/4/2017 17:42:10'!
today
	^Date today.! !

!TestInstancesFactory methodsFor: 'as yet unclassified' stamp: 'JL 11/4/2017 17:42:19'!
tomorrow
	^Date tomorrow.! !

!TestInstancesFactory methodsFor: 'as yet unclassified' stamp: 'JL 11/4/2017 17:46:07'!
yesterday
	^Date yesterday.! !
