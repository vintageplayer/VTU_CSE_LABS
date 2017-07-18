%{
	#include<stdio.h>
	#include<string.h>
	#include<ctype.h>
	char productions[100][100],temp[100],complete[100];
	int count=0;
	
	int getREIndex(char *);
%}
%token ALPHABET
%left '|'
%left '.'
%nonassoc '*' '+'
%%
S	: re '\n'	{
				printf("Right most derivation : \n");
				printf(" re => %s\n",productions[--count]);
				strcpy(temp,productions[count]);
				int j;
				while(count>0)
				{
					j = getREIndex(temp);
					temp[j] = '\0';
					sprintf(complete, "%s%s%s", temp,productions[--count],(temp+j+2));
					strcpy(temp,complete);	
					printf("\t=> %s\n",complete);
				}
				
				return 0;
			}

re	: ALPHABET {
		productions[count][0] = yylval;
		productions[count++][1]	= '\0';
	}
	| re '.' re	{ strcpy(productions[count++], "re . re");}
	| '(' re ')'	{ strcpy(productions[count++], "( re )");}
	| re '+'	{ strcpy(productions[count++], "re + re");}
	| re '*'	{ strcpy(productions[count++], "re*");}
	| re '|' re	{ strcpy(productions[count++], "re | re");}
	;

%%
yyerror()
{
	printf("Invalid Reqular Expression!! Exiting...\n");
	exit(1);
}

yylex()
{
	yylval = getchar();
	if(isalpha(yylval))
	{
		return ALPHABET;
	}
	
	return yylval;
}

int main()
{
	printf("Enter a regular expression : \n");
	yyparse();
	
	return 0;
}

int getREIndex(char *string)
{
	int i;
	for(i=strlen(string);i>0;i--)
	{
		if(string[i]=='e' && string[i-1]=='r')
			return i-1;
	}
	return -1;
}
