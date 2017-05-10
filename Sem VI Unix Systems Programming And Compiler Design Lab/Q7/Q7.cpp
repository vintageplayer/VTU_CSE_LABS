#include<iostream>
#include<unistd.h>

using namespace std;

int main()
{
	int pid;
	
	if((pid=fork())<0)
	{
		perror("fork");
		return 1;
	}
	else if(pid == 0)
	{
		cout<<"In child process. Process id : "<<getpid()<<endl;
		sleep(3);
		cout<<"\nChild process exiting now."<<endl;
		_exit(0);
	}
	else
	{
		sleep(10);
		cout<<"In parent process.";
		system("ps");
	}
	
	return 0;
}
