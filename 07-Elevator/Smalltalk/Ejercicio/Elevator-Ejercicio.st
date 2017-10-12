!classDefinition: #ElevatorEmergency category: #'Elevator-Ejercicio'!
Error subclass: #ElevatorEmergency
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!


!classDefinition: #ElevatorTest category: #'Elevator-Ejercicio'!
TestCase subclass: #ElevatorTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:38'!
test09RequestToGoUpAreEnqueueWhenRequestedWhenCabinIsMoving

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinDoorOpened.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinWaitingForPeople.
	self assert: elevatorController isCabinDoorOpened.! !

!ElevatorTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:39'!
test10CabinDoorStartClosingAfterWaitingForPeople

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinDoorOpened.
	elevatorController waitForPeopleTimedOut.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorClosing.! !

!ElevatorTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:39'!
test11StopsWaitingForPeopleIfCloseDoorIsPressed

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinDoorOpened.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinWaitingForPeople.
	self assert: elevatorController isCabinDoorOpened.

	elevatorController closeCabinDoor.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorClosing.
! !

!ElevatorTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:39'!
test12CloseDoorDoesNothingIfIdle

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController closeCabinDoor.

	self assert: elevatorController isIdle.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpened.! !

!ElevatorTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:40'!
test13CloseDoorDoesNothingWhenCabinIsMoving

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinMoving.
	self assert: elevatorController isCabinDoorClosed.

	elevatorController closeCabinDoor.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinMoving.
	self assert: elevatorController isCabinDoorClosed.! !

!ElevatorTest methodsFor: 'tests 3' stamp: 'HernanWilkinson 7/10/2011 17:40'!
test14CloseDoorDoesNothingWhenOpeningTheDoorToWaitForPeople

	| elevatorController |
	elevatorController := ElevatorController new.
		
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.

	elevatorController closeCabinDoor.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.! !


!ElevatorTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:42'!
test15ElevatorHasToEnterEmergencyIfStoppedAndOtherFloorSensorTurnsOn

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	self 
		should: [ elevatorController cabinOnFloor:0 ]
		raise: ElevatorEmergency 
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = 'Sensor de cabina desincronizado' ]! !

!ElevatorTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:47'!
test16ElevatorHasToEnterEmergencyIfFalling

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	self 
		should: [ elevatorController cabinOnFloor:0 ]
		raise: ElevatorEmergency 
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = 'Sensor de cabina desincronizado'. ]! !

!ElevatorTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:47'!
test17ElevatorHasToEnterEmergencyIfJumpsFloors

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:3.
	elevatorController cabinDoorClosed.
	self 
		should: [ elevatorController cabinOnFloor: 3 ]
		raise: ElevatorEmergency 
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = 'Sensor de cabina desincronizado'. ]! !

!ElevatorTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:48'!
test18ElevatorHasToEnterEmergencyIfDoorClosesAutomatically
	| elevatorController |
	elevatorController := ElevatorController new.
	
	self 
		should: [ elevatorController cabinDoorClosed.]
		raise: ElevatorEmergency 
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = 'Sensor de puerta desincronizado' ]! !

!ElevatorTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:48'!
test19ElevatorHasToEnterEmergencyIfDoorClosedSensorTurnsOnWhenClosed

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	self 
		should: [elevatorController cabinDoorClosed.]
		raise: ElevatorEmergency 
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = 'Sensor de puerta desincronizado'. ]! !

!ElevatorTest methodsFor: 'tests 4' stamp: 'HernanWilkinson 7/10/2011 17:49'!
test20ElevatorHasToEnterEmergencyIfDoorClosesWhenOpening
	| elevatorController |
	elevatorController := ElevatorController new.
		
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.
	self 
		should: [elevatorController cabinDoorClosed.]
		raise: ElevatorEmergency 
		withExceptionDo: [ :elevatorEmergency | self assert: elevatorEmergency messageText = 'Sensor de puerta desincronizado'.]! !


!ElevatorTest methodsFor: 'tests 2' stamp: 'HernanWilkinson 7/10/2011 17:35'!
test06DoorKeepsOpenedWhenOpeningIsRequested

	| elevatorController |
	elevatorController := ElevatorController new.
	
	self assert: elevatorController isCabinDoorOpened.
	
	elevatorController openCabinDoor.

	self assert: elevatorController isCabinDoorOpened.! !

