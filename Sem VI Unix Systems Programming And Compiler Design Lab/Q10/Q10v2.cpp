#include<iostream>
#include<signal.h>
#include<unistd.h>
#include<sys/time.h>
using namespace std;

void alarm_handler(int signo)
{
	cout<<"Alarm interrupt recieved"<<endl;
}

int main()
{
	struct itimerval delay;
	int ret;
	signal(SIGALRM,alarm_handler);
	
	delay.it_value.tv_sec = 2;
	delay.it_value.tv_usec = 0;
	
	cout<<"Enter timer interval : ";
	cin>>delay.it_interval.tv_sec;
	delay.it_interval.tv_usec = 0;
	
	ret = setitimer(ITIMER_REAL,&delay,NULL);
	if(ret)
	{
		perror("setitimer");
		return 1;
	}
	
	while(1)
	pause();
	return 0;
}
