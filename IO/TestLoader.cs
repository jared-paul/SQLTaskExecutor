using System;
using System.Collections.Generic;
using System.IO;
using Tester.src.IO;

namespace TaskPoolExecutor.IO
{
    class TestContainer
    {
        public Dictionary<string, string> QueryTests { get; }

        public TestContainer(string testsDirectoryPath)
        {
            this.QueryTests = RetrieveAllQueryTests(testsDirectoryPath);
        }

        public Queue<QueryTestAdapter> GetNewAdapterQueue()
        {
            Queue<QueryTestAdapter> queryTests = new Queue<QueryTestAdapter>();

            foreach (KeyValuePair<string, string> entry in QueryTests)
            {
                Console.WriteLine(entry.Key);
                queryTests.Enqueue(new QueryTestAdapter(entry.Key, entry.Value));
            }

            return queryTests;
        }

        private Dictionary<string, string> RetrieveAllQueryTests(string testsDirectoryPath)
        {
            Dictionary<string, string> queryTests = new Dictionary<string, string>();

            string[] filePaths = Directory.GetFiles(testsDirectoryPath, "*.sql", SearchOption.AllDirectories);

            foreach (string filePath in filePaths)
            {
                FileReader fileReader = new FileReader(filePath);
                queryTests.Add(fileReader.GetFileName(), fileReader.ReadToString());
            }

            return queryTests;
        }
    }
}