!ElevatorTest methodsFor: 'tests 2' stamp: 'HernanWilkinson 6/16/2014 13:24'!
test07DoorMustBeOpenedWhenCabinIsStoppedAndClosingDoors

	| elevatorController |
	elevatorController := ElevatorController new.

	elevatorController goUpPushedFromFloor:1.
		
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorClosing.
		
	elevatorController openCabinDoor.
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.
! !

!ElevatorTest methodsFor: 'tests 2' stamp: 'HernanWilkinson 7/10/2011 17:36'!
test08CanNotOpenDoorWhenCabinIsMoving

	| elevatorController |
	elevatorController := ElevatorController new.

	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinMoving.
	self assert: elevatorController isCabinDoorClosed.

	elevatorController openCabinDoor.
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinMoving.
	self assert: elevatorController isCabinDoorClosed.! !

!ElevatorTest methodsFor: 'tests 2' stamp: 'HernanWilkinson 7/10/2011 17:51'!
test09DoorKeepsOpeneingWhenItIsOpeneing

	| elevatorController |
	elevatorController := ElevatorController new.

	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:1.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.

	elevatorController openCabinDoor.
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.! !


!ElevatorTest methodsFor: 'tests 5' stamp: 'HernanWilkinson 7/10/2011 17:50'!
test21CabinHasToStopOnTheFloorsOnItsWay
	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinOnFloor:1.

	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.! !

!ElevatorTest methodsFor: 'tests 5' stamp: 'HernanWilkinson 7/10/2011 17:50'!
test22ElevatorCompletesAllTheRequests
	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinOnFloor:1.
	elevatorController cabinDoorOpened.
	elevatorController waitForPeopleTimedOut.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor:2.
	
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.! !

!ElevatorTest methodsFor: 'tests 5' stamp: 'HernanWilkinson 7/10/2011 17:50'!
test23CabinHasToStopOnFloorsOnItsWayNoMatterHowTheyWellCalled

	| elevatorController |
	elevatorController := ElevatorController new.
		
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinDoorClosed.
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinOnFloor:1.
		
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpening.! !

!ElevatorTest methodsFor: 'tests 5' stamp: 'HernanWilkinson 7/10/2011 17:51'!
test24CabinHasToStopAndWaitForPeopleOnFloorsOnItsWayNoMatterHowTheyWellCalled

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor:2.
	elevatorController cabinDoorClosed.
	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinOnFloor:1.
	elevatorController cabinDoorOpened.
	elevatorController waitForPeopleTimedOut.
	
	self assert: elevatorController isWorking.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorClosing.! !


!ElevatorTest methodsFor: 'tests 1' stamp: 'JL 10/12/2017 10:29:11'!
test01ElevatorStartsIdleWithDoorOpenOnFloorZero

	| elevatorController |
		
	elevatorController := ElevatorController new.
		
	self assert: elevatorController isIdle.
	self assert: elevatorController isCabinStopped.
	self assert: elevatorController isCabinDoorOpened.
	self assert: elevatorController cabinFloorNumber = 0
! !

!ElevatorTest methodsFor: 'tests 1' stamp: 'HernanWilkinson 7/15/2011 17:53'!
test02CabinDoorStartsClosingWhenElevatorGetsCalled

	| elevatorController |
	elevatorController := ElevatorController new.

	elevatorController goUpPushedFromFloor: 1.
	
	self deny: elevatorController isIdle.
	self assert: elevatorController isWorking.
	
	self assert: elevatorController isCabinStopped.
	self deny: elevatorController isCabinMoving.
	
	self deny: elevatorController isCabinDoorOpened.
	self deny: elevatorController isCabinDoorOpening.
	self assert: elevatorController isCabinDoorClosing.
	self deny: elevatorController isCabinDoorClosed.! !

!ElevatorTest methodsFor: 'tests 1' stamp: 'HernanWilkinson 7/15/2011 17:57'!
test03CabinStartsMovingWhenDoorGetsClosed

	| elevatorController |
	elevatorController := ElevatorController new.

	elevatorController goUpPushedFromFloor:1.
	elevatorController cabinDoorClosed.
	
	self deny: elevatorController isIdle.
	self assert: elevatorController isWorking.

	self deny: elevatorController isCabinStopped.
	self assert: elevatorController isCabinMoving.
	
	self deny: elevatorController isCabinDoorOpened.
	self deny: elevatorController isCabinDoorOpening.
	self deny: elevatorController isCabinDoorClosing.
	self assert: elevatorController isCabinDoorClosed.! !

