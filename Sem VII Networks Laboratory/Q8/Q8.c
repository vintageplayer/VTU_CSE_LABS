#include<stdio.h>
#define max_nodes 10

struct node{
	int from[max_nodes];
	int dist[max_nodes];
}rt[max_nodes];

int main()
{
	int n,i,j,k,cost[max_nodes][max_nodes],flag;
	printf("Enter the number of nodes : ");
	scanf("%d",&n);
	
	printf("\nEnter the cost matrix : ");
	for(i=0;i<n;i++){
		for(j=0;j<n;j++){
			scanf("%d",&cost[i][j]);
			rt[i].dist[j] = cost[i][j];
			rt[i].from[j] = j;
		}
	}
	
	do
	{
		flag = 0;
		for(i=0;i<n;i++){
			for(j=0;j<n;j++){
				for(k=0;k<n;k++){
					if( rt[i].dist[j] > (rt[i].dist[k]+rt[k].dist[j]) ){
						rt[i].dist[j] = rt[i].dist[k]+rt[k].dist[j];
						rt[i].from[j] = k;
						flag = 1;
					}
				}
			}
		}
	}while(flag!=0);
	
	for(i=0;i<n;i++){
		printf("\n\nRouter %d:",i+1);
		for(j=0;j<n;j++){
			printf("\nNode %d via %d : %d",(j+1),(rt[i].from[j]+1),rt[i].dist[j]);
		}
	}
	return 0;
}
