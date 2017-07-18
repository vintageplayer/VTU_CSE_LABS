%{
	#include<stdio.h>
	#include<stdlib.h>
%}
%token LETTER DIGIT
%%
variable : variable DIGIT
	| variable LETTER
	| LETTER
	;
%%
int yyerror()
{
	printf("\nInvalid variable name!!");
	exit(0);
}
int main()
{
	printf("\nEnter a variable name : ");
	yyparse();
	printf("\nThe entered name is valid.\n");
	return 0;
}
