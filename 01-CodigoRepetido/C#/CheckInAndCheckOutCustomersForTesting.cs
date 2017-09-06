using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace IdiomExercise
{
    public class CheckInAndCheckOutCustomersForTesting
    {
        public void AddPaulMcCartneyToCustomerBook(CustomerBook aCustomerBookForTesting)
        {
            String paulMcCartney = "Paul McCartney";
            aCustomerBookForTesting.addCustomerNamed(paulMcCartney);
        }

        public void AddJonhLennonToCustomerBook(CustomerBook aCustomerBookForTesting)
        {
            String johnLennon = "John Lennon";
            aCustomerBookForTesting.addCustomerNamed(johnLennon);
        }

        public void RemovePaulMcCartneyFromCustomerBook(CustomerBook aCustomerBookForTesting)
        {
            String paulMcCartney = "Paul McCartney";
            aCustomerBookForTesting.removeCustomerNamed(paulMcCartney);
        }

        public void RemoveJonhLennonFromCustomerBook(CustomerBook aCustomerBookForTesting)
        {
            String johnLennon = "John Lennon";
            aCustomerBookForTesting.removeCustomerNamed(johnLennon);
        }

        public void AddNoNamedToCustomerBook(CustomerBook aCustomerBookForTesting)
        {
            aCustomerBookForTesting.addCustomerNamed("");
        }
    }
}
