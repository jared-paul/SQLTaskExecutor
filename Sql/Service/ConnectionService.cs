using System.Data.SqlClient;
using TaskExecutor.Sql;

namespace TaskPoolExecutor.Sql.Service
{
    class ConnectionService : AbstractDatabaseService
    {
        public ConnectionService(Database database) : base(database)
        {

        }

        public string GetConnectionString()
        {
            SqlConnectionStringBuilder sqlConnectionBuilder = new SqlConnectionStringBuilder();
            sqlConnectionBuilder.DataSource = database.ServerName;
            sqlConnectionBuilder.InitialCatalog = database.DatabaseToUse;
            sqlConnectionBuilder.UserID = database.Username;
            sqlConnectionBuilder.Password = database.Password;

            return sqlConnectionBuilder.ConnectionString;
        }
    }
}
