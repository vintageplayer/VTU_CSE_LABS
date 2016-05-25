#include<iostream>

using namespace std;

void find_order(int a[][10],int n)
{
	int indeg[n],order[n],stack[n],i,j,top=-1,total,v,c=0;
	for(i=0;i<n;i++) 					// Loop to calculate the indegress of all nodes
	{
		total = 0;
		for(j=0;j<n;j++) 				// Looping through all vertices
			if(a[j][i]!=0) 				// If node i requires node j
				total+=1;
		if(total==0)
		{
			stack[++top] = i;
			indeg[i] = -1;
		}
		else
			indeg[i] = total;
	}
	while(top!=-1)					// While all nodes with degree 0 haven't been traversed
	{
		v = stack[top--];
		order[c++] = v;
		for(i=0;i<n;i++)
		{
			if(a[v][i]!=0)
			{
				indeg[i]--;
				if(indeg[i]==0)
				{
					stack[++top] = i;
					indeg[i] = -1;
				}
			}
		}
	}
	if(c==n) 						// Checking wether all nodes could be ordered
	{
		cout<<"\n The topological order is :\n";
		for(i=0;i<n;i++)
			cout<<order[i]<<" ";
		cout<<"\n";
	}
	else
	{
		cout<<"\n A topological order can't be found!!\n";
	}
}

int main()
{
	int a[10][10],n,i,j;
	cout<<"\n Enter the number of vertices : ";
	cin>>n;
	cout<<"\n Enter the "<<n<<" X "<<n<<" adjacency matrix :\n";
	for(i=0;i<n;i++)
		for(j=0;j<n;j++)
			cin>>a[i][j];
	find_order(a,n);
	return 0;
}