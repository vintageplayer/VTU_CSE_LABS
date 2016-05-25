#include<iostream>

using namespace std;

void dijkstras(int a[][10],int n,int source)
{
	int d[n],i,vis[n],v,mincost,parent[n],stack[n],top=-1;
	for(i=0;i<n;i++) 					// Initializing the values
	{
		d[i] = a[source][i];
		vis[i] = 0;
		parent[i] = source;
	}
	vis[source] = 1;					// Marking source as visited
	mincost = 0;						// To enter the loop
	while(mincost!=999)
	{
		mincost = 999;
		for(i=0;i<n;i++) 				// Finding the next closest vertex
			if(d[i]<=mincost && vis[i]!=1)
			{
				mincost = d[i];
				v = i;
			}
		vis[v] = 1;						// Marking the next closest vertex as visited
		for(i=0;i<n;i++)				// Updating the minimum distance
			if(vis[i]!=1 && (d[v]+a[v][i])<=d[i])
			{
				parent[i] = v;
				d[i] = d[v]+a[v][i];
			}
	}
	cout<<"\n The shotest distance from vertex "<<source<<" are :\n";
	for(i=0;i<n;i++)
	{
		cout<<"\n Path to vertex "<<i<<" : "<<source<<"->";
		v = parent[i];
		while(v!=source) 				// Storing the reverse path in stack
		{
			stack[++top] = v;
			v = parent[v];
		}
		while(top!=-1) 					// Printing the path by reversing the values using stack
		{
			cout<<stack[top--]<<"->";
		}
		cout<<i<<". Distance : "<<d[i];
	}
}

int main()
{
	int a[10][10],i,j,n,source;
	cout<<"\n Enter the number of elements in the graph : ";
	cin>>n;
	cout<<"\n Enter the "<<n<<" X "<<n<<" cost matrix :\n";
	for(i=0;i<n;i++)
		for(j=0;j<n;j++)
			cin>>a[i][j];
	cout<<"\n Enter the source vertex (1 - "<<n<<") : ";
	cin>>source;
	dijkstras(a,n,source-1);
	cout<<"\n";
	return 0;
}