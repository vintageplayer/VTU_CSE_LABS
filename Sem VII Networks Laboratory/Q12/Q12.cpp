#include<iostream>

using namespace std;

int main()
{
	int i,trate,cap,in[10],nsec,count=0,drop;
	
	cout<<"Enter the transmission rate : ";
	cin>>trate;
	
	cout<<"\nEnter the maximum capacity : ";
	cin>>cap;
	
	cout<<"\nEnter simulation duration : ";
	cin>>nsec;
	
	for(i=0;i<nsec;i++)
	{
		cout<<"\nEnter input packet size for "<<(i+1)<<" second : ";
		cin>>in[i];
	}
	
	cout<<"Second|Input Size|Output Size|Remaining|Drop Size\n"<<endl;
	for(i=0;i<nsec || count>0;i++)
	{
		cout<<"\t"<<(i+1);
		if(i<nsec)
		{
			count += in[i];
			cout<<"\t"<<in[i];
		}
		else
		{
			cout<<"\t0";
		}
		
		if(count>cap)
		{
			drop = count-cap;
			count = cap;
		}
		else
		{
			drop = 0;
		}
		
		if(count<trate)
		{
			cout<<"\t"<<count;
			count = 0;
		}
		else
		{
			cout<<"\t"<<trate;
			count -= trate;
		}
		
		cout<<"\t"<<count<<"\t"<<drop<<endl;
	}
	return 0;
}
