#include<iostream>
#include<unistd.h>
#include<string.h>
using namespace std;

int main(int argc, char **argv)
{
	if(argc<3 || argc > 4 || (argc==4 &&strcmp(argv[1],"-s")!=0) )
	{
		cout<<"Invalid arguments!!"<<endl;
		cout<<"Usage : "<<argv[0]<<" [-s] <source-filename> <destination-filename>"<<endl;
		return 1;
	}
	
	if(argc==4)
	{
		if(symlink(argv[2],argv[3])!=-1)
		{
			cout<<"Symbolic Link created."<<endl;
		}
		else
		{
			perror("symlink");
			return 1;
		}
	}
	else
	{
		if(link(argv[1],argv[2])!=-1)
		{
			cout<<"Hard Link created."<<endl;
		}
		else
		{
			perror("link");
			return 1;
		}
	}
	
	return 0;
}
