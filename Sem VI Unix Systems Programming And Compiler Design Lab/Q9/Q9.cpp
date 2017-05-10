#include<iostream>
#include<string.h>
#include<unistd.h>

#define BUFFER_SIZE 64

using namespace std;

void command(char *cmd)
{
	int pid;
	if((pid=fork())<0)
	{
		perror("fork");
	}
	else if(pid==0)
	{
		execl("/bin/sh","sh","-c",cmd,NULL);
	}
	else
	{
		waitpid(pid,NULL,0);
	}
}

int main()
{
	char buf[BUFFER_SIZE];
	cout<<"TooSH>";
	gets(buf);
	while(strcmp(buf,"exit")!=0)
	{
		command(buf);
		cout<<endl<<"TooSH>";
		gets(buf);
	}
	
	return 0;
}
