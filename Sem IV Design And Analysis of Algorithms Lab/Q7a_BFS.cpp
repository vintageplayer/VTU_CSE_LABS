#include<iostream>

using namespace std;

void BFS(int a[][10],int n,int source)
{
	int vis[n],queue[n],count=0,i,j,v;
	for(i=0;i<n;i++)					// Visiting all nodes connected to source node
	{
		vis[i] = 0;
		if(a[source][i]!=0)				// If connected to source node
		{
			queue[count++] = i;
			vis[i] = 1;
		}
	}
	vis[source] = 1;
	i = 0;
	while(i!=count) 					// While all reachable nodes arem't traversed
	{
		v = queue[i++];
		vis[v] = 1;
		for(j=0;j<n;j++)				// Looping through all nodes to check for connectivity
			if(a[v][j]!=0 && vis[j]!=1) // If reachable and not visited
			{
				queue[count++] = j;
				vis[j] = 1;
			}
	}
	cout<<"\n The reachable nodes from node "<<source<<" are :\n";
	for(i=0;i<n;i++)
	{
		if(vis[i]==1)
			cout<<i<<" ";
	}
	cout<<"\n";
}

int main()
{
	int a[10][10],n,i,j,source;
	cout<<"\n Enter the number of nodes in digraph : ";
	cin>>n;
	cout<<"\n Enter the "<<n<<" X "<<n<<" adjacency matrix : ";
	for(i=0;i<n;i++)
		for(j=0;j<n;j++)
			cin>>a[i][j];
	cout<<"\n Enter the source vertex : ";
	cin>>source;
	BFS(a,n,source-1);
	return 0;
}