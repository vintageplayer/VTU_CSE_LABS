#include<iostream>
#include<stdio.h>
#include<stdlib.h>
#include<sys/time.h>
#include<omp.h>

using namespace std;

void merge(int a[],int b[],int c[],int m,int n) // Function to merge 2 arrays into 1
{
	int i=0,j=0,k=0;
	#pragma omp parallel
	#pragma omp while
	{
		while(i<m && j<n) 				// While elements of both arrays are left
		{
			if(b[i]<c[j]) 				// If first array element is smaller
			{
				a[k] = b[i];
				i++;
			}
			else
			{
				a[k] = c[j];
				j++;
			}
			c++;
		}
		while(i<m) 					   // Mergin the remaining elements if any
		{
			a[k] = b[i];
			i++;
		}
		while(j<n)					   // Mergin remaining elements if any
		{
			a[k] = c[j];
			j++;
		}
	}
}

void mergesort(int a[],int n)	  // Function to split array into 2 
{
	if(n>1)
	{
		int l,r,i;
		l = n/2; 
		r = n - l;
		int b[l],c[r];
		for(i=0;i<l;i++)
			b[i] = a[i];
		for(i=0;i<r;i++)
			c[i] = a[i+l];
		mergesort(b,l);
		mergesort(c,r);
		merge(a,b,c,l,r);
	}
}

void get_number(int a[],int n) 	// Genrating random n nunbers to be sorted
{
	int i;
	for(i=0;i<n;i++)
		a[i] = rand() % 1000;
}

int main()
{
	int i,a[1000];
	double start,end,elapse;
	struct timeval tv;
	FILE *fp;
	fp = fopen("grapht.txt","w");		  // Connecting to the file to store result
	for(i=100;i<=1000;i+=100)
	{
		get_number(a,i); 				  // Invoking function to get numbers to be sorted
		gettimeofday(&tv,NULL);   		  // Storing the current system time
		start = tv.tv_sec + (tv.tv_usec/1000000.0);
		mergesort(a,i); 		  		  // Invoking function to sort the elements
		gettimeofday(&tv,NULL);   		  // Storing the current system time
		end = tv.tv_sec + (tv.tv_usec/1000000.0);
		elapse = end - start; 	  		  // Calculating time taken to sort
		fprintf(fp, "%d\t%lf\n",i,elapse);// Storing result in the file
	}
	fclose(fp);
	return 0;
}