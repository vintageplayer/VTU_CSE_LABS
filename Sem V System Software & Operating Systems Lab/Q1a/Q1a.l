%{
	int cc=0,wc=0,sc=0,lc=0;
%}
%%
[^ \t\n]+  	{wc++; cc+=yyleng;}
[ ]+		{cc+=yyleng; sc+=yyleng;}
[\t]		{cc+=3; sc+=3;}
[\n]		{cc+=1; lc+=1;}
%%
int main(int argc,char *argv[])
{
	if(argc!=2)
	{
		printf("\nInvalid number of argument!!");
	}
	else
	{
		yyin = fopen(argv[1],"r");
		yylex();
		printf("Number of words : %d.",wc);
		printf("\nNumber of lines : %d.",lc);
		printf("\nNumber of spaces : %d.",sc);
		printf("\nNumber of characters : %d.",cc);
	}
	printf("\nExiting...\n");
	return 0;
}
