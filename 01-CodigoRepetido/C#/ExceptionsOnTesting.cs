using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace IdiomExercise
{
    public class ExceptionsOnTesting
    {
        public static void TryCatchForTesting(Action actionToTry, Action<Exception> actionWhenExceptionIsThrown)
        {
            try
            {
                actionToTry();
                Assert.Fail();
            }
            catch (InvalidOperationException e)
            {
                actionWhenExceptionIsThrown(e);
            }
            catch (Exception e)
            {
                actionWhenExceptionIsThrown(e);
            }
        }
    }
}
