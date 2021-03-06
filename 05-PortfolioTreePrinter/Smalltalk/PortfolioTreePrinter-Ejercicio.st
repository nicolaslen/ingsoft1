!classDefinition: #PortfolioTest category: #'PortfolioTreePrinter-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 18:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	account := ReceptiveAccount new.

	self assert: 0 = account balance .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 18:45'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 = account balance .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 05:34'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 = account balance .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 18:48'!
test04PortfolioBalanceIsSumOfManagedAccountsBalance

	| account1 account2 complexPortfolio |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	 	
	Deposit register: 100 on: account1.
	Deposit register: 200 on: account2.
		
	self assert:300 = complexPortfolio balance .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 18:53'!
test05PortfolioCanManagePortfolios

	| account1 account2 account3 complexPortfolio composedPortfolio |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	Deposit register: 100 on:account1.
	Deposit register: 200 on: account2.
	Deposit register: 300 on: account3.

	self assert: 600 = composedPortfolio balance .! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/12/2011 13:26'!
test06ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: -50 on: account.
		
	self assert: (account registers: deposit).
	self assert: (account registers: withdraw).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/12/2011 13:26'!
test07ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: -50.
		
	self deny: (account registers: deposit).
	self deny: (account registers:withdraw).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/26/2011 16:51'!
test08PortfolioKnowsTransactionsRegisteredByItsManagedAccounts 

	| account1 account2 account3 complexPortfolio composedPortfolio deposit1 deposit2 deposit3 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	deposit1 := Deposit register: 100 on: account1.
	deposit2 := Deposit register: 200 on: account2.
	deposit3 := Deposit register: 300 on: account3.
		
 	self assert: (composedPortfolio registers: deposit1).
	self assert: (composedPortfolio registers: deposit2).
	self assert: (composedPortfolio registers: deposit3).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/12/2011 13:25'!
test08PortofolioKnowsTransactionsRegisteredByItsManagedAccounts 

	| account1 account2 account3 complexPortfolio composedPortfolio deposit1 deposit2 deposit3 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	deposit1 := Deposit register: 100 on: account1.
	deposit2 := Deposit register: 200 on: account2.
	deposit3 := Deposit register: 300 on: account3.
		
 	self assert: (composedPortfolio registers: deposit1).
	self assert: (composedPortfolio registers: deposit2).
	self assert: (composedPortfolio registers: deposit3).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 19:00'!
test10ReceptiveAccountManageItSelf 

	| account1 |
	account1 := ReceptiveAccount new.
		
	self assert: (account1 manages:account1).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 19:01'!
test11ReceptiveAccountDoNotManageOtherAccount

	| account1 account2 |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
		
	self deny: (account1 manages: account2).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 19:02'!
test12PortfolioManagesComposedAccounts

	| account1 account2 account3 complexPortfolio |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
		
	self assert: (complexPortfolio manages: account1).
	self assert: (complexPortfolio manages: account2).
	self deny: (complexPortfolio manages: account3).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 19:03'!
test13PortfolioManagesComposedAccountsAndPortfolios 

	| account1 account2 account3 complexPortfolio composedPortfolio |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	self assert: (composedPortfolio manages: account1).
	self assert: (composedPortfolio manages: account2).
	self assert: (composedPortfolio manages: account3).
	self assert: (composedPortfolio manages: complexPortfolio).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/26/2011 16:28'!
test14AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on:account1.
		
	self assert: 1=account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/18/2011 17:15'!
test15PortfolioTransactionsIsTheUnionOftsAccountsTransactions 

	| account1 account2 account3 complexPortfolio account composedPortfolio deposit1 deposit2 deposit3 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	deposit1 := Deposit register: 100 on: account1.
	deposit2 := Deposit register: 200 on: account2.
	deposit3 := Deposit register: 300 on: account3.
		
	self assert: 3 = composedPortfolio transactions size .
	self assert: (composedPortfolio transactions includes: deposit1).
	self assert: (composedPortfolio transactions includes: deposit2).
	self assert: (composedPortfolio transactions includes: deposit3).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/12/2011 13:23'!
