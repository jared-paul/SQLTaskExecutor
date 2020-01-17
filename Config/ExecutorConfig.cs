using System.Configuration;

namespace TaskPoolExecutor.Config
{
    static class ExecutorConfig
    {
        public static string DatabaseIp => ConfigurationManager.AppSettings["databaseIp"];
        public static int DatabasePort => int.Parse(ConfigurationManager.AppSettings["databasePort"]);
        public static string DatabaseToUse { get { return ConfigurationManager.AppSettings["databaseToUse"]; } }
        public static string DatabaseUser { get { return ConfigurationManager.AppSettings["databaseUser"]; } }
        public static string DatabasePassword { get { return ConfigurationManager.AppSettings["databasePassword"]; } }
        public static string ServerIp { get { return ConfigurationManager.AppSettings["serverIp"]; } }
        public static int ServerPort { get { return int.Parse(ConfigurationManager.AppSettings["serverPort"]); } }
        public static bool EnableDatabaseCaching { get { return bool.Parse(ConfigurationManager.AppSettings["enableDatabaseCaching"]); } }
        public static int NumberOfTimes { get { return int.Parse(ConfigurationManager.AppSettings["numberOfTimes"]); } }
    }
}
