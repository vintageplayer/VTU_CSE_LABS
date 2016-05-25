#include<iostream>

using namespace std;

void prims(int a[][10],int n)
{
	int vis[n],i,j,mincost,u,v,count=1,totalcost=0;
	for(i=1;i<n;i++)			// Initializing all nodes as unvisited
		vis[i] = 0;
	vis[0] = 1; 				// Setting first node as visited
	cout<<"\n The minimum spanning tree edges are :\n";
	while(count!=n)				// While any node is unvisited
	{
		mincost = 999;
		for(i=0;i<n;i++)
			for(j=0;j<n;j++)
				if(vis[i]==1 && vis[j]!=1 && a[i][j]<mincost) // Connecting smallest visited and unvisited node
				{
					mincost = a[i][j];
					u = i;
					v = j;
				}
		count++;
		vis[v] = 1;
		cout<<"\n Cost from vertex "<<u<<" to vertex "<<v<<" is : "<<mincost;
		totalcost+=mincost;
	}
	cout<<"\n Cost of spanning tree is : "<<totalcost; 
}

int main()
{
	int a[10][10],n,i,j;
	cout<<"\n Enter the number of vertices in the graph : ";
	cin>>n;
	cout<<"\n Enter the "<<n<<" X "<<n<<" cost matrix :\n";
	for(i=0;i<n;i++)
		for(j=0;j<n;j++)
			cin>>a[i][j];
	prims(a,n);
	cout<<"\n";
	return 0;
}