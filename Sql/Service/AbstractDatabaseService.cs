using TaskExecutor.Sql;

namespace TaskPoolExecutor.Sql.Service
{
    abstract class AbstractDatabaseService
    {
        protected readonly Database database;

        public AbstractDatabaseService(Database database)
        {
            this.database = database;
        }
    }
}
