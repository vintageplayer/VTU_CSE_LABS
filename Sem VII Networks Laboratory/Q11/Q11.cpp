#include<iostream>

using namespace std;

int gcd(int a, int b)
{
	int r;
	while(b!=0)
	{
		r = a%b;
		a = b;
		b = r;
	}
	
	return a;
}

int calc(int a, int x, int n)
{
	//cout<<a<<". x : "<<x<<" n : "<<n<<endl;
	int i,res=1;
	for(i=0;i<x;i++)
	{
		res = (res * a) % n;
	}
	
	res = res%n;
	//cout<<"Result : "<<res<<endl;
	return res;
}

int main()
{
	char cipher[100],decr[100],msg[100];
	int a,b,n,z,i,j,x,y;
	
	cout<<"Enter first prime number : ";
	cin>>a;
	
	cout<<"\nEnter second prime number : ";
	cin>>b;
	
	n = a*b;
	z = (a-1)*(b-1);
	
	for(i=2;i<z;i++)
	{
		if(gcd(z,i)==1)
		{
			x = i;
			break;
		}
	}
	
	cout<<"\nPublic key is : {"<<x<<","<<n<<"}."<<endl;
	
	for(i=1;i<z;i++)
	{
		if((i*x)%z==1)
		{
			y = i;
			break;
		}
	}
	
	cout<<"Private key is : {"<<y<<","<<n<<"}."<<endl;
	
	cout<<"Enter text to be encrypt	 : ";
	cin>>msg;
	
	cout<<"\n\nEncrypted text is :"<<endl;
	for(i=0;msg[i]!='\0';i++)
	{
		//cout<<msg[i]-97;
		cipher[i] = calc((msg[i]-97),x,n);
		cout<<cipher[i]+97<<" ";
		decr[i] = calc(cipher[i],y,n) + 97;
	}
	
	decr[i] = cipher[i] = '\0';
	cout<<"\n\nDecrypted text is : "<<decr<<endl;
	return 0;
}
