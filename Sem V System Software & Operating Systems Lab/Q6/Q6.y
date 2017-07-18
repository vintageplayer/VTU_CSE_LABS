%{
	#include<stdio.h>
	#include<stdlib.h>
	int count=0;
%}
%token A B
%%
statement : expression B
	;
expression : A	{count++;}
	| expression A 	{count++;}
	;
%%
int yyerror()
{
	printf("\nInvalid string!!");
	printf("\nExiting...");
	exit(0);
}
int main()
{
	printf("Enter a string : ");
	yyparse();
	if(count>=10)
		printf("Entered string is valid.\n");
	else
		printf("Entered string is invalid.\n");
	return 0;
}