!ElevatorTest methodsFor: 'tests 1' stamp: 'HernanWilkinson 7/15/2011 18:00'!
test04CabinStopsAndStartsOpeningDoorWhenGetsToDestination

	| elevatorController |
	elevatorController := ElevatorController new.

	elevatorController goUpPushedFromFloor: 1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor: 1.

	self deny: elevatorController isIdle.
	self assert: elevatorController isWorking.
	
	self assert: elevatorController isCabinStopped.
	self deny: elevatorController isCabinMoving.
			
	self deny: elevatorController isCabinDoorOpened.
	self assert: elevatorController isCabinDoorOpening.
	self deny: elevatorController isCabinDoorClosing.
	self deny: elevatorController isCabinDoorClosed.

	self assert: elevatorController cabinFloorNumber = 1
! !

!ElevatorTest methodsFor: 'tests 1' stamp: 'HernanWilkinson 7/15/2011 18:00'!
test05ElevatorGetsIdleWhenDoorGetOpened

	| elevatorController |
	elevatorController := ElevatorController new.
	
	elevatorController goUpPushedFromFloor: 1.
	elevatorController cabinDoorClosed.
	elevatorController cabinOnFloor: 1.
	elevatorController cabinDoorOpened.
		
	self assert: elevatorController isIdle.
	self deny: elevatorController isWorking.
		
	self assert: elevatorController isCabinStopped.
	self deny: elevatorController isCabinMoving.

	self assert: elevatorController isCabinDoorOpened.
	self deny: elevatorController isCabinDoorOpening.
	self deny: elevatorController isCabinDoorClosing.
	self deny: elevatorController isCabinDoorClosed.
		
	self assert: elevatorController cabinFloorNumber = 1! !


!classDefinition: #ElevatorCabin category: #'Elevator-Ejercicio'!
Object subclass: #ElevatorCabin
	instanceVariableNames: 'state cabinDoor currentFloor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorCabin methodsFor: 'as yet unclassified' stamp: 'JL 10/12/2017 10:34:39'!
cabinFloorNumber

	^currentFloor.! !

!ElevatorCabin methodsFor: 'as yet unclassified' stamp: 'JL 10/12/2017 16:12:13'!
closeCabinDoorWhenWorking

	cabinDoor closeCabinDoorWhenWorking! !

!ElevatorCabin methodsFor: 'as yet unclassified' stamp: 'JL 10/12/2017 11:12:40'!
closedDoor

	cabinDoor closedDoor! !

!ElevatorCabin methodsFor: 'as yet unclassified' stamp: 'JL 10/11/2017 20:18:28'!
closingDoor

	cabinDoor closingDoor! !

!ElevatorCabin methodsFor: 'as yet unclassified' stamp: 'JL 10/11/2017 20:00:53'!
initialize

	state := (ElevatorCabinStateStopped new).
	cabinDoor := (ElevatorDoor new).
	currentFloor := 0! !

!ElevatorCabin methodsFor: 'as yet unclassified' stamp: 'JL 10/11/2017 18:51:07'!
isDoorStateClosed

	^cabinDoor isClosed! !

!ElevatorCabin methodsFor: 'as yet unclassified' stamp: 'JL 10/11/2017 18:51:16'!
isDoorStateClosing

	^cabinDoor isClosing! !

!ElevatorCabin methodsFor: 'as yet unclassified' stamp: 'JL 10/11/2017 18:51:28'!
isDoorStateOpened

	^cabinDoor isOpened! !

!ElevatorCabin methodsFor: 'as yet unclassified' stamp: 'JL 10/11/2017 18:51:34'!
isDoorStateOpening

	^cabinDoor isOpening! !

!ElevatorCabin methodsFor: 'as yet unclassified' stamp: 'JL 10/11/2017 18:25:31'!
isMoving

	^state isMoving! !

!ElevatorCabin methodsFor: 'as yet unclassified' stamp: 'JL 10/11/2017 18:25:15'!
isStopped

	^state isStopped! !

!ElevatorCabin methodsFor: 'as yet unclassified' stamp: 'JL 10/12/2017 11:06:23'!
movingCabin

	state := ElevatorCabinStateMoving new.! !

!ElevatorCabin methodsFor: 'as yet unclassified' stamp: 'JL 10/12/2017 16:26:31'!
openCabinDoor

	^state openCabinDoorFor: self! !

!ElevatorCabin methodsFor: 'as yet unclassified' stamp: 'JL 10/12/2017 16:27:35'!
openCabinDoorWhenMoving! !

