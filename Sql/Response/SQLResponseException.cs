namespace TaskPoolExecutor.Sql.Response
{
    /// <summary>
    /// Represents a runtime exception thrown by sql
    /// Includes only important common exceptions (timeout)
    /// </summary>
    class SQLResponseException
    {
        public bool TimedOut { get; }

        public SQLResponseException()
        {

        }
    }
}
