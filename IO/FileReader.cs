using System.Collections.Generic;
using System.IO;

namespace Tester.src.IO
{
    /// <summary>
    /// A class to help read files in certain ways in the future
    /// </summary>
    class FileReader
    {
        /// <summary>
        /// Stores the files path as c# does not have a File object
        /// </summary>
        private readonly string filePath;

        public FileReader(string filePath)
        {
            this.filePath = filePath;
        }

        /// <summary>
        /// Reads the file line by line
        /// </summary>
        /// <returns>
        /// A List of strings where each string represents a line
        /// </returns>
        public List<string> ReadByLine()
        {
            return new List<string>(File.ReadAllLines(filePath));
        }

        /// <summary>
        /// Reads the file by a delimeter ("; , . etc")
        /// </summary>
        /// <param name="delimeter">The delimeter to read by</param>
        /// <returns>A list of strings that are split by the delimeter, does not include the delimeter</returns>
        public List<string> ReadByDelimeter(string delimeter)
        {
            return new List<string>(File.ReadAllText(filePath).Split(delimeter));
        }

        /// <summary>
        /// Reads an entire file to a string
        /// </summary>
        /// <returns>
        /// A string that consists of the entire file
        /// </returns>
        public string ReadToString()
        {
            return File.ReadAllText(filePath);
        }

        /// <summary>
        /// Gets the filename relative to the instantiated file path
        /// </summary>
        /// <returns>the filename associated with the path</returns>
        public string GetFileName()
        {
            return Path.GetFileNameWithoutExtension(filePath);
        }
    }
}
