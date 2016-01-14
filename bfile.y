%{
	#define YYSTYPE double
	#include <malloc.h>
	#include <stdlib.h>
	#include <stdio.h>
	#include <math.h>
%}


%token NEWLINE NUMBER PLUS MINUS POWER FACT
%left POWER FACT PLUS MINUS

%%
input:	
		| input line
		;
		
line:	NEWLINE
		| exp NEWLINE { printf("\t%.10g\n",$1);}
		;
		
exp:		NUMBER			{$$ = $1; }
		| exp PLUS exp		{$$ = $1 + $3; printf("E->E+E\t\t");}
		| exp MINUS exp 	{$$ = $1 - $3;printf("E->E-E\t\t");}
		| exp POWER exp		{$$ = pow($1,$3);printf("E->E^E\t\t");}
		| exp FACT			{ int res = 1, i; for(i = 1 ; i<=$1 ; i++ ) res *= i; $$ = res ; printf("E->E!\t\t"); }
		;


%%

int yyerror(char *s)
{
	printf("%s\n",s);
	return(0);
}

int main(void)
{
	yyparse();
	exit(0);
}