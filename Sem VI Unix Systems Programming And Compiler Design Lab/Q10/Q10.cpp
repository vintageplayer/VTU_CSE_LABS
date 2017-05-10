#include<iostream>
#include<signal.h>
#include<unistd.h>
#include<stdlib.h>
using namespace std;

void call_handler(int signo)
{
	cout<<"Signal Alarm Interrupt Recieved"<<endl;
}

int main()
{
	signal(SIGALRM,call_handler);
	
	int i,interval;
	cout<<"Enter time interval : ";
	cin>>interval;
	alarm(interval);
	pause();
	
	return 0;
}
