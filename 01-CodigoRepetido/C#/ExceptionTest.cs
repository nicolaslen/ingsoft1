using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace IdiomExercise
{
    public class ExceptionTest
    {
        public static void TryCatchForTesting(Action actionToTry, Action<Exception> catchAction)
        {
            try
            {
                actionToTry();
                Assert.Fail();
            }
            catch (InvalidOperationException e)
            {
                catchAction(e);
            }
            catch (Exception e)
            {
                catchAction(e);
            }
        }

        public static void ThrowCorrectException(Exception exceptionThrown, String exceptionMessageExpected)
        {
            Assert.AreEqual(exceptionThrown.Message, exceptionMessageExpected);
        }
    }
}
