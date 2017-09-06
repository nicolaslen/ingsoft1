using System;

namespace IdiomExercise
{
    public class CustomerBookTestingExceptionCatcher : ExceptionTest
    {
        public static void TryCustomerBookActionForTesting(CustomerBook customerBook, Action<CustomerBook> customerBookActionToTry, Action<CustomerBook, Exception> customerBookActionWhenCatchException)
        {
            Action actionToTry = () => customerBookActionToTry(customerBook);
            Action<Exception> catchAction = (Exception e) => customerBookActionWhenCatchException.Invoke(customerBook, e);
            TryCatchForTesting(actionToTry, catchAction);
        }
    }
}
