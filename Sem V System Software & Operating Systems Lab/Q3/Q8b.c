#include<stdio.h>
#include<fcntl.h>

int main()
{
	int fd;
	char buf1[] = "abcdefghijklmnop";
	char buf2[] = "ABCDEFGHIJKLMNOP";
	fd = open("output.txt",O_RDWR|O_CREAT|O_EXCL,0755);
	if(fd==-1)
	{
		printf("Error while creating file!!");
		printf("\nExiting...");
		return 1;
	}
	write(fd,buf1,16);
	lseek(fd,32,SEEK_CUR);
	write(fd,buf2,16);
	close(fd);
	system("vi output.txt");
	return 0;
}
