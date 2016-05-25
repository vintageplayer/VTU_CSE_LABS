#include<iostream>

using namespace std;

int place(int x[],int Q)
{
	int i;
	for(i=0;i<Q;i++)
		if(x[i]==x[Q] || (Q-i)==(x[Q]-x[i]) || (i - Q)==(x[Q]-x[i]))
			return 0;
	return 1;
}

void print(int x[],int n,int count)
{
	cout<<"\n Solution "<<count<<" :\n";
	int i,j;
	for(i=0;i<n;i++,cout<<"\n")
		for(j=0;j<n;j++)
			if(x[i]==j)
				cout<<" Q ";
			else
				cout<<" X ";
}

void NQueens(int n)
{
	int x[n],Q=0,count=0;
	x[Q]=0;
	while(Q!=-1)
	{
		while(x[Q]<n && place(x,Q)==0)
			x[Q]++;
		if(x[Q]<n)
		{
			if(Q==n-1)
			{
				count++;
				print(x,n,count);
				x[Q]++;
			}
			else
			{
				Q++;
				x[Q] = 0;
			}
		}
		else
		{
			Q--;
			x[Q]++;
		}
	}
}

int main()
{
	int n;
	cout<<"\n Enter the dimension of the board (n>3): ";
	cin>>n;
	NQueens(n);
	return 0;
}