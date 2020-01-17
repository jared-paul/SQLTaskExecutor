using System.Collections.Generic;

namespace TaskPoolExecutor.Sql.Response
{
    class SQLResponse
    {
        public List<string> Info { get; }
        public long ExecutionTime { get; }

        public SQLResponse(List<string> info, long executionTime)
        {
            this.Info = info;
            this.ExecutionTime = executionTime;
        }
    }
}
