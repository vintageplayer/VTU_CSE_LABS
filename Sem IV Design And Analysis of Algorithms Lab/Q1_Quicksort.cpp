#include<iostream>
#include<stdlib.h>
#include<sys/time.h>
#include<stdio.h>

using namespace std;

void swap(int &a, int &b) 			// Function to swap values in 2 intergers in the calling fucntion
{
	int temp = a;
	a = b;
	b = temp;
}

int partition(int a[],int l,int r)	// Function to find the splay/split node position
{
	int p=a[l],i=l,j=r+1,temp;
	while(i<j)
	{
		do 							// Do while is necessary for limiting values condition
		{
			i++;
		}while(a[i]<=p && i<r);
		do
		{
			j--;
		}while(a[j]>p);
		swap(a[i],a[j]);
	}
	swap(a[i],a[j]);
	swap(a[j],a[l]);

	return j;
}

void quicksort(int a[],int l,int r)	// Function to split the array recursively
{
	if(l<r)
	{
		int s = partition(a,l,r);
		quicksort(a,l,s-1);
		quicksort(a,s+1,r);
	}
	return;
}

void get_number(int a[],int n)	    // Function to generate the  required number of random numbers
{
	int i;
	for(i=0;i<n;i++)
		a[i] = rand() % 1000;
}

int main()
{
	int n,a[1000],i;
	FILE *fp;
	fp = fopen("graph.txt","w"); 	// Connecting to the required output file
	struct timeval tv;
	double start,end,elapse;
	for(i=100;i<=1000;i+=100) 		// Looping through all the array sizes
	{
		get_number(a,i); 			// Invoking function to genrate random i numbers
		gettimeofday(&tv,NULL); 	// Storing the system time
		start = tv.tv_sec + ( tv.tv_usec / 1000000.0);
		quicksort(a,0,i-1); 		// Invoking a procedure to sort the array
		gettimeofday(&tv,NULL); 	// Storing the system time
		end = tv.tv_sec + (tv.tv_usec/1000000.0);
		elapse = end - start; 		// Finding the time taken to sort
		fprintf(fp, "%d\t%lf\n",i,elapse); // Storig the result in a file
	}
	fclose(fp);
	return 0;
}
