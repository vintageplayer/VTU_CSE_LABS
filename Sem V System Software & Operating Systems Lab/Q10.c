#include<stdio.h>
#include<stdlib.h>

#define MAX_PROCESSES 10
#define MAX_TIME 9999

typedef struct
{
	int name;
	int at;
	int burst;
	int wait;
	int TAT;
	int remaining;
}process;

int Input(process p[])
{
	int n,i;
	printf("\nEnter number of processes : ");
	scanf("%d",&n);

	while(n<1 || n>MAX_PROCESSES)
	{
		printf("\nInvalid number of processes. Minimum is 1 and maximum is 10!");
		printf("\nEnter number of processes : ");
		scanf("%d",&n);
	}

	for(i=0;i<n;i++)
	{
		printf("\nFor process : %d",(i+1));
		printf("\nEnter process name : ");
		scanf("%d",&p[i].name);
		printf("\nEnter the arrival time : ");
		scanf("%d",&p[i].at);
		printf("\nEnter the burst time : ");
		scanf("%d",&p[i].burst);
	}

	return n;
}

void SJR(process p[],int n)
{
	int TAT = 0,i,TBT=0,j,min_time,min_p;
	for(i=0;i<n;i++)
	{
		TBT += p[i].burst;
		p[i].remaining = p[i].burst;
		p[i].wait = 0;
	}

	for(i=0;i<TBT; i++)
	{
		min_time = MAX_TIME;

		for(j=0;j<n;j++)
		{
			if(p[j].at<=i && p[j].remaining < min_time && p[j].remaining >0)
			{
				min_p = j;
				min_time = p[j].remaining;
			}
		}

		p[min_p].remaining = p[min_p].remaining - 1;

		for(j=0;j<n;j++)
		{
			if(p[j].at<=i && p[j].remaining > 0 && j!= min_p)
				p[j].wait += 1;
		}
	}

	for(i=0;i<n;i++)
	{
		p[i].TAT = p[i].burst + p[i].wait;
		TAT += p[i].TAT;
	}

	printf("\n\nSummary :\n");
	printf("Name\tArrival Time\tBurst Time\tWait Time\tTurn Around Time\n");

	for(i=0;i<n;i++)
		printf("\nP%d\t%d\t\t%d\t\t%d\t\t%d",p[i].name,p[i].at,p[i].burst,p[i].wait,p[i].TAT);

	printf("\n\nAverage Turn Around time : %f",(float)TAT/n);

}

void RR(process p[],int n)
{
	int quantum,finished=0,i,j,TAT=0,wait_time;
	printf("\nEnter the time quantum : ");
	scanf("%d",&quantum);
	while(quantum<0)
	{
		printf("\nInvalid value for time quantum!! Re-enter : ");
		scanf("%d",&quantum);
	}

	for(i=0;i<n;i++)
	{
		p[i].remaining	= p[i].burst;
		p[i].wait	= 0;
	}

	printf("\nProcesses are scheduled in the following manner :\n");

	while(finished<n)
	{
		for(i=0;i<n;i++)
		{
			if(p[i].remaining>0)
			{
				printf("p%d ",i+1);

				if(p[i].remaining <= quantum)
				{
					wait_time	= p[i].remaining;
					p[i].remaining	= 0;
					finished++;
				}
				else
				{
					p[i].remaining -= quantum;
					wait_time	= quantum;
				}

				for(j=0;j<n;j++)
				{
					if(i!=j && p[j].remaining > 0)
						p[j].wait += wait_time;
				}

			}
		}
	}

	for(i=0;i<n;i++)
	{
		p[i].TAT = p[i].burst + p[i].wait;
		TAT += p[i].TAT;
	}

	printf("\n\nSummary :\n");
	printf("Name\tBurst Time\tWait Time\tTurn Around Time\n");

	for(i=0;i<n;i++)
		printf("\nP%d\t%d\t\t%d\t\t%d",p[i].name,p[i].burst,p[i].wait,p[i].TAT);

	printf("\n\nAverage Turn Around time : %f",(float)TAT/n);
	
}

int main()
{
	int o;
	int n;
	int flag = 0;
	process p[MAX_PROCESSES];
	while(1)
	{
		printf("\n\n\t\tApplication to schedule processes\n");
		printf("\n1) Input new set of values.");
		printf("\n2) Perform the Shortest Remaining Time First procedure.");
		printf("\n3) Perform the Round Robin procedure.");
		printf("\n4) Exit.");
		printf("\n\nEnter desired option number : ");
		scanf("%d",&o);
		switch(o)
		{
			case 1:
				n	= Input(p);
				flag	= 1;
				break;

			case 2:
				if(flag == 1)
					SJR(p,n);
				else
					printf("\nYou need to input information about the processes!");
				break;

			case 3:
				if(flag == 1)
					RR(p,n);
				else
					printf("\nYou need to input information about the processes first!");
				break;

			case 4:
				exit(0);

			default:
				printf("\nInvalid Option!!");
		}
	}
}
