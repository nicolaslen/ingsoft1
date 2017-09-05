using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace IdiomExercise
{
    public class CatchExceptionsForTesting
    {
        public void CatchAddingACustomerWithEmptyName(CustomerBook customerBook, Exception exceptionThrown)
        {
            ExceptionTest.ThrowCorrectException(exceptionThrown, CustomerBook.CUSTOMER_NAME_EMPTY);
            Assert.IsTrue(customerBook.isEmpty());
        }

        public void CatchRemovingNotAddedCustomer(CustomerBook customerBook, Exception exceptionThrown)
        {
            ExceptionTest.ThrowCorrectException(exceptionThrown, CustomerBook.INVALID_CUSTOMER_NAME);
            Assert.AreEqual(0, customerBook.numberOfCustomers());
        }
    }
}
