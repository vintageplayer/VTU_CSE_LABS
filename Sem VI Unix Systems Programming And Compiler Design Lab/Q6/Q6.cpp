#include<iostream>
#include<unistd.h>
using namespace std;

void print(char *text)
{
	int i;
	
	setbuf(stdout,NULL);
	
	for(i=0;text[i]!='\n';i++)
	{
		cout<<text[i];
		sleep(2);
	}
}

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
		print("fhhaughaeruhrgarug\n");
	}
	else
	{
		print("bbbbbbbbbbbbbbbb\n");
	}
	return 0;
}
