#include<iostream>

using namespace std;

int N,exact_order[10],exact_cost=9999,approx_order[10],approx_cost=0;

void swap(int &x,int &y)
{
	int temp = x;
	x = y;
	y = temp;
}

void permute(int a[][10],int order[],int n)
{
	int i;
	if(n==1) 						// If not manipulating the order any further
	{
		int newcost = 0;
		order[N] = order[0];
		for(i=0;i<N;i++) 			// Finding the cost of visiting the computed order
		{
			newcost += a[order[i]][order[i+1]];
		}
		if(newcost<exact_cost)		// If more feasible than all previous orders
		{
			for(i=0;i<=N;i++)
				exact_order[i] = order[i];
			exact_cost = newcost;
		}
		return;
	}
	for(i=0;i<n;i++) 				// Producing all possible combinations of vertex visiting order
	{
		swap(order[i],order[n-1]);
		permute(a,order,n-1);
		swap(order[i],order[n-1]);
	}
}

void exact(int a[][10])
{
	int i,order[N];
	for(i=0;i<N;i++)
		order[i] = i;
	permute(a,order,N);
}

void approximate(int a[][10])
{
	int vis[N],i,u,v,count=1,min;
	for(i=1;i<N;i++)
		vis[i] = 0;
	vis[0] = 1;
	u = 0;
	approx_order[0] = 0;
	while(count<N)
	{
		min = 999;
		for(i=0;i<N;i++)
			if(vis[i]!=1 && a[u][i]<min)
			{
				min = a[u][i];
				v = i;
			}
		approx_order[count] = v;
		count++;
		vis[v] = 1;
		u = v;
		approx_cost += min;
	}
	approx_cost += a[v][0];
}

int main()
{
	int a[10][10],i,j;
	cout<<"\n Enter the number of vertices : ";
	cin>>N;
	cout<<"\n Enter the "<<N<<" X "<<N<<" cost matrix :\n";
	for(i=0;i<N;i++)
		for(j=0;j<N;j++)
			cin>>a[i][j];
	exact(a);
	approximate(a);
	cout<<"\n Optimal Solution :\n";
	for(i=0;i<N;i++)
		cout<<exact_order[i]<<"-->";
	cout<<exact_order[0];
	cout<<"\n Exact Cost : "<<exact_cost;
	cout<<"\n\n Approximate Solution :\n";
	for(i=0;i<N;i++)
		cout<<approx_order[i]<<"-->";
	cout<<approx_order[0];
	cout<<"\n Approximate Cost : "<<approx_cost;
	cout<<"\n Error in approximation : "<<approx_cost - exact_cost;
	cout<<"\n Accuracy Ratio : "<<(float)approx_cost/exact_cost;
	cout<<"\n The approximate tour is "<<( ((float)approx_cost/exact_cost) - 1)*100<<"% longer than exact tour.\n";
	return 0;
}