#include<iostream>
#include<string.h>
#include<unistd.h>
#include<fcntl.h>
#include<sys/stat.h>

#define BUFFER_SIZE 128

using namespace std;

int main(int argc, char **argv)
{
	char buf[BUFFER_SIZE];
	int fd;
	
	if(argc!=2)
	{
		cout<<"Invalid arguments"<<endl;
		cout<<"Usage : "<<argv[0]<<" <filename> "<<endl;
		return 1;
	}
	
	if(mkfifo(argv[1],0777)!=-1)
	{
		cout<<"FIFO file is created."<<endl;
	}
	else
	{
		cout<<"Error Creating FIFO file."<<endl;
		return 1;
	}
	
	fd	= open(argv[1],O_WRONLY);
	
	if(fd == -1)
	{
		perror("open");
		return 1;
	}
	else
	{
		cout<<"Enter text to be communicated : "<<endl;
		gets(buf);
	
		write(fd,buf,strlen(buf));
	
		close(fd);
	}
	return 0;
}
