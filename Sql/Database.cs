using System.Data.SqlClient;
using TaskPoolExecutor.Sql.Service;

namespace TaskExecutor.Sql
{
    internal class Database
    {
        public string ServerName { get; }
        public int ServerPort { get; }
        public string DatabaseToUse { get; }
        public string Username { get; }
        public string Password { get; }

        private SqlConnection connection;

        public Database(string serverName, int serverPort, string databaseToUse, string username, string password)
        {
            this.ServerName = serverName;
            this.ServerPort = serverPort;
            this.DatabaseToUse = databaseToUse;
            this.Username = username;
            this.Password = password;
        }

        public string GetConnectionString()
        {
            return new ConnectionService(this).GetConnectionString();
        }

        public void ClearCacheSync()
        {
            new QueryService(this, "DBCC DROPCLEANBUFFERS; DBCC FREEPROCCACHE;").ExecuteQuerySync();
        }
    }
}
