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
		if((pid=fork())<0)
		{
			perror("fork");
			return 1;
		}
		else if(pid == 0)
		{
			sleep(2);
			cout<<"Child 2 executing..."<<endl;
			cout<<"Process ID : "<<getpid()<<". Parent Process ID : "<<getppid()<<"."<<endl;
			return 0;
		}
		else
		{
			cout<<"Child 1 exiting.."<<endl;
			exit(0);
		}
	}
	else
	{
		waitpid(pid,NULL,0);
		sleep(5);
		cout<<"Parent Process executing."<<endl;
		system("ps");
	}
	return 0;
}
