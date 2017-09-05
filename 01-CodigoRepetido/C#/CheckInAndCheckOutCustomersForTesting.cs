using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace IdiomExercise
{
    public class CheckInAndCheckOutCustomersForTesting
    {
        public void AddPaulMcCartneyToCustomerBook(CustomerBook customerBook)
        {
            String paulMcCartney = "Paul McCartney";
            customerBook.addCustomerNamed(paulMcCartney);
        }

        public void AddJonhLennonToCustomerBook(CustomerBook customerBook)
        {
            String johnLennon = "John Lennon";
            customerBook.addCustomerNamed(johnLennon);
        }

        public void RemovePaulMcCartneyFromCustomerBook(CustomerBook customerBook)
        {
            String paulMcCartney = "Paul McCartney";
            customerBook.removeCustomerNamed(paulMcCartney);
        }
    }
}
