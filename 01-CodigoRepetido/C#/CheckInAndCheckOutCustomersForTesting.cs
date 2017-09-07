using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace IdiomExercise
{
    public class CheckInAndCheckOutCustomersForTesting
    {
        public void AddPaulMcCartneyToCustomerBook(CustomerBook customerBookForTesting)
        {
            String paulMcCartney = "Paul McCartney";
            customerBookForTesting.addCustomerNamed(paulMcCartney);
        }

        public void AddJonhLennonToCustomerBook(CustomerBook customerBookForTesting)
        {
            String johnLennon = "John Lennon";
            customerBookForTesting.addCustomerNamed(johnLennon);
        }

        public void RemovePaulMcCartneyFromCustomerBook(CustomerBook customerBookForTesting)
        {
            String paulMcCartney = "Paul McCartney";
            customerBookForTesting.removeCustomerNamed(paulMcCartney);
        }

        public void RemoveJonhLennonFromCustomerBook(CustomerBook customerBookForTesting)
        {
            String johnLennon = "John Lennon";
            customerBookForTesting.removeCustomerNamed(johnLennon);
        }

        public void AddNoNamedToCustomerBook(CustomerBook customerBookForTesting)
        {
            customerBookForTesting.addCustomerNamed("");
        }
    }
}