!ElevatorCabin methodsFor: 'as yet unclassified' stamp: 'JL 10/12/2017 16:27:56'!
openCabinDoorWhenStopped

	cabinDoor openCabinDoorWhenStopped! !

!ElevatorCabin methodsFor: 'as yet unclassified' stamp: 'JL 10/12/2017 11:42:15'!
openedDoor

	cabinDoor openedDoor! !

!ElevatorCabin methodsFor: 'as yet unclassified' stamp: 'JL 10/12/2017 11:41:34'!
openingDoor

	cabinDoor openingDoor! !

!ElevatorCabin methodsFor: 'as yet unclassified' stamp: 'JL 10/12/2017 11:40:54'!
stoppedCabin

	state := ElevatorCabinStateStopped new.! !

!ElevatorCabin methodsFor: 'as yet unclassified' stamp: 'JL 10/12/2017 11:43:36'!
updateCabinFloorNumber: aFloor

	currentFloor := aFloor.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ElevatorCabin class' category: #'Elevator-Ejercicio'!
ElevatorCabin class
	instanceVariableNames: ''!

!ElevatorCabin class methodsFor: 'as yet unclassified' stamp: 'JL 10/11/2017 19:20:38'!
new
	^ super new initialize.! !


!classDefinition: #ElevatorCabinState category: #'Elevator-Ejercicio'!
Object subclass: #ElevatorCabinState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorCabinState methodsFor: 'as yet unclassified' stamp: 'JL 10/11/2017 18:26:20'!
isMoving
	^ self subclassResponsibility.! !

!ElevatorCabinState methodsFor: 'as yet unclassified' stamp: 'JL 10/11/2017 18:26:50'!
isStopped
	^ self subclassResponsibility.! !

!ElevatorCabinState methodsFor: 'as yet unclassified' stamp: 'JL 10/12/2017 16:26:48'!
openCabinDoorFor: aCabin
	^ self subclassResponsibility.! !


!classDefinition: #ElevatorCabinStateMoving category: #'Elevator-Ejercicio'!
ElevatorCabinState subclass: #ElevatorCabinStateMoving
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorCabinStateMoving methodsFor: 'as yet unclassified' stamp: 'JL 10/11/2017 18:27:13'!
isMoving
	^ true.! !

!ElevatorCabinStateMoving methodsFor: 'as yet unclassified' stamp: 'JL 10/11/2017 18:27:30'!
isStopped
	^ false.! !

!ElevatorCabinStateMoving methodsFor: 'as yet unclassified' stamp: 'JL 10/12/2017 16:27:09'!
openCabinDoorFor: aCabin
	aCabin openCabinDoorWhenMoving! !


!classDefinition: #ElevatorCabinStateStopped category: #'Elevator-Ejercicio'!
ElevatorCabinState subclass: #ElevatorCabinStateStopped
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorCabinStateStopped methodsFor: 'as yet unclassified' stamp: 'JL 10/11/2017 18:27:59'!
isMoving
	^ false.! !

!ElevatorCabinStateStopped methodsFor: 'as yet unclassified' stamp: 'JL 10/11/2017 18:28:17'!
isStopped
	^ true.! !

!ElevatorCabinStateStopped methodsFor: 'as yet unclassified' stamp: 'JL 10/12/2017 16:27:19'!
openCabinDoorFor: aCabin
	aCabin openCabinDoorWhenStopped! !


!classDefinition: #ElevatorController category: #'Elevator-Ejercicio'!
Object subclass: #ElevatorController
	instanceVariableNames: 'state cabin floorsToGo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'JL 10/12/2017 14:25:09'!
cabinDoorClosed
	
	(floorsToGo isEmpty) ifTrue: [ElevatorEmergency signal: 'Sensor de puerta desincronizado'].
	
	cabin closedDoor.
	cabin movingCabin.
	! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'JL 10/12/2017 11:54:27'!
cabinDoorOpened
	
	floorsToGo isEmpty ifTrue: [state := ElevatorControllerStateIdle new].
	cabin stoppedCabin.
	cabin openedDoor.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'JL 10/12/2017 10:33:55'!
cabinFloorNumber

	^cabin cabinFloorNumber.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'JL 10/12/2017 16:37:46'!
