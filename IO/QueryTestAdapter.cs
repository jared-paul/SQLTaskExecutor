namespace TaskPoolExecutor.IO
{
    class QueryTestAdapter
    {
        public string TestName { get; }
        public string Query { get; }

        public QueryTestAdapter(string testName, string query)
        {
            this.TestName = testName;
            this.Query = query;
        }
    }
}
