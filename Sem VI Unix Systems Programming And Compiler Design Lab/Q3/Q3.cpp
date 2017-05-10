#include<iostream>
#include<stdio.h>
#include<fcntl.h>
#include<unistd.h>
using namespace std;

int main(int argc, char **argv)
{
	int fd;
	char arr[51];
	struct flock var;
	
	if(argc!=2)
	{
		cout<<"Invalid Arguments!!"<<endl;
		cout<<"Usage : "<<argv[0]<<" <filename>"<<endl;
		return 1;
	}
	
	fd		= open(argv[1],O_RDWR);
	
	var.l_type	= F_WRLCK;
	var.l_whence	= SEEK_END;
	var.l_start	= -100;
	var.l_len	= 100;
	
	fcntl(fd,F_GETLK,&var);
	if(var.l_type == F_UNLCK)
	{
		cout<<"File is unlocked. Acquiring the lock..."<<endl;
		var.l_type 	= F_WRLCK;
		if(fcntl(fd,F_SETLK,&var)!=-1)
		{
			cout<<"Lock Set."<<endl;
		}
		else
		{
			perror("fcntl");
			return 1;
		}
		lseek(fd,-50,SEEK_END);
		if(read(fd,arr,50)<0)
		{
			cout<<"Error Reading from file."<<endl;
		}
		else
		{
			arr[50] = '\0';
			cout<<"File contents : "<<arr;
		}
	}
	else
	{
		cout<<"File locked by a process with process ID : "<<var.l_pid<<endl;
	}
	
	var.l_type	= F_UNLCK;
	fcntl(fd,F_SETLK,&var);
	return 0;
}
