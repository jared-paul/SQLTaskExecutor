using System;
using System.Net;
using System.Net.Sockets;

namespace Tester.src.Microservices.Listener.Service
{
    class SocketService
    {
        private IPAddress address;
        private int port;

        public SocketService(IPAddress address, int port)
        {
            this.address = address;
            this.port = port;
        }

        /// <summary>
        /// Makes a connection with the server
        /// </summary>
        /// <returns>A connected socket</returns>
        /// <exception cref="System.Net.Internals.SocketExceptionFactory.ExtendedSocketException">throws when the client is unable to connect</exception>
        public Socket EstablishConnection()
        {
            IPEndPoint remoteEndPoint = new IPEndPoint(address, port);

            Socket socket = new Socket(address.AddressFamily, SocketType.Stream, ProtocolType.Tcp);
            socket.Connect(remoteEndPoint);
            Console.WriteLine("Connected to " + address.ToString() + "!");
            return socket;
        }
    }
}
