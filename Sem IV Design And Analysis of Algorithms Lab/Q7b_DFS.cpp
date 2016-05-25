#include<iostream>

using namespace std;

int check(int a[][10],int n)
{
	int vis[n],i,stack[n],top=-1,count=1,v;
	for(i=1;i<n;i++) 					// Initializing all nodes as unvisited
		vis[i] = 0;
	vis[0] = 1; 						// Setting first node as visited
	stack[++top] = 0;					// Pushing the first node to stack
	while(top!=-1)			 			// While all reachable nodes are traversed
	{
		v = stack[top]; 				// Checking the last visited node
		for(i=0;i<n;i++)				// Looping through all nodes to check for connectivity
			if(a[v][i]==1 && vis[i]!=1)	// If a node is reachable and not visited
			{
				stack[++top] = i; 		// Pushin the new node into stack
				vis[i] = 1; 			// Marking the new node as visited
				count++; 				// Incrementing the number of visited nodes
				break;					// Breaking to do depth first search
			}
		if(i==n)						// If the node has no reachable child left
		{
			top--;						// Removing the node from stack
		}
	}
	if(count==n)						// Checking wether all nodes were reached or not
		return 1;
	return 0;
}

int main()
{
	int a[10][10],i,j,n;
	cout<<"\n Enter the number of vertices in the digraph : ";
	cin>>n;
	cout<<"\n Enter the "<<n<<" X "<<n<<" adjacency matrix :\n";
	for(i=0;i<n;i++)
		for(j=0;j<n;j++)
			cin>>a[i][j];
	if(check(a,n)==1)
		cout<<"\n Digraph is a connected graph.\n";
	else
		cout<<"\n Digraph is not a connected graph.\n";
	return 0; 
}