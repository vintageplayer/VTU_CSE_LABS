#include<iostream>
#include<sys/time.h>

using namespace std;

int min(int x,int y)
{
	if(x<y)
		return x;
	else
		return y;
}

void floyds(int a[][10],int n)
{
	int i,j,k;
	for(i=0;i<n;i++)
		for(j=0;j<n;j++)
			for(k=0;k<n;k++)
				if(a[j][i]!=0 && a[i][k]!=0)
				{
					a[j][k] = min(a[j][k],a[j][i]+a[i][k]);
				}
}

void floyds_parallel(int a[][10],int n)
{
	int i,j,k;
	for(i=0;i<n;i++)
	{
		#pragma omp parallel for private(j,k) shared(a)
		for(j=0;j<n;j++)
			for(k=0;k<n;k++)
				if(a[j][i]!=0 && a[i][k]!=0)
				{
					a[j][k] = min(a[j][k],a[j][i]+a[i][k]);
				}
	}
}

int main()
{
	int a[10][10],b[10][10],n,i,j;
	struct timeval tv;
	double start,end,elapse1,elapse2;
	cout<<"\n Enter the number of vertices in the digraph : ";
	cin>>n;
	cout<<"\n Enter the "<<n<<" X "<<n<<"adjacency matrix :\n";
	for(i=0;i<n;i++)
		for(j=0;j<n;j++)
		{
			cin>>a[i][j];
			b[i][j] = a[i][j];
		}

	gettimeofday(&tv,NULL);						// Storing system time
	start = tv.tv_sec + (tv.tv_usec/1000000.0);
	floyds(a,n);								// Invoking normal exection function
	gettimeofday(&tv,NULL);
	end = tv.tv_sec + (tv.tv_usec/1000000.0);	// Storing system time
	elapse1 = end - start; 						// Calculating the elapsed time

	gettimeofday(&tv,NULL);						// Storing system time
	start = tv.tv_sec + (tv.tv_usec/1000000.0);
	floyds_parallel(b,n);						// Invoking parallel execution function
	gettimeofday(&tv,NULL);						// Storing system time
	end = tv.tv_sec + (tv.tv_usec/1000000.0);
	elapse2 = end - start;						// Calculating the elapsed time

	cout<<"\n All pairs-shortest paths are :\n";
	for(i=0;i<n;i++,cout<<"\n ")
		for(j=0;j<n;j++)
			cout<<a[i][j]<<" ";

	cout<<"\n Normal execution time : "<<elapse1;
	cout<<"\n Parallelized execution time : "<<elapse2;
	cout<<"\n Speed up : "<<elapse1/elapse2<<"\n";
	return 0;
}