using System;
using System.Threading.Tasks;
using TaskExecutor.Sql;
using TaskPoolExecutor.Sql.Response;

namespace TaskPoolExecutor.Sql.Service
{
    class QueryServiceWrapper
    {
        private Database database;

        public QueryServiceWrapper(Database database)
        {
            this.database = database;
        }

        public async Task<SQLResponse> ExecuteQueryAsync(string query)
        {
            return await new QueryService(database, query).ExecuteQueryAsync();
        }

        public SQLResponse ExecuteQuerySync(string query)
        {
            return new QueryService(database, query).ExecuteQuerySync();
        }

        public void ClearCacheSync(bool log)
        {
            if (log)
            {
                Console.WriteLine("Clearing database cache...");
                database.ClearCacheSync();
                Console.WriteLine("Done clearing database cache!");
            }
            else
            {
                database.ClearCacheSync();
            }
        }
    }
}
