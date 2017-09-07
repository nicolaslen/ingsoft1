using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace IdiomExercise
{
    public class Chronometer
    {
        public void CustomerActionShouldNotTakeMoreThanSomeMilliseconds(CustomerBook customerBook, Action<CustomerBook> customberBookAction, int maximumMillisecondsOfCustomerAction)
        {
            DateTime timeBeforeAction = DateTime.Now;
            customberBookAction(customerBook);
            DateTime timeAfterAction = DateTime.Now;
            Assert.IsTrue(timeAfterAction.Subtract(timeBeforeAction).TotalMilliseconds < maximumMillisecondsOfCustomerAction);
        }
    }
}
