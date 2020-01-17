using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Net.Sockets;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using TaskPoolExecutor.Config;
using TaskPoolExecutor.IO;
using TaskPoolExecutor.Sockets;
using TaskPoolExecutor.Sql.Response;
using TaskPoolExecutor.Sql.Service;

namespace TaskPoolExecutor
{
    class QueryTestRunner
    {
        private TcpClient clientSocket;
        private QueryServiceWrapper queryWrapper;
        public Queue<QueryTestAdapter> TestQueue { get; }
        public int NumberOfTests { get; }
        public QueryTestAdapter CurrentTest { get; set; }

        public QueryTestRunner(TcpClient clientSocket, QueryServiceWrapper queryWrapper, Queue<QueryTestAdapter> testQueue)
        {
            this.clientSocket = clientSocket;
            this.queryWrapper = queryWrapper;
            this.TestQueue = testQueue;
            this.NumberOfTests = testQueue.Count;
        }

        public void RunTests(bool cached)
        {
            string directory = DateTime.UtcNow.ToString("yyyyMMdd_hhmmss");
            Directory.CreateDirectory(@".\SqlTests\reports\" + directory + "\\");
            Console.WriteLine("Using " + (@".\SqlTests\reports\" + directory + "\\") + " for storage");

            while (TestQueue.Count > 0)
            {
                if (!cached)
                {
                    queryWrapper.ClearCacheSync(true);
                }
                
                RunNextTest(directory);
            }
        }

        public void RunNextTest(string directory)
        {
            CurrentTest = TestQueue.Dequeue();
            NetworkStream stream = clientSocket.GetStream();

            Console.WriteLine("Running " + CurrentTest.TestName + " ...");
            SocketUtil.SendMessage(stream, "start;" + CurrentTest.TestName);
            SQLResponse response = RunQuerySync(CurrentTest.Query);

            if (response == null)
            {
                Console.WriteLine("Test " + CurrentTest.TestName + " failed :(");
                SocketUtil.SendMessage(stream, "reset;failed");
            }
            else
            {
                Console.WriteLine("Test " + CurrentTest.TestName + " Passed! Execution Time: " + response.ExecutionTime + " ms");

                SocketUtil.SendMessage(stream, "reset");

                string jsonData = GetOrderedResult(stream);
                HandleResult(directory, jsonData, response);
            }
        }

        private void HandleResult(string directory, string jsonData, SQLResponse response)
        {
            dynamic jsonObject = JsonConvert.DeserializeObject(jsonData);
            jsonObject.data[0].testName = CurrentTest.TestName;
            jsonObject.data[0].executionTime = response.ExecutionTime;
            jsonObject = JsonConvert.SerializeObject(jsonObject);

            //Console.WriteLine("Writing report now...");
            File.WriteAllText(@".\SqlTests\reports\" + directory + "\\" + CurrentTest.TestName + ".json", jsonObject);
        }

        public string GetOrderedResult(NetworkStream stream)
        {
            string jsonData = "";

            byte[] dataBuffer = new byte[1024];

            if ((jsonData += GetDataFromSocket(dataBuffer, stream)).Contains("lets get this thing started|"))
            {
                while (clientSocket.Available > 0)
                {
                    jsonData += GetDataFromSocket(dataBuffer, stream);
                }
            }

            return jsonData.Replace("lets get this thing started|", "");
        }

        private string GetDataFromSocket(byte[] dataBuffer, NetworkStream stream)
        {
            stream.Flush();
            int bytesRead = stream.Read(dataBuffer);
            if (bytesRead > 0)
            {
                return Encoding.ASCII.GetString(dataBuffer, 0, bytesRead);
            }
            else
            {
                return "";
            }
        }

        public SQLResponse RunQuerySync(string query)
        {
            return queryWrapper.ExecuteQuerySync(query);
        }

        private void UpdateWaitHandle(string message, EventWaitHandle waitHandle)
        {
            Task.Factory.StartNew(() =>
            {
                NetworkStream stream = clientSocket.GetStream();
                byte[] dataBuffer = new byte[1024];
                while (clientSocket.Connected)
                {
                    int bytesReceived = stream.Read(dataBuffer);
                    string messageReceived = Encoding.ASCII.GetString(dataBuffer, 0, bytesReceived);

                    if (messageReceived.Contains(message))
                    {
                        waitHandle.Set();
                    }
                }
            });
        }
    }
}
