using System;

namespace IdiomExercise
{
    public class CustomerBookTestingExceptionCatcher : ExceptionsOnTesting
    {
        public static void TryCustomerBookActionForTesting(CustomerBook customerBook, Action<CustomerBook> customerBookActionToTry, Action<CustomerBook, Exception> customerBookActionWhenExceptionIsThrown)
        {
            Action actionToTry = () => customerBookActionToTry(customerBook);
            Action<Exception> catchAction = (Exception e) => customerBookActionWhenExceptionIsThrown(customerBook, e);
            TryCatchForTesting(actionToTry, catchAction);
        }
    }
}
