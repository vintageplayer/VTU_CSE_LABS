%{
	int flag = 1;
%}
%%
" "("and"|"or"|"because"|"but")" " flag = 0;
.	;
[\n] return 0;
%%
int main()
{
	printf("Enter a sentence : ");
	yylex();
	if(flag==1)
		printf("\nA simple sentece is entered.\n");
	else
		printf("\nA compound sentence is entered.\n");
	return 0;
}