cabinOnFloor: aFloor

	(floorsToGo isEmpty or: [aFloor ~~ ((cabin cabinFloorNumber) + 1)]) ifTrue: [ElevatorEmergency signal: 'Sensor de cabina desincronizado']. 

	(floorsToGo includes: aFloor) ifTrue: [
	cabin stoppedCabin.
	cabin openingDoor.
	floorsToGo remove: aFloor.
	].

	cabin updateCabinFloorNumber: aFloor.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'JL 10/12/2017 16:22:54'!
closeCabinDoor
	
	state closeCabinDoorFor: self! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'JL 10/12/2017 14:41:08'!
closeCabinDoorWhenIdle
	! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'JL 10/12/2017 16:11:26'!
closeCabinDoorWhenWorking
	
	(floorsToGo isEmpty not) ifTrue: [cabin closeCabinDoorWhenWorking]! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'JL 10/11/2017 20:16:05'!
goUpPushedFromFloor: aFloor
	floorsToGo add: aFloor. 
	state := ElevatorControllerStateWorking new.
	cabin closingDoor! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'JL 10/11/2017 20:01:52'!
installNewElevator

	state := ElevatorControllerStateIdle new.
	cabin := ElevatorCabin new.
	floorsToGo := OrderedCollection new.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'JL 10/11/2017 18:47:24'!
isCabinDoorClosed
	^cabin isDoorStateClosed.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'JL 10/11/2017 18:47:43'!
isCabinDoorClosing
	^cabin isDoorStateClosing.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'JL 10/11/2017 18:47:56'!
isCabinDoorOpened
	^cabin isDoorStateOpened.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'JL 10/11/2017 18:48:06'!
isCabinDoorOpening
	^cabin isDoorStateOpening.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'JL 10/11/2017 18:23:19'!
isCabinMoving
	^cabin isMoving.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'JL 10/11/2017 18:23:41'!
isCabinStopped
	^cabin isStopped.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'JL 10/2/2017 19:04:01'!
isCabinWaitingForPeople
	
	^self isCabinDoorOpened and: (floorsToGo isEmpty not).! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'JL 10/11/2017 18:12:10'!
isIdle
	^state isIdle.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'JL 10/11/2017 18:12:25'!
isWorking
	^state isWorking.! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'JL 10/12/2017 16:25:57'!
openCabinDoor

	cabin openCabinDoor! !

!ElevatorController methodsFor: 'as yet unclassified' stamp: 'JL 10/12/2017 11:57:07'!
waitForPeopleTimedOut
	
	cabin closingDoor.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ElevatorController class' category: #'Elevator-Ejercicio'!
ElevatorController class
	instanceVariableNames: ''!

!ElevatorController class methodsFor: 'as yet unclassified' stamp: 'JL 10/1/2017 19:55:41'!
new

	^super new installNewElevator.! !


!classDefinition: #ElevatorControllerState category: #'Elevator-Ejercicio'!
Object subclass: #ElevatorControllerState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorControllerState methodsFor: 'as yet unclassified' stamp: 'JL 10/12/2017 14:44:29'!
closeCabinDoorFor: anElevatorController
	self subclassResponsibility ! !

!ElevatorControllerState methodsFor: 'as yet unclassified' stamp: 'JL 10/2/2017 21:25:45'!
isIdle
	self subclassResponsibility ! !

!ElevatorControllerState methodsFor: 'as yet unclassified' stamp: 'JL 10/2/2017 21:25:50'!
isWorking
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ElevatorControllerState class' category: #'Elevator-Ejercicio'!
ElevatorControllerState class
	instanceVariableNames: ''!

!ElevatorControllerState class methodsFor: 'as yet unclassified' stamp: 'JL 10/2/2017 21:21:08'!
isIdle
	self subclassResponsibility ! !

!ElevatorControllerState class methodsFor: 'as yet unclassified' stamp: 'JL 10/2/2017 21:21:11'!
isWorking
	self subclassResponsibility ! !


!classDefinition: #ElevatorControllerStateIdle category: #'Elevator-Ejercicio'!
ElevatorControllerState subclass: #ElevatorControllerStateIdle
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorControllerStateIdle methodsFor: 'as yet unclassified' stamp: 'JL 10/12/2017 14:43:21'!
closeCabinDoorFor: anElevatorController

	anElevatorController closeCabinDoorWhenIdle! !

!ElevatorControllerStateIdle methodsFor: 'as yet unclassified' stamp: 'JL 10/2/2017 21:26:02'!
isIdle
	^true! !

!ElevatorControllerStateIdle methodsFor: 'as yet unclassified' stamp: 'JL 10/2/2017 21:26:07'!
isWorking
	^false! !


