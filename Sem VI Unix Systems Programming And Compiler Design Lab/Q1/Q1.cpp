/*
	Write aa C/C++ POSIX compliant program to check the following limits:
	1) No. of clock ticks
	2) Max no. of child processes
	3) Max path length
	4) Max no. of characters in a file name
	5) Max no. of open files/processes
*/
#define _POSIX_SOURCE
#define _POSIX_C_SOURCE 199309L

#include<iostream>
#include<unistd.h>

using namespace std;

int main()
{
	long  ret;
	if((ret=sysconf(_SC_CLK_TCK))!=-1)
	{
		cout<<"Number of clock ticks per second : "<<ret<<endl;
	}
	else
	{
		cout<<"Number of clock ticks is not defined."<<endl;
	}
	
	if((ret=sysconf(_SC_CHILD_MAX))!=-1)
	{
		cout<<"Maximum number of child processes : "<<ret<<endl;
	}
	else
	{
		cout<<"Maximum number of child processes is not defined."<<endl;
	}
	
	if((ret=pathconf("/",_PC_PATH_MAX))!=-1)
	{
		cout<<"Maximum path lenght : "<<ret<<endl;
	}
	else
	{
		cout<<"Maximum path length is not length."<<endl;
	}
	
	if((ret=pathconf("/",_PC_NAME_MAX))!=-1)
	{
		cout<<"Maximum number of characters in a file name is : "<<ret<<endl;
	}
	else
	{
		cout<<"Maximum number of characters in a file is not defined."<<endl;
	}
	
	if((ret=sysconf(_SC_OPEN_MAX))!=-1)
	{
		cout<<"Maximum number of open files/processes is : "<<ret<<endl;
	}
	else
	{
		cout<<"Maximum number of open files/processes limit is not defined."<<endl;
	}
	return 0;
}
