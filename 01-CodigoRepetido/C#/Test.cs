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
            CustomerBook customerBook = new CustomerBook();
            CheckInAndCheckOutCustomersForTesting someTest = new CheckInAndCheckOutCustomersForTesting();

            Chronometer chronometer = new Chronometer();
            chronometer.CustomerActionShouldNotTakeMoreThanSomeMilliseconds(customerBook, someTest.AddJonhLennonToCustomerBook, 50);
        }

        [TestMethod]
        public void RemovingCustomerShouldNotTakeMoreThan100Milliseconds()
        {
            CustomerBook customerBook = new CustomerBook();
            CheckInAndCheckOutCustomersForTesting someTest = new CheckInAndCheckOutCustomersForTesting();
            someTest.AddPaulMcCartneyToCustomerBook(customerBook);

            Chronometer chronometer = new Chronometer();
            chronometer.CustomerActionShouldNotTakeMoreThanSomeMilliseconds(customerBook, someTest.RemovePaulMcCartneyFromCustomerBook, 100);
        }

        [TestMethod]
        public void CanNotAddACustomerWithEmptyName()
        {
            CustomerBook customerBook = new CustomerBook();
            CatchExceptionsForTesting catchingATest = new CatchExceptionsForTesting();
            Action operation = () => customerBook.addCustomerNamed("");
            Action<Exception> catchOperation = (Exception exceptionThrown) => catchingATest.CatchAddingACustomerWithEmptyName(customerBook, exceptionThrown);

            ExceptionTest.TryCatch(operation, catchOperation);
        }

        [TestMethod]
        public void CanNotRemoveNotAddedCustomer()
        {
            CustomerBook customerBook = new CustomerBook();
            CatchExceptionsForTesting catchingATest = new CatchExceptionsForTesting();
            Action operation = () => customerBook.removeCustomerNamed("John Lennon");
            Action<Exception> catchOperation = (Exception exceptionThrown) => catchingATest.CatchRemovingNotAddedCustomer(customerBook, exceptionThrown);

            ExceptionTest.TryCatch(operation, catchOperation);
        }

        
    }
}