!classDefinition: #ElevatorControllerStateWorking category: #'Elevator-Ejercicio'!
ElevatorControllerState subclass: #ElevatorControllerStateWorking
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorControllerStateWorking methodsFor: 'as yet unclassified' stamp: 'JL 10/12/2017 14:44:08'!
closeCabinDoorFor: anElevatorController

	anElevatorController closeCabinDoorWhenWorking! !

!ElevatorControllerStateWorking methodsFor: 'as yet unclassified' stamp: 'JL 10/2/2017 21:26:22'!
isIdle
	^false! !

!ElevatorControllerStateWorking methodsFor: 'as yet unclassified' stamp: 'JL 10/2/2017 21:26:27'!
isWorking
	^true! !


!classDefinition: #ElevatorDoor category: #'Elevator-Ejercicio'!
Object subclass: #ElevatorDoor
	instanceVariableNames: 'state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorDoor methodsFor: 'as yet unclassified' stamp: 'JL 10/12/2017 16:13:44'!
closeCabinDoorWhenWorking

	state closeCabinDoorWhenWorkingFor: self
! !

!ElevatorDoor methodsFor: 'as yet unclassified' stamp: 'JL 10/12/2017 16:18:17'!
closeCabinDoorWhenWorkingAndClosed
! !

!ElevatorDoor methodsFor: 'as yet unclassified' stamp: 'JL 10/12/2017 16:18:18'!
closeCabinDoorWhenWorkingAndClosing
! !

!ElevatorDoor methodsFor: 'as yet unclassified' stamp: 'JL 10/12/2017 16:19:25'!
closeCabinDoorWhenWorkingAndOpened

	self closingDoor! !

!ElevatorDoor methodsFor: 'as yet unclassified' stamp: 'JL 10/12/2017 16:18:14'!
closeCabinDoorWhenWorkingAndOpening
! !

!ElevatorDoor methodsFor: 'as yet unclassified' stamp: 'JL 10/12/2017 14:19:11'!
closedDoor

	state closedDoorFor: self
! !

!ElevatorDoor methodsFor: 'as yet unclassified' stamp: 'JL 10/12/2017 14:24:09'!
closedDoorWhenClosed

	ElevatorEmergency signal: 'Sensor de puerta desincronizado'! !

!ElevatorDoor methodsFor: 'as yet unclassified' stamp: 'JL 10/12/2017 14:19:49'!
closedDoorWhenClosing

	state := ElevatorDoorStateClosed new! !

!ElevatorDoor methodsFor: 'as yet unclassified' stamp: 'JL 10/12/2017 14:20:05'!
closedDoorWhenOpened

	state := ElevatorDoorStateClosed new! !

!ElevatorDoor methodsFor: 'as yet unclassified' stamp: 'JL 10/12/2017 14:20:18'!
closedDoorWhenOpening

	state := ElevatorDoorStateClosed new! !

!ElevatorDoor methodsFor: 'as yet unclassified' stamp: 'JL 10/11/2017 20:24:42'!
closingDoor

	state := ElevatorDoorStateClosing new! !

!ElevatorDoor methodsFor: 'as yet unclassified' stamp: 'JL 10/11/2017 19:27:01'!
initialize

	state := ElevatorDoorStateOpened new! !

!ElevatorDoor methodsFor: 'as yet unclassified' stamp: 'JL 10/11/2017 18:34:37'!
isClosed

	^state isClosed! !

!ElevatorDoor methodsFor: 'as yet unclassified' stamp: 'JL 10/11/2017 18:34:45'!
isClosing

	^state isClosing! !

!ElevatorDoor methodsFor: 'as yet unclassified' stamp: 'JL 10/11/2017 18:34:56'!
isOpened

	^state isOpened! !

!ElevatorDoor methodsFor: 'as yet unclassified' stamp: 'JL 10/11/2017 18:35:08'!
isOpening

	^state isOpening! !

!ElevatorDoor methodsFor: 'as yet unclassified' stamp: 'JL 10/12/2017 16:28:19'!
openCabinDoorWhenStopped

	state openCabinDoorWhenStoppedFor: self! !

!ElevatorDoor methodsFor: 'as yet unclassified' stamp: 'JL 10/12/2017 16:30:07'!
openCabinDoorWhenStoppedAndClosed! !

!ElevatorDoor methodsFor: 'as yet unclassified' stamp: 'JL 10/12/2017 16:31:12'!
openCabinDoorWhenStoppedAndClosing

	self openingDoor! !

