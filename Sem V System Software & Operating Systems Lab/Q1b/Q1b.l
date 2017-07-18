%{
	int count=0;
%}
%x COMMENT
%%
"/*".*"*/"	{count++;}
"//".*		{count++;}
"/*"		{count++; BEGIN COMMENT;}
<COMMENT>"*/"	{BEGIN 0;}
<COMMENT>[\n]	{count++;}
<COMMENT>.	;
%%
int main(int argc,char *argv[])
{
	if(argc!=3)
	{
		printf("Invalid arguments!!");
		printf("\nExiting...\n");
		return 1;
	}
	yyin = fopen(argv[1],"r");
	yyout = fopen(argv[2],"w");
	yylex();
	fclose(yyin);
	fclose(yyout);
	printf("Number of comment lines = %d.",count);
	return 0;
}
