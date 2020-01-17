using Microsoft.SqlServer.Management.Common;
using Microsoft.SqlServer.Management.Smo;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Threading.Tasks;
using TaskPoolExecutor.Sql.Response;

namespace TaskPoolExecutor.Sql.Service
{
    class QueryService : AbstractDatabaseService
    {
        private readonly string query;

        public QueryService(TaskExecutor.Sql.Database database, string query) : base(database)
        {
            this.query = query;
        }

        public async Task<SQLResponse> ExecuteQueryAsync()
        {
            return await Task.Factory.StartNew(() =>
            {
                using (SqlConnection connection = new SqlConnection(database.GetConnectionString()))
                {
                    connection.StatisticsEnabled = true;

                    try
                    {
                        Server server = new Server(new ServerConnection(connection));
                        server.ConnectionContext.StatementTimeout = 0;

                        server.ConnectionContext.ExecuteNonQuery(query);
                    }
                    catch (Exception exception)
                    {
                        Console.WriteLine(exception.InnerException.Message);
                        Console.WriteLine(exception.Message);
                        Console.WriteLine(exception.StackTrace);
                        return null;
                    }


                    var statistics = connection.RetrieveStatistics();
                    return new SQLResponse(new List<string>(), (long)statistics["ExecutionTime"]);
                }
            });
        }

        public SQLResponse ExecuteQuerySync()
        {
            using (SqlConnection connection = new SqlConnection(database.GetConnectionString()))
            {
                connection.StatisticsEnabled = true;

                try
                {
                    Server server = new Server(new ServerConnection(connection));
                    server.ConnectionContext.StatementTimeout = 0;

                    server.ConnectionContext.ExecuteNonQuery(query);
                }
                catch (Exception exception)
                {
                    Console.WriteLine(exception.InnerException.Message);
                    Console.WriteLine(exception.Message);
                    Console.WriteLine(exception.StackTrace);
                    return null;
                }


                var statistics = connection.RetrieveStatistics();
                return new SQLResponse(new List<string>(), (long)statistics["ExecutionTime"]);
            }
        }
    }
}