!ElevatorDoor methodsFor: 'as yet unclassified' stamp: 'JL 10/12/2017 16:30:04'!
openCabinDoorWhenStoppedAndOpened! !

!ElevatorDoor methodsFor: 'as yet unclassified' stamp: 'JL 10/12/2017 16:30:01'!
openCabinDoorWhenStoppedAndOpening! !

!ElevatorDoor methodsFor: 'as yet unclassified' stamp: 'JL 10/12/2017 11:41:57'!
openedDoor

	state := ElevatorDoorStateOpened new! !

!ElevatorDoor methodsFor: 'as yet unclassified' stamp: 'JL 10/12/2017 11:41:48'!
openingDoor

	state := ElevatorDoorStateOpening new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ElevatorDoor class' category: #'Elevator-Ejercicio'!
ElevatorDoor class
	instanceVariableNames: ''!

!ElevatorDoor class methodsFor: 'as yet unclassified' stamp: 'JL 10/11/2017 19:20:29'!
new
	^ super new initialize.! !


!classDefinition: #ElevatorDoorState category: #'Elevator-Ejercicio'!
Object subclass: #ElevatorDoorState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorDoorState methodsFor: 'as yet unclassified' stamp: 'JL 10/12/2017 16:17:54'!
closeCabinDoorWhenWorkingFor: aDoor
	self subclassResponsibility.! !

!ElevatorDoorState methodsFor: 'as yet unclassified' stamp: 'JL 10/12/2017 16:18:01'!
closedDoorFor: aDoor
	self subclassResponsibility.! !

!ElevatorDoorState methodsFor: 'as yet unclassified' stamp: 'JL 10/11/2017 18:31:37'!
isClosed
	self subclassResponsibility.! !

!ElevatorDoorState methodsFor: 'as yet unclassified' stamp: 'JL 10/11/2017 18:30:39'!
isClosing
	self subclassResponsibility.! !

!ElevatorDoorState methodsFor: 'as yet unclassified' stamp: 'JL 10/11/2017 18:30:14'!
isOpened
	self subclassResponsibility.! !

!ElevatorDoorState methodsFor: 'as yet unclassified' stamp: 'JL 10/11/2017 18:33:05'!
isOpening
	self subclassResponsibility.! !

!ElevatorDoorState methodsFor: 'as yet unclassified' stamp: 'JL 10/12/2017 16:28:39'!
openCabinDoorWhenStoppedFor: aDoor
	self subclassResponsibility.! !


!classDefinition: #ElevatorDoorStateClosed category: #'Elevator-Ejercicio'!
ElevatorDoorState subclass: #ElevatorDoorStateClosed
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorDoorStateClosed methodsFor: 'as yet unclassified' stamp: 'JL 10/12/2017 16:16:17'!
closeCabinDoorWhenWorkingFor: aDoor
	
	aDoor closeCabinDoorWhenWorkingAndClosed! !

!ElevatorDoorStateClosed methodsFor: 'as yet unclassified' stamp: 'JL 10/12/2017 16:16:25'!
closedDoorFor: aDoor
	
	aDoor closedDoorWhenClosed! !

!ElevatorDoorStateClosed methodsFor: 'as yet unclassified' stamp: 'JL 10/11/2017 18:31:37'!
isClosed
	^ true.! !

!ElevatorDoorStateClosed methodsFor: 'as yet unclassified' stamp: 'JL 10/11/2017 18:30:39'!
isClosing
	^ false.! !

!ElevatorDoorStateClosed methodsFor: 'as yet unclassified' stamp: 'JL 10/11/2017 18:30:14'!
isOpened
	^ false.! !

!ElevatorDoorStateClosed methodsFor: 'as yet unclassified' stamp: 'JL 10/11/2017 18:33:05'!
isOpening
	^ false.! !

!ElevatorDoorStateClosed methodsFor: 'as yet unclassified' stamp: 'JL 10/12/2017 16:29:20'!
openCabinDoorWhenStoppedFor: aDoor
	
	aDoor openCabinDoorWhenStoppedAndClosed! !


!classDefinition: #ElevatorDoorStateClosing category: #'Elevator-Ejercicio'!
ElevatorDoorState subclass: #ElevatorDoorStateClosing
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorDoorStateClosing methodsFor: 'as yet unclassified' stamp: 'JL 10/12/2017 16:17:20'!
closeCabinDoorWhenWorkingFor: aDoor
	
	aDoor closeCabinDoorWhenWorkingAndClosing! !

