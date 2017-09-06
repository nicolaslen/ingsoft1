using System;
using System.Text;
using System.Collections.Generic;
using System.Linq;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace IdiomExercise
{
    [TestClass]
    public class Test
    {
        [TestMethod]
        public void AddingCustomerShouldNotTakeMoreThan50Milliseconds()
        {
            CustomerBook aCustomerBook = new CustomerBook();
            CheckInAndCheckOutCustomersForTesting someTest = new CheckInAndCheckOutCustomersForTesting();

            Chronometer chronometer = new Chronometer();
            chronometer.CustomerActionShouldNotTakeMoreThanSomeMilliseconds(aCustomerBook, someTest.AddJonhLennonToCustomerBook, 50);
        }

        [TestMethod]
        public void RemovingCustomerShouldNotTakeMoreThan100Milliseconds()
        {
            CustomerBook aCustomerBook = new CustomerBook();
            CheckInAndCheckOutCustomersForTesting someTest = new CheckInAndCheckOutCustomersForTesting();
            someTest.AddPaulMcCartneyToCustomerBook(aCustomerBook);

            Chronometer chronometer = new Chronometer();
            chronometer.CustomerActionShouldNotTakeMoreThanSomeMilliseconds(aCustomerBook, someTest.RemovePaulMcCartneyFromCustomerBook, 100);
        }

        [TestMethod]
        public void CanNotAddACustomerWithEmptyName()
        {
            CustomerBook aCustomerBook = new CustomerBook();
            CheckInAndCheckOutCustomersForTesting someTest = new CheckInAndCheckOutCustomersForTesting();
            CatchExceptionsForTesting catchingATest = new CatchExceptionsForTesting();
            
            CustomerBookTestingExceptionCatcher.TryCustomerBookActionForTesting(aCustomerBook, someTest.AddNoNamedToCustomerBook, catchingATest.CatchAddingACustomerWithEmptyName);
        }

        [TestMethod]
        public void CanNotRemoveNotAddedCustomer()
        {
            CustomerBook aCustomerBook = new CustomerBook();
            CheckInAndCheckOutCustomersForTesting someTest = new CheckInAndCheckOutCustomersForTesting();
            CatchExceptionsForTesting catchingATest = new CatchExceptionsForTesting();

            CustomerBookTestingExceptionCatcher.TryCustomerBookActionForTesting(aCustomerBook, someTest.RemoveJonhLennonFromCustomerBook, catchingATest.CatchRemovingNotAddedCustomer);
        }
    }
}
