%{
	#include<stdlib.h>
	int a[4] = {0,0,0,0},valid = 1,nop=0;
%}
%x OPER
%%
[a-zA-Z0-9]+		{nop++; BEGIN OPER; printf("\nOperand : %s",yytext);}
<OPER>"+"		{ if(!valid) ext(); valid=0; a[0]++; printf("\nOperator : +"); }
<OPER>"-"		{ if(!valid) ext(); valid=0; a[1]++; printf("\nOperator : -"); }
<OPER>"*"		{ if(!valid) ext(); valid=0; a[2]++; printf("\nOperator : *"); }
<OPER>"/"		{ if(!valid) ext(); valid=0; a[3]++; printf("\nOperator : /"); }
<OPER>[a-zA-Z0-9]	{ if(valid) ext(); nop++; valid=1; printf("\nOperator : %s",yytext);}
<OPER>.			{ ext(); }
<OPER>[\n]		{ if(valid) return 0; else ext();}
.			ext();
[\n]			ext();
%%
int ext()
{
	printf("\nThe entered expression is invalid!!");
	printf("\nExiting...");
	exit(1);
}
int main()
{
	printf("Enter an arithmetic expression : ");
	yylex();
	printf("\nThe entered expression is valid.");
	printf("\nNumber of + operators : %d",a[0]);
	printf("\nNumber of - operators : %d",a[1]);
	printf("\nNumber of * operators : %d",a[2]);
	printf("\nNumber of / operators : %d",a[3]);
	return 0;
}