test16PortfolioKnowsItsAccountsTransactions 

	| account1 account2 account3 complexPortfolio composedPortfolio deposit1 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1= (composedPortfolio transactionsOf:account1) size .
	self assert: ((composedPortfolio transactionsOf: account1) includes:deposit1).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/12/2011 13:23'!
test17PortfolioKnowsItsPortfoliosTransactions 

	| account1 account2 account3 complexPortfolio composedPortfolio deposit1 deposit2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	deposit1 := Deposit register: 100 on: account1.
	deposit2 := Deposit register: 100 on: account2.
	Deposit register: 100 on: account3.
		
	self assert: 2 = (composedPortfolio transactionsOf:complexPortfolio) size .
	self assert: ((composedPortfolio transactionsOf:complexPortfolio) includes:deposit1).
	self assert: ((composedPortfolio transactionsOf:complexPortfolio) includes:deposit2).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/12/2011 13:24'!
test18PortfolioCanNotAnswerTransactionsOfNotManagedAccounts 

	| account1 account2 account3 complexPortfolio |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
		
	self 
		should: [ complexPortfolio transactionsOf:account3 ] 
		raise: Error 
		withExceptionDo: [ :accountNotManaged |
			self assert: Portfolio accountNotManagedMessageDescription = accountNotManaged messageText ]
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 19:28'!
test19CanNotCreatePortfoliosWithRepeatedAccount 

	| account1 |
	account1 := ReceptiveAccount new.
	self 
		should: [ Portfolio with: account1 with: account1 ]
		raise: Error
		withExceptionDo: [ :invalidPortfolio |
			self assert: Portfolio accountAlreadyManagedErrorMessage  = invalidPortfolio messageText ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 19:15'!
test20CanNotCreatePortfoliosWithAccountsManagedByOtherManagedPortfolio 

	| account1 account2 complexPortfolio |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.

	self 
		should: [ Portfolio with: complexPortfolio with: account1 ]
		raise: Error
		withExceptionDo: [ :invalidPortfolio |
			self assert: Portfolio accountAlreadyManagedErrorMessage = invalidPortfolio messageText ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 05:27'!
test21TransferShouldWithdrawFromFromAccountAndDepositIntoToAccount

	| fromAccount toAccount |

	fromAccount := ReceptiveAccount new. 
	toAccount := ReceptiveAccount new.

	Transfer register: 100 from: fromAccount to: toAccount.
		
	self assert: -100 = fromAccount balance.
	self assert:  100 = toAccount balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 8/13/2017 18:37:06'!
test22AccountSummaryShouldProvideHumanReadableTransactionsDetail

	| fromAccount toAccount lines |
	fromAccount := ReceptiveAccount new.
	toAccount := ReceptiveAccount new.

	Deposit register: 100 on: fromAccount.
	Withdraw register: 50 on: fromAccount.
	Transfer register: 100 from: fromAccount to: toAccount.
		
	lines := self accountSummaryLinesOf: fromAccount.
		
	self assert: 3 = lines size.
	self assert: 'Deposito por 100' = (lines at: 1).
	self assert: 'Extraccion por 50' = (lines at: 2).
	self assert: 'Transferencia por -100' = (lines at: 3).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 06:58'!
test23ShouldBeAbleToBeQueryTransferNet

	| fromAccount toAccount |
	fromAccount := ReceptiveAccount new. 
	toAccount := ReceptiveAccount new. 

	Deposit register: 100 on: fromAccount.
	Withdraw register: 50 on: fromAccount.
	Transfer register: 100 from: fromAccount to: toAccount.
	Transfer register: 250 from: toAccount to: fromAccount.
		
	self assert: 150 = (self accountTransferNetOf: fromAccount).
	self assert: -150 = (self accountTransferNetOf: toAccount).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 06:58'!
test24CertificateOfDepositShouldWithdrawInvestmentValue

	| account toAccount |
	account := ReceptiveAccount new. 
	toAccount := ReceptiveAccount new. 

	Deposit register: 1000 on: account.
	Withdraw register: 50 on: account.
	Transfer register: 100 from: account to: toAccount.
	CertificateOfDeposit register: 100 during: 30 at: 1/10 on: account.
		
	self assert: 100 =(self investmentNetOf:account).
	self assert: 750 = account balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 06:58'!
test25ShouldBeAbleToQueryInvestmentEarnings

	| account investmentEarnings |
	account := ReceptiveAccount new. 
		
	CertificateOfDeposit register: 100 during: 30 at: 1/10 on: account.
	CertificateOfDeposit register: 100 during: 60 at: 15/100 on: account.

	investmentEarnings := 
		(100*((1/10)/360)*30) +
		(100*((15/100)/360)*60).
		
	self assert: investmentEarnings = (self investmentEarningsOf: account).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 8/13/2017 18:37:21'!
test26AccountSummaryShouldWorkWithCertificateOfDeposit

	| fromAccount toAccount lines |
	fromAccount := ReceptiveAccount new. 
	toAccount := ReceptiveAccount new. 

	Deposit register: 100 on: fromAccount.
	Withdraw register: 50 on: fromAccount.
	Transfer register: 100 from: fromAccount to: toAccount.
	CertificateOfDeposit register: 1000 during: 30 at: 1/10 on: fromAccount.
		
	lines := self accountSummaryLinesOf: fromAccount.
		
	self assert: 4 = lines size.
	self assert: 'Deposito por 100' =  (lines at: 1).
	self assert: 'Extraccion por 50' =  (lines at: 2).
	self assert: 'Transferencia por -100' = (lines at: 3).
	self assert: 'Plazo fijo por 1000 durante 30 dias a una tna de 10%' = (lines at: 4).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 06:58'!
test27ShouldBeAbleToBeQueryTransferNetWithCertificateOfDeposit

	| fromAccount toAccount |
	fromAccount := ReceptiveAccount new. 
	toAccount := ReceptiveAccount new. 

	Deposit register: 100 on: fromAccount.
	Withdraw register: 50 on: fromAccount.
	Transfer register: 100 from: fromAccount to: toAccount.
	Transfer register: 250 from: toAccount to: fromAccount.
	CertificateOfDeposit register: 1000 during: 30 at: 1/10 on: fromAccount.
		
	self assert: 150 = (self accountTransferNetOf: fromAccount).
	self assert: -150 = (self accountTransferNetOf: toAccount).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/26/2011 16:29'!
test28PortfolioTreePrinterPrintsTheCompositeInDepthFirstOrder

	| account1 account2 account3 complexPortfolio composedPortfolio accountNames lines |
	
	account1 := ReceptiveAccount new. 
	account2 := ReceptiveAccount new. 
	account3 := ReceptiveAccount new. 
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.

	accountNames := Dictionary new.
	accountNames at: composedPortfolio put: 'composedPortfolio'.
	accountNames at: complexPortfolio put: 'complexPortfolio'.
	accountNames at: account1 put: 'account1'.
	accountNames at: account2 put: 'account2'.
	accountNames at: account3 put: 'account3'.
		
	lines := self portofolioTreeOf: composedPortfolio namingAccountWith: accountNames.
		
	self assert: 5 = lines size.
	self assert: 'composedPortfolio' = (lines at: 1).
	self assert: ' complexPortfolio' = (lines at: 2).
	self assert: '  account1' = (lines at: 3).
	self assert: '  account2' = (lines at: 4).
	self assert: ' account3' = (lines at: 5).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/26/2011 16:30'!
test29ReversePortfolioTreePrinterPrintsTheCompositeStartingFromTheLeaves

	| account1 account2 account3 complexPortfolio composedPortfolio accountNames lines |
	account1 := ReceptiveAccount new. 
	account2 := ReceptiveAccount new. 
	account3 := ReceptiveAccount new. 
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.

	accountNames := Dictionary new.
	accountNames at: composedPortfolio put: 'composedPortfolio'.
	accountNames at: complexPortfolio put: 'complexPortfolio'.
	accountNames at: account1 put: 'account1'.
	accountNames at: account2 put: 'account2'.
	accountNames at: account3 put: 'account3'.
		
	lines := self reversePortofolioTreeOf: composedPortfolio namingAccountWith: accountNames.
		
	self assert: 5 = lines size.
	self assert: ' account3' = (lines at: 1).
	self assert: '  account2' = (lines at: 2).
	self assert: '  account1' = (lines at: 3).
	self assert: ' complexPortfolio' = (lines at: 4).
	self assert: 'composedPortfolio' = (lines at: 5).
	! !


!PortfolioTest methodsFor: 'test support' stamp: 'NL 9/28/2017 17:40:30'!
accountSummaryLinesOf: aReceptiveAccount 
	
	| summaryLines |
	summaryLines := SummaryLines new initializeWith: aReceptiveAccount .
	^summaryLines value.! !

!PortfolioTest methodsFor: 'test support' stamp: 'NL 9/28/2017 17:38:48'!
accountTransferNetOf: aReceptiveAccount 
	
	| transferNet |
	transferNet := TransferNet new initializeWith: aReceptiveAccount .
	^transferNet value.! !

!PortfolioTest methodsFor: 'test support' stamp: 'NL 9/28/2017 17:38:04'!
investmentEarningsOf: aReceptiveAccount 
	
	| investmentEarnings |
	investmentEarnings := InvestmentEarnings new initializeWith: aReceptiveAccount .
	^investmentEarnings value.! !

!PortfolioTest methodsFor: 'test support' stamp: 'NL 9/28/2017 17:37:16'!
investmentNetOf: aReceptiveAccount 
	
	| investmentNet |
	investmentNet := InvestmentNet new initializeWith: aReceptiveAccount .
	^investmentNet value.! !

!PortfolioTest methodsFor: 'test support' stamp: 'HernanWilkinson 9/6/2016 19:43'!
portofolioTreeOf: aPortfolio namingAccountWith: aDictionary 
	
	self shouldBeImplemented ! !

!PortfolioTest methodsFor: 'test support' stamp: 'HernanWilkinson 9/6/2016 19:43'!
reversePortofolioTreeOf: aPortfolio namingAccountWith: aDictionary 
	
	self shouldBeImplemented ! !


!classDefinition: #AccountTransaction category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountTransaction methodsFor: 'evaluating' stamp: 'JL 9/25/2017 21:47:26'!
accountSummaryLine
	self subclassResponsibility.! !

!AccountTransaction methodsFor: 'evaluating' stamp: 'JL 9/25/2017 21:05:57'!
affectBalance: aBalance
	self subclassResponsibility.! !

!AccountTransaction methodsFor: 'evaluating' stamp: 'JL 9/27/2017 00:17:30'!
affectTransferNet
	self subclassResponsibility.! !

!AccountTransaction methodsFor: 'evaluating' stamp: 'HernanWilkinson 7/14/2011 06:48'!
value

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #CertificateOfDeposit category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #CertificateOfDeposit
	instanceVariableNames: 'value tna numberOfDays'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!CertificateOfDeposit methodsFor: 'as yet unclassified' stamp: 'NL 9/28/2017 16:53:27'!
accountSummaryLine
	| aPercentage |

	aPercentage := (tna * 100) asNumber.
	^'Plazo fijo por ', value printString, ' durante ', numberOfDays printString, ' dias a una tna de ', aPercentage printString, '%'.! !

!CertificateOfDeposit methodsFor: 'as yet unclassified' stamp: 'NL 9/28/2017 16:29:57'!
affectBalance: aBalance
	^ aBalance - self value.! !

!CertificateOfDeposit methodsFor: 'as yet unclassified' stamp: 'NL 9/28/2017 17:02:28'!
affectInvestmentEarnings: anInvestmentEarnings
	^ anInvestmentEarnings + (value * (tna / 360) * numberOfDays).! !

!CertificateOfDeposit methodsFor: 'as yet unclassified' stamp: 'NL 9/28/2017 16:33:25'!
affectInvestmentNet: anInvestmentNet
	^ anInvestmentNet + self value.! !

!CertificateOfDeposit methodsFor: 'as yet unclassified' stamp: 'NL 9/28/2017 16:30:56'!
affectTransferNet: aTransferNet
	^ aTransferNet.! !

!CertificateOfDeposit methodsFor: 'as yet unclassified' stamp: 'NL 9/28/2017 16:25:10'!
initializeFor: aValue during: aNumberOfDays at: aTNA

	value := aValue.
	tna := aTNA.
	numberOfDays := aNumberOfDays.! !

!CertificateOfDeposit methodsFor: 'as yet unclassified' stamp: 'NL 9/28/2017 16:48:59'!
value
	^value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CertificateOfDeposit class' category: #'PortfolioTreePrinter-Ejercicio'!
CertificateOfDeposit class
	instanceVariableNames: ''!

!CertificateOfDeposit class methodsFor: 'as yet unclassified' stamp: 'NL 9/28/2017 16:25:01'!
register: aValue during: aNumberOfDays at: aTNA on: anAccount
	| aCertificateOfDeposit |
	
	aCertificateOfDeposit :=	self new initializeFor: aValue during: aNumberOfDays at: aTNA.
	
	anAccount register: aCertificateOfDeposit.
	
	^aCertificateOfDeposit.! !


!classDefinition: #Deposit category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'JL 9/25/2017 21:49:03'!
accountSummaryLine
	
	^'Deposito por ', value printString ! !

!Deposit methodsFor: 'value' stamp: 'JL 9/25/2017 21:05:57'!
affectBalance: aBalance
	^ aBalance + self value.! !

!Deposit methodsFor: 'value' stamp: 'NL 9/28/2017 17:02:08'!
affectInvestmentEarnings: anInvestmentEarnings
	^ anInvestmentEarnings.! !

!Deposit methodsFor: 'value' stamp: 'NL 9/28/2017 16:33:09'!
affectInvestmentNet: anInvestmentNet
	^ anInvestmentNet.! !

!Deposit methodsFor: 'value' stamp: 'JL 9/27/2017 00:19:14'!
affectTransferNet: aTransferNet
	^ aTransferNet.! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'PortfolioTreePrinter-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 19:41'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #TransferDeposit category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #TransferDeposit
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'JL 9/25/2017 21:59:35'!
accountSummaryLine
	
	^'Transferencia por ', self value printString ! !

!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'JL 9/25/2017 21:57:38'!
affectBalance: aBalance
	^ aBalance + self value.! !

!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'NL 9/28/2017 17:00:49'!
affectInvestmentEarnings: anInvestmentEarnings
	^ anInvestmentEarnings.! !

!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'NL 9/28/2017 16:32:52'!
affectInvestmentNet: anInvestmentNet
	^ anInvestmentNet.! !

!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'JL 9/27/2017 00:18:34'!
affectTransferNet: aTransferNet
	^ aTransferNet + self value.! !

!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'JL 9/26/2017 23:59:19'!
initializeWithParent: aTransfer

	transfer := aTransfer.
! !

!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'JL 9/26/2017 23:48:31'!
value
	
	^transfer value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferDeposit class' category: #'PortfolioTreePrinter-Ejercicio'!
TransferDeposit class
	instanceVariableNames: ''!

!TransferDeposit class methodsFor: 'as yet unclassified' stamp: 'JL 9/27/2017 00:00:45'!
registerFor: aTransfer on: aToAccount
	| aTransferDeposit |
	
	aTransferDeposit := self new initializeWithParent: aTransfer.
	
	aToAccount register: aTransferDeposit.
	
	^aTransferDeposit.! !


!classDefinition: #TransferWithdraw category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #TransferWithdraw
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'JL 9/25/2017 21:59:18'!
accountSummaryLine
	
	^'Transferencia por ', self value negated printString ! !

!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'JL 9/25/2017 21:57:47'!
affectBalance: aBalance
	^ aBalance - self value.! !

!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'NL 9/28/2017 17:01:29'!
affectInvestmentEarnings: anInvestmentEarnings
	^ anInvestmentEarnings.! !

!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'NL 9/28/2017 16:32:57'!
affectInvestmentNet: anInvestmentNet
	^ anInvestmentNet.! !

!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'JL 9/27/2017 00:18:24'!
affectTransferNet: aTransferNet
	^ aTransferNet - self value.! !

!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'JL 9/27/2017 00:00:00'!
initializeWithParent: aTransfer

	transfer := aTransfer.
! !

!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'JL 9/26/2017 23:48:41'!
value
	
	^transfer value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferWithdraw class' category: #'PortfolioTreePrinter-Ejercicio'!
TransferWithdraw class
	instanceVariableNames: ''!

!TransferWithdraw class methodsFor: 'as yet unclassified' stamp: 'JL 9/27/2017 00:00:22'!
registerFor: aTransfer on: aFromAccount
	| aTransferWithdraw |
	
	aTransferWithdraw := self new initializeWithParent: aTransfer.
	
	aFromAccount register: aTransferWithdraw.
	
	^aTransferWithdraw.! !


!classDefinition: #Withdraw category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/14/2011 05:54'!
value

	^ value ! !


!Withdraw methodsFor: 'as yet unclassified' stamp: 'JL 9/25/2017 21:48:17'!
accountSummaryLine
	
	^'Extraccion por ', value printString ! !

!Withdraw methodsFor: 'as yet unclassified' stamp: 'JL 9/25/2017 21:05:57'!
affectBalance: aBalance
	^ aBalance - self value.! !

!Withdraw methodsFor: 'as yet unclassified' stamp: 'NL 9/28/2017 17:01:54'!
affectInvestmentEarnings: anInvestmentEarnings
	^ anInvestmentEarnings.! !

!Withdraw methodsFor: 'as yet unclassified' stamp: 'NL 9/28/2017 16:32:37'!
affectInvestmentNet: anInvestmentNet
	^ anInvestmentNet.! !

!Withdraw methodsFor: 'as yet unclassified' stamp: 'JL 9/27/2017 00:19:01'!
affectTransferNet: aTransferNet
	^ aTransferNet.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'PortfolioTreePrinter-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/14/2011 05:32'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #ReceptiveAccountMessages category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #ReceptiveAccountMessages
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!ReceptiveAccountMessages methodsFor: 'as yet unclassified' stamp: 'NL 9/28/2017 16:00:13'!
responseConsulta: unaConsulta
	self subclassResponsibility! !


!classDefinition: #InvestmentEarnings category: #'PortfolioTreePrinter-Ejercicio'!
ReceptiveAccountMessages subclass: #InvestmentEarnings
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!InvestmentEarnings methodsFor: 'as yet unclassified' stamp: 'NL 9/28/2017 17:07:40'!
initializeWith: anAccount

	account := anAccount.! !

!InvestmentEarnings methodsFor: 'as yet unclassified' stamp: 'NL 9/28/2017 17:16:40'!
value
	^account transactions 
		inject: 0
		into: [ :balance :transaction |
			transaction affectInvestmentEarnings: balance ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InvestmentEarnings class' category: #'PortfolioTreePrinter-Ejercicio'!
InvestmentEarnings class
	instanceVariableNames: ''!

!InvestmentEarnings class methodsFor: 'as yet unclassified' stamp: 'NL 9/28/2017 17:08:13'!
for: anAccount
	
	^self new initializeWith: anAccount.! !


!classDefinition: #InvestmentNet category: #'PortfolioTreePrinter-Ejercicio'!
ReceptiveAccountMessages subclass: #InvestmentNet
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!InvestmentNet methodsFor: 'as yet unclassified' stamp: 'NL 9/28/2017 15:56:10'!
initializeWith: anAccount

	account := anAccount.! !

!InvestmentNet methodsFor: 'as yet unclassified' stamp: 'NL 9/28/2017 17:17:12'!
value
	^ account transactions
		inject: 0
		into: [ :balance :transaction |
			transaction affectInvestmentNet: balance ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InvestmentNet class' category: #'PortfolioTreePrinter-Ejercicio'!
InvestmentNet class
	instanceVariableNames: ''!

!InvestmentNet class methodsFor: 'as yet unclassified' stamp: 'NL 9/28/2017 15:55:14'!
for: anAccount
	
	^self new initializeWith: anAccount.! !


!classDefinition: #SummaryLines category: #'PortfolioTreePrinter-Ejercicio'!
ReceptiveAccountMessages subclass: #SummaryLines
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!SummaryLines methodsFor: 'as yet unclassified' stamp: 'NL 9/28/2017 15:55:59'!
initializeWith: anAccount

	account := anAccount.! !

!SummaryLines methodsFor: 'as yet unclassified' stamp: 'NL 9/28/2017 17:18:04'!
value
	| lines |
	
	lines := OrderedCollection new.
	account transactions do: [ :aTrx | lines add: aTrx accountSummaryLine ].
	^lines.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SummaryLines class' category: #'PortfolioTreePrinter-Ejercicio'!
SummaryLines class
	instanceVariableNames: ''!

!SummaryLines class methodsFor: 'as yet unclassified' stamp: 'NL 9/28/2017 15:55:06'!
for: anAccount
	
	^self new initializeWith: anAccount.! !


!classDefinition: #TransferNet category: #'PortfolioTreePrinter-Ejercicio'!
ReceptiveAccountMessages subclass: #TransferNet
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TransferNet methodsFor: 'nil' stamp: 'NL 9/28/2017 15:55:52'!
initializeWith: anAccount

	account := anAccount.! !

!TransferNet methodsFor: 'nil' stamp: 'NL 9/28/2017 17:18:30'!
value
	^ account transactions
		inject: 0
		into: [ :balance :transaction |
			transaction affectTransferNet: balance ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNet class' category: #'PortfolioTreePrinter-Ejercicio'!
TransferNet class
	instanceVariableNames: ''!

!TransferNet class methodsFor: 'nil' stamp: 'NL 9/28/2017 15:54:43'!
for: anAccount
	
	^self new initializeWith: anAccount.! !


!classDefinition: #SummarizingAccount category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #SummarizingAccount
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!SummarizingAccount methodsFor: 'testing' stamp: 'HernanWilkinson 7/13/2011 18:34'!
manages: anAccount

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'testing' stamp: 'NL 9/28/2017 16:57:04'!
register: aTransaction

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'testing' stamp: 'HernanWilkinson 7/13/2011 18:34'!
registers: aTransaction

	self subclassResponsibility ! !


!SummarizingAccount methodsFor: 'transactions' stamp: 'JL 9/27/2017 00:20:39'!
accountSummary

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:34'!
balance

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'transactions' stamp: 'NL 9/28/2017 16:55:59'!
investmentEarnings

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'transactions' stamp: 'NL 9/28/2017 16:55:42'!
investmentNet

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:35'!
transactions

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'transactions' stamp: 'JL 9/27/2017 00:20:11'!
transferNet

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: #'PortfolioTreePrinter-Ejercicio'!
SummarizingAccount subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Portfolio methodsFor: 'testing' stamp: 'HernanWilkinson 7/13/2011 19:22'!
manages: anAccount

	^ self = anAccount  or: [ accounts anySatisfy: [ :managedAccount | managedAccount manages: anAccount  ]  ]! !

!Portfolio methodsFor: 'testing' stamp: 'HernanWilkinson 7/13/2011 19:20'!
registers: aTransaction

	^ accounts anySatisfy: [ :anAccount | anAccount registers: aTransaction ]  ! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 8/13/2017 17:47:44'!
balance

	^ accounts sum: [ :account | account balance ]
! !

!Portfolio methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 19:23'!
transactions 

	^ accounts inject: OrderedCollection new into: [ :transactions :account | transactions addAll: account transactions. transactions ]
	! !

!Portfolio methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 19:27'!
transactionsOf: anAccount 

	^ (self manages: anAccount)
		ifTrue: [ anAccount transactions ] 
		ifFalse: [ self error: self class accountNotManagedMessageDescription]
	! !


!Portfolio methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 19:19'!
initializeWithAll: aCollectionOfAccounts

	accounts := aCollectionOfAccounts   ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'PortfolioTreePrinter-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:48'!
with: anAccount1 with: anAccount2

	^ self withAll: (Array with: anAccount1 with: anAccount2 )! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 19:40'!
withAll: aCollectionOfAccounts

	aCollectionOfAccounts asSet size = aCollectionOfAccounts size ifFalse: [ self error: self accountAlreadyManagedErrorMessage  ].
	
	aCollectionOfAccounts do: [ :sourceAccount | 
		aCollectionOfAccounts do: [ :targetAccount | 
			(sourceAccount = targetAccount) not ifTrue: [
				(sourceAccount manages: targetAccount) ifTrue: [ self error: self accountAlreadyManagedErrorMessage ]]]].
	
	^self new initializeWithAll: aCollectionOfAccounts ! !


!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:22'!
check: sourceAccount doesNotManagaAnyOf: aCollectionOfAccounts

	^ aCollectionOfAccounts do: [ :targetAccount | 
			(sourceAccount = targetAccount) not ifTrue: [ 
				(sourceAccount manages: targetAccount) ifTrue: [ self error: self accountAlreadyManagedErrorMessage ] ] ]! !

!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:21'!
checkAccountsAreUnique: aCollectionOfAccounts

	aCollectionOfAccounts asSet size = aCollectionOfAccounts size
		ifFalse: [ self error: self accountAlreadyManagedErrorMessage ]! !

!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:21'!
checkCreationPreconditions: aCollectionOfAccounts

	self checkAccountsAreUnique: aCollectionOfAccounts.
	self checkNoCircularReferencesIn: aCollectionOfAccounts! !

!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:22'!
checkNoCircularReferencesIn: aCollectionOfAccounts

	aCollectionOfAccounts do: [ :sourceAccount | self check: sourceAccount doesNotManagaAnyOf: aCollectionOfAccounts ]! !


!Portfolio class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/13/2011 19:28'!
accountAlreadyManagedErrorMessage

	^ 'Account already managed'! !

!Portfolio class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/13/2011 19:27'!
accountNotManagedMessageDescription
	
	^ 'Account not managed'! !


!classDefinition: #ReceptiveAccount category: #'PortfolioTreePrinter-Ejercicio'!
SummarizingAccount subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'JL 9/25/2017 21:05:57'!
balance
	^ transactions
		inject: 0
		into: [ :balance :transaction |
			transaction affectBalance: balance ].! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'JL 9/27/2017 00:19:40'!
transferNet
	^ transactions
		inject: 0
		into: [ :balance :transaction |
			transaction affectTransferNet: balance ].! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'HernanWilkinson 7/13/2011 18:37'!
manages: anAccount

	^ self = anAccount 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HernanWilkinson 7/13/2011 18:37'!
registers: aTtransaction

	^ transactions includes: aTtransaction 
! !


!classDefinition: #Transfer category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'withdrawLeg depositLeg value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Transfer methodsFor: 'as yet unclassified' stamp: 'JL 9/26/2017 23:50:11'!
initializeFor: aValue from: aFromAccount to: aToAccount

	withdrawLeg := TransferWithdraw registerFor: self on: aFromAccount.
	depositLeg := TransferDeposit registerFor: self on: aToAccount.
	value := aValue.! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'JL 9/25/2017 21:58:17'!
value
	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: #'PortfolioTreePrinter-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'as yet unclassified' stamp: 'JL 9/25/2017 21:33:43'!
register: aValue from: fromAccount to: toAccount 

	^self new initializeFor: aValue from: fromAccount to: toAccount.
! !
