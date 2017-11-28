/*
	Write a C program to implement the syntax-directed definition of "if E then S1" and "if E then S1 else S2".
*/

#include<stdio.h>
#include<string.h>


void gen(char actions[][100],int count)
{
	char l1='S',l2='A',l3='B';
	
	printf("\nif %s GOTO %c",actions[0],l1);
	printf("\nGOTO %c",l2);
	printf("\n%c : %s",l1,actions[1]);
	
	if(count<3)
	{
		printf("\n%c : STOP\n",l2);
	}
	else
	{
		printf("\nGOTO %c",l3);
		printf("\n%c : %s",l2,actions[2]);
		printf("\n%c : STOP\n",l3);
	}
}

int main()
{
	char text[3][100],string[100];
	int i,j,index,count=0;
	
	printf("Sample if-statements :\n");
	printf("\t1) if (a>b) then (s=a);\n");
	printf("\t2) if (a>b) then (s=a) else (s=b);\n");
	
	printf("\nEnter an if statement :\n");
	gets(string);
	
	for(i=0; string[i]!='\0' && string[i]!=';';i++)
	{
		if(string[i] == '(')
		{
			index = 0;
			for(j=i; string[j-1]!=')';j++)
			{
				if(string[j]=='\0')
				{
					printf("\nIllegal if statement. Exiting...\n");
					return 1;
				}
				text[count][index++] = string[j];
			}
			
			i	= j-1;
			count++;
		}
	}
	
	if(count<2)
	{
		printf("\nIllegal if statement!! Exiting...");
		return 0;
	}
	gen(text,count);
	
	return 0;
}
