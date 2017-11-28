#include<stdio.h>
#include<fcntl.h>

int main()
{
	int request,response,file,n;
	char fname[50],data[100];
	mkfifo("request.fifo",0777);
	mkfifo("response.fifo",0777);
	request = open("request.fifo",O_RDONLY);
	response = open("response.fifo",O_WRONLY);
	printf("Waiting for client to request...\n");
	read(request,fname,sizeof(fname),0);
	printf("Request received for file : %s.\n",fname);
	file = open(fname,O_RDONLY);
	if(file<0)
	{
		write(response,"File not found\n",15,0);
	}
	else{
		while((n=read(file,data,sizeof(data),0))!=0)
		{
			write(response,data,sizeof(data));
		}
	}
	
	printf("\nResponse sent.");
	close(request);
	close(response);
	unlink("request.fifo");
	unlink("response.fifo");
	return 0;
}
