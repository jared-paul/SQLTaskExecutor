using System.Net.Sockets;
using System.Text;

namespace TaskPoolExecutor.Sockets
{
    class SocketUtil
    {
        public static void SendMessage(NetworkStream stream, string message)
        {
            stream.Write(Encoding.ASCII.GetBytes(message));
        }
    }
}
