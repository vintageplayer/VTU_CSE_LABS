#include<iostream>
#include<fcntl.h>
#include<unistd.h>
#define BUFFER_SIZE 256

using namespace std;

int main(int argc, char **argv)
{
	int fd;
	char buf[BUFFER_SIZE];
	
	if(argc!=2)
	{
		cout<<"Invalid arguments!!"<<endl;
		cout<<"Usage : "<<argv[0]<<" <filename> "<<endl;
		return 1;
	}
	
	if((fd = open(argv[1],O_RDONLY))==-1)
	{
		perror("open");
		return 1;
	}
	else
	{
		if(read(fd,buf,BUFFER_SIZE)==-1)
		{
			perror("read");
			return 1;
		}
		else
		{
			cout<<"File contents are :"<<endl;
			cout<<buf<<endl;
		}
	}
	return 0;
}
