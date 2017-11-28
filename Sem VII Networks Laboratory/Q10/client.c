#include<stdio.h>
#include<fcntl.h>

int main()
{
	int request,response,n;
	char file[50],data[100];
	
	request = open("request.fifo",O_WRONLY);
	response = open("response.fifo",O_RDONLY);
	
	printf("Enter file to request from server : ");
	scanf("%s",file);
	write(request,file,sizeof(file),0);
	printf("\nRequest sent.");
	printf("\nResponse form server:\n");
	while( (n = read(response,data,sizeof(data)) ) !=0){
		printf("%s",data);
	}
	close(request);
	close(response);
	return 0;
}
