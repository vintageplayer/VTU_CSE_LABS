#include<stdio.h>
#include<sys/types.h>

int main()
{
	pid_t pid;
	if( (pid=fork()) < 0 )
	{
		printf("Error while creating child process!!");
		printf("Exiting...");
		return 1;
	}

	if(pid==0)
	{
		printf("Child process executing...");
		printf("\nCurrent process ID : %d.",getpid());
		printf("\nParent process ID : %d.",getppid());
	}
	else
	{
		wait();
		printf("\nParent process executing");
		printf("\nCurrent process ID : %d.",getpid());
		printf("\nChild process ID : %d",pid);
	}
	printf("\nExiting...\n");
	return 0;
}