!ElevatorDoorStateClosing methodsFor: 'as yet unclassified' stamp: 'JL 10/12/2017 16:16:34'!
closedDoorFor: aDoor
	
	aDoor closedDoorWhenClosing! !

!ElevatorDoorStateClosing methodsFor: 'as yet unclassified' stamp: 'JL 10/11/2017 18:31:37'!
isClosed
	^ false.! !

!ElevatorDoorStateClosing methodsFor: 'as yet unclassified' stamp: 'JL 10/11/2017 18:30:39'!
isClosing
	^ true.! !

!ElevatorDoorStateClosing methodsFor: 'as yet unclassified' stamp: 'JL 10/11/2017 18:30:14'!
isOpened
	^ false.! !

!ElevatorDoorStateClosing methodsFor: 'as yet unclassified' stamp: 'JL 10/11/2017 18:33:05'!
isOpening
	^ false.! !

!ElevatorDoorStateClosing methodsFor: 'as yet unclassified' stamp: 'JL 10/12/2017 16:29:31'!
openCabinDoorWhenStoppedFor: aDoor
	
	aDoor openCabinDoorWhenStoppedAndClosing! !


!classDefinition: #ElevatorDoorStateOpened category: #'Elevator-Ejercicio'!
ElevatorDoorState subclass: #ElevatorDoorStateOpened
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorDoorStateOpened methodsFor: 'as yet unclassified' stamp: 'JL 10/12/2017 16:16:52'!
closeCabinDoorWhenWorkingFor: aDoor
	
	aDoor closeCabinDoorWhenWorkingAndOpened! !

!ElevatorDoorStateOpened methodsFor: 'as yet unclassified' stamp: 'JL 10/12/2017 16:16:42'!
closedDoorFor: aDoor
	
	aDoor closedDoorWhenOpened! !

!ElevatorDoorStateOpened methodsFor: 'as yet unclassified' stamp: 'JL 10/11/2017 18:31:37'!
isClosed
	^ false.! !

!ElevatorDoorStateOpened methodsFor: 'as yet unclassified' stamp: 'JL 10/11/2017 18:30:39'!
isClosing
	^ false.! !

!ElevatorDoorStateOpened methodsFor: 'as yet unclassified' stamp: 'JL 10/11/2017 18:30:14'!
isOpened
	^ true.! !

!ElevatorDoorStateOpened methodsFor: 'as yet unclassified' stamp: 'JL 10/11/2017 18:33:05'!
isOpening
	^ false.! !

!ElevatorDoorStateOpened methodsFor: 'as yet unclassified' stamp: 'JL 10/12/2017 16:29:39'!
openCabinDoorWhenStoppedFor: aDoor
	
	aDoor openCabinDoorWhenStoppedAndOpened! !


!classDefinition: #ElevatorDoorStateOpening category: #'Elevator-Ejercicio'!
ElevatorDoorState subclass: #ElevatorDoorStateOpening
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Elevator-Ejercicio'!

!ElevatorDoorStateOpening methodsFor: 'as yet unclassified' stamp: 'JL 10/12/2017 16:17:02'!
closeCabinDoorWhenWorkingFor: aDoor
	
	aDoor closeCabinDoorWhenWorkingAndOpening! !

!ElevatorDoorStateOpening methodsFor: 'as yet unclassified' stamp: 'JL 10/12/2017 16:17:08'!
closedDoorFor: aDoor
	
	aDoor closedDoorWhenOpening! !

!ElevatorDoorStateOpening methodsFor: 'as yet unclassified' stamp: 'JL 10/11/2017 18:31:37'!
isClosed
	^ false.! !

!ElevatorDoorStateOpening methodsFor: 'as yet unclassified' stamp: 'JL 10/11/2017 18:30:39'!
isClosing
	^ false.! !

!ElevatorDoorStateOpening methodsFor: 'as yet unclassified' stamp: 'JL 10/11/2017 18:30:14'!
isOpened
	^ false.! !

!ElevatorDoorStateOpening methodsFor: 'as yet unclassified' stamp: 'JL 10/11/2017 18:33:05'!
isOpening
	^ true.! !

!ElevatorDoorStateOpening methodsFor: 'as yet unclassified' stamp: 'JL 10/12/2017 16:29:47'!
openCabinDoorWhenStoppedFor: aDoor
	
	aDoor openCabinDoorWhenStoppedAndOpening! !
