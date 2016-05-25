#include<iostream>

using namespace std;

int max(int a,int b)
{
	if(a>b)
		return a;
	else
		return b;
}

void knapsack(int w[],int p[],int m,int n)
{
	int v[n+1][m+1],i,j,x[n+1];
	for(i=0;i<=n;i++)			// Looping for all object weights
		for(j=0;j<=m;j++) 		// Looping for increasing capacity of knapsack
			if(i==0 || j==0)
				v[i][j] = 0;
			else if(w[i]>j) 	// If object can't be fit in the current capacity
				v[i][j] = v[i-1][j];
			else
				v[i][j] = max((v[i-1][j]),(v[i-1][j-w[i]]+p[i]));

	cout<<"\n The optimum value table is :\n";
	for(i=0;i<=n;i++,cout<<"\n")
		for(j=0;j<=m;j++)
			cout<<v[i][j]<<" ";
	for(i=n;i>0;i--) 				// Finding out the objects selected
		if(v[i][m]!=v[i-1][m])
			x[i] = 1;
		else
			x[i] = 0;
	cout<<"\n The selected objects are :\n";
	for(i=1;i<=n;i++)
		if(x[i]==1)
			cout<<i<<" ";
	cout<<"\n";
}

int main()
{
	int w[10],p[10],m,n,i;
	cout<<"\n Enter the capacity of knapsack : ";
	cin>>m;
	cout<<"\n Enter the number of objects : ";
	cin>>n;
	cout<<"\n Enter weights of the "<<n<<" objects :\n";
	for(i=1;i<=n;i++)
		cin>>w[i];
	cout<<"\n Enter the respective profits of the "<<n<<" profits :\n";
	for(i=1;i<=n;i++)
		cin>>p[i];
	knapsack(w,p,m,n);
	return 0;
}