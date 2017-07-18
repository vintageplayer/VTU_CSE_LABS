#include<stdio.h>
#include<stdlib.h>

int main()
{

	char cmd[20];
	pid_t pid;

	if((pid=fork())<0)
	{
		printf("Error while creating child process!!");
		printf("\nExiting...");
		return 1;
	}
	printf("Hello two times.");
	if(pid==0)
	{
		printf("\nChild process executing...");
		printf("\nEnter the shell command to be executed : ");
		scanf("%s",cmd);
		printf("\nExecuting entered command..\n");
		system(cmd);
	}
	else
	{
		wait(0);
		printf("\nParent process...");
	}
	printf("\nExiting...");
	return 0;
}
