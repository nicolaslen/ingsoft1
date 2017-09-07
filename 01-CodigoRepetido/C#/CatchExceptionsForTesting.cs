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
            ThrowCorrectException(exceptionThrown, CustomerBook.CUSTOMER_NAME_EMPTY);
            CheckIfCustomerBookIsEmpty(customerBook);
        }

        public void CatchRemovingNotAddedCustomer(CustomerBook customerBook, Exception exceptionThrown)
        {
            ThrowCorrectException(exceptionThrown, CustomerBook.INVALID_CUSTOMER_NAME);
            CheckIfCustomerBookIsEmpty(customerBook);
        }
        
        public void ThrowCorrectException(Exception exceptionThrown, String exceptionMessageExpected)
        {
            Assert.AreEqual(exceptionThrown.Message, exceptionMessageExpected);
        }

        public void CheckIfCustomerBookIsEmpty(CustomerBook customerBook)
        {
            Assert.IsTrue(customerBook.isEmpty());
        }
    }
}
