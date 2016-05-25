#include<iostream>

using namespace std;

int main()
{
	int a[10][10],n,i,j,k;
	cout<<"\n Enter the number of vertices in the digraph : ";
	cin>>n;
	cout<<"\n Enter the "<<n<<" X "<<n<<" adjacency matrix :\n";
	for(i=0;i<n;i++)
		for(j=0;j<n;j++)
			cin>>a[i][j];
	for(i=0;i<n;i++)
		for(j=0;j<n;j++)
			for(k=0;k<n;k++)
				if(a[j][i]==1 && a[i][k]==1)
				{
					a[j][k] = 1;
				}
	cout<<"\n Transitive closure of the entered digraph is :\n";
	for(i=0;i<n;i++,cout<<"\n")
		for(j=0;j<n;j++)
			cout<<a[i][j]<<" ";
	return 0;
}