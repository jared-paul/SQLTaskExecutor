using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;
using TaskExecutor.Sql;
using TaskPoolExecutor.Config;
using TaskPoolExecutor.IO;
using TaskPoolExecutor.Sql.Service;

namespace TaskPoolExecutor
{
    class TaskPoolExecutor
    {
        private TestContainer testContainer;
        private TcpClient clientSocket;
        private Database database;
        private QueryServiceWrapper queryWrapper;

        public void Execute()
        {
            Setup();

            Console.WriteLine("Getting new adapter queue...");
            Queue<QueryTestAdapter> queryTests = testContainer.GetNewAdapterQueue();
            Console.WriteLine("Tests adapted!");

            for (int i = 0; i < ExecutorConfig.NumberOfTimes; i++)
            {
                Console.WriteLine("Starting set: " + (i + 1));

                QueryTestRunner testRunner = new QueryTestRunner(clientSocket, queryWrapper, new Queue<QueryTestAdapter>(queryTests));
                testRunner.RunTests(ExecutorConfig.EnableDatabaseCaching);

                Console.WriteLine("Finished set: " + (i + 1));
            }

            Task.Delay(1000).Wait();
            clientSocket.GetStream().Write(Encoding.ASCII.GetBytes("stop"));
            Console.WriteLine("All tests finished! shutting down...");
            clientSocket.Close();
        }

        private void Setup()
        {
            LoadTestContainer();
            InitializeConnectionToDatabase();
            InitializeConnectionToClient();
        }

        private void LoadTestContainer()
        {
            Console.WriteLine("Loading tests...");
            this.testContainer = new TestContainer("./SqlTests");
            Console.WriteLine("All tests loaded!");
        }

        private void InitializeConnectionToClient()
        {
            TcpListener server = new TcpListener(IPAddress.Parse(ExecutorConfig.ServerIp), ExecutorConfig.ServerPort);
            server.Start();

            Console.WriteLine("Waiting for connection from client...");
            this.clientSocket = server.AcceptTcpClient();
            Console.WriteLine("Connection Established! Waiting for status update from client...");

            /*
            IPAddress address = IPAddress.Parse(ExecutorConfig.ServerIp);
            IPEndPoint remoteEndPoint = new IPEndPoint(address, ExecutorConfig.ServerPort);

            Socket serverSocket = new Socket(address.AddressFamily, SocketType.Stream, ProtocolType.Tcp);
            serverSocket.Bind(remoteEndPoint);
            serverSocket.Listen(1);

            this.clientSocket = serverSocket.Accept();
            */
        }

        private void InitializeConnectionToDatabase()
        {
            this.database = new Database(ExecutorConfig.DatabaseIp, ExecutorConfig.DatabasePort, ExecutorConfig.DatabaseToUse, ExecutorConfig.DatabaseUser, ExecutorConfig.DatabasePassword);
            this.queryWrapper = new QueryServiceWrapper(database);
        }
    }
}
