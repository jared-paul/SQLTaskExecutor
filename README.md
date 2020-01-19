This program is just a simple executor/handshaker to establish a connection with a socket listening on the specified port.
It currently just executes all SQL script files inside ./SqlTests, sends a status update to the monitor program, and when the
query finishes, writes a report to ./SqlTest/reports/ in json format. 

### Building:
You must open it in VS 2019, 2015 doesn't work as microsoft changed the format of solutions.
Once opened, you must install all dependencies (it should auto install with NuGet) and "publish" the solution.

### Publishing:
Right click the c# solution and click "publish", change the folder to wherever you'd like it to build to.
Once published you can now run the TaskPoolExecutor.dll file

### Usage/Run:
You must install .NET core runtime version 2.2.5 found here: https://dotnet.microsoft.com/download/thank-you/dotnet-runtime-2.2.5-windows-hosting-bundle-installer
Once installed you can open cmd and run the program from the root directory by doing "dotnet TaskPoolExecutor.dll"
It should now run in the cmd you opened.

To have it be worthwhile to run, the monitor must be running parallel to this application on any box.
The monitor must be started after this one.
Monitor: https://code.maruhub.com/projects/MB/repos/tester_csharp/

I have supplied some sample SQL scripts to run, the "Setup" one is recommended as it gives the monitor time to initialize
