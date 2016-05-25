#include<iostream>

using namespace std;

int root(int s[],int v) 		// Function to return the root node of node v
{
	while(s[v]!=v)
		v = s[v];
	return v;
}

void kruskals(int a[][10],int n)
{
	int t[n][2],i,j,mincost,u,v,s[n],count=0,cost=0;
	for(i=0;i<n;i++) 					// Initializing parent nodes
		s[i]=i;
	while(count!=n-1)					// While the required edges aren't found
	{
		mincost = 999;
		for(i=0;i<n;i++)				// Finding the minimum cost edge
			for(j=0;j<n;j++)
				if(a[i][j]<mincost)
				{
					u = i;
					v = j;
					mincost = a[i][j];
				}
		if(mincost==999)				// If no such edge found
			break;
		i = root(s,u);
		j = root(s,v);
		if(i!=j)						// If both the vertices aren't part of the same tree
		{
			t[count][0] = u;
			t[count][1] = v;
			s[j] = i;
			count++;
			cost+=a[u][v];
		}
		a[u][v] = 999;
	}
	if(count!=n-1)
		cout<<"\n Spanning tree doesn't exist!!";
	else
	{
		cout<<"\n Edges of the minimum cost spanning tree are :\n";
		for(i=0;i<n-1;i++)
			cout<<"\n "<<t[i][0]<<"---"<<t[i][1];
	}
}

int main()
{
	int a[10][10],i,j,n;
	cout<<"\n Enter the number of vertices in the undirected graph : ";
	cin>>n;
	cout<<"\n Enter the "<<n<<" X "<<n<<" elements of the adjacency cost matrix :\n";
	for(i=0;i<n;i++)
		for(j=0;j<n;j++)
			cin>>a[i][j];
	kruskals(a,n);
	cout<<"\n";
	return 0;
}