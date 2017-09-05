using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace IdiomExercise
{
    public class ExceptionTest
    {
        public static void TryCatch(Action _try, Action<Exception> _catch)
        {
            try
            {
                _try();
                Assert.Fail();
            }
            catch (InvalidOperationException e)
            {
                _catch(e);
            }
            catch (Exception e)
            {
                _catch(e);
            }
        }

        public static void ThrowCorrectException(Exception exceptionThrown, String exceptionMessageExpected)
        {
            Assert.AreEqual(exceptionThrown.Message, exceptionMessageExpected);
        }
    }
}
