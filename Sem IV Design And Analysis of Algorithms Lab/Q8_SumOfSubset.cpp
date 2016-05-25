#include<iostream>

using namespace std;

int findsubset(int cs,int k,int r,int x[],int a[],int sum)
{
	static int count = 0;
	int i;
	x[k] = 1;
	if(cs+a[k]==sum)
	{
		count++;
		cout<<"\n Solution "<<count<<" :\n";
		for(i=0;i<=k;i++)
			if(x[i]==1)
				cout<<a[i]<<" ";
		return 1;
	}
	else
	{
		if(cs+a[k]+a[k+1]<=sum)
			findsubset(cs+a[k],k+1,r-a[k],x,a,sum);
	}
	x[k] = 0;
	if(cs+r-a[k]>=sum && cs+a[k+1]<=sum)
		findsubset(cs,k+1,r-a[k],x,a,sum);
	return count;
}

int main()
{
	int a[10],n,sum,i,v[10],totalsum=0;
	cout<<"\n Enter the number of elements : ";
	cin>>n;
	cout<<"\n Enter the "<<n<<" elements in ascending order :\n";
	for(i=0;i<n;i++)
	{
		cin>>a[i];
		v[i] = 0;
		totalsum+=a[i];
	}
	cout<<"\n Enter the sum to be found : ";
	cin>>sum;
	if(findsubset(0,0,totalsum,v,a,sum)==0)
		cout<<"\n No such subset exists!!";
	cout<<"\n";
	return 0;
}