#include<iostream>
#include<string.h>

using namespace std;

int CRC(char input[],char output[],char gp[], int mode)
{
	int  i,j;
	strcpy(output,input);
	
	if(!mode)
	{
		j = strlen(output);
		for(i=0;i<strlen(gp);i++)
		{
			output[j+i] = '0';
		}
		output[j+i-1] = '\0';
	}
	
//	for(i=0 ; i<=(strlen(output)-strlen(gp)) ; i++)
	for(i=0 ; i<(strlen(input)) ; i++)
	{
		//cout<<"Reached 1. i :  "<<i;
		if(output[i]=='1')
		{
			for(j=0;j<strlen(gp);j++)
			{
				if( (output[j+i]=='1' && gp[j]=='0') || (output[j+i]=='0' && gp[j]=='1') )
				{
					output[j+i] = '1';
				}
				else
				{
					output[j+i] = '0';
				}
			}
		}
	}
	cout<<"Calcualted checksum : "<<output;
	for(i=0;i<strlen(output);i++)
	{
		if(output[i]=='1')
			return 0;
	}
	return 1;
}

int main()
{
	char input[100],output[100],gp[18]="10001000000100001";
	cout<<"Enter message in binary format : ";
	cin>>input;
	
	CRC(input,output,gp,0);
	
	cout<<"\nEncoded message is : "<<input<<output+strlen(input)<<endl;
	
	cout<<"Enter message received : ";
	cin>>input;
	
	if(CRC(input,output,gp,1))
	{
		cout<<"Message was transmitted without any error."<<endl;
	}
	else{
		cout<<"Error in message transmission!!"<<endl;
	}
	
	return 0;
}
