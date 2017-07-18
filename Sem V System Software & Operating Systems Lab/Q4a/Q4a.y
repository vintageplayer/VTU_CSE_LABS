%{
	#include<stdio.h>
	#include<stdlib.h>
%}
%token ID NUMBER
%left '+' '-'
%left '/' '*'
%%
expression : expression '+' expression
	| expression '-' expression
	| expression '/' expression
	| expression '*' expression
	| ID
	| NUMBER
	;
%%
int yyerror()
{
	printf("\nEntered expression is invalid!!\n");
	exit(0);
}

int main()
{
	printf("Enter an arithmetic expression : ");
	yyparse();
	printf("\nEntered expression is valid.\n");
	return 0;
}
