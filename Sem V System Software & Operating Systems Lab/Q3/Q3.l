%{
	int count=0;
%}
DEC (" "|"\t")+("int"|"float"|"char"|"long")(" "|"\t")+
ID [a-zA-Z][a-zA-Z0-9]*
%x DEFN
%%
{DEC}		{BEGIN DEFN;}
<DEFN>{ID}	{count++; printf("\n%s",yytext);}
<DEFN>" "	;
<DEFN>","	;
<DEFN>";"	{BEGIN 0;}
.		;
\n		;
%%
int main(int argc,char *argv[])
{
	if(argc!=2)
	{
		printf("Invalid arguments!!");
		printf("\nExiting...");
		return 1;
	}
	yyin = fopen(argv[1],"r");
	yylex();
	printf("\nNumber of identifiers : %d\n",count);
	return 0;
}
