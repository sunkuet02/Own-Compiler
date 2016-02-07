%{
	#include <stdio.h>
	#include <math.h>
	#include <stdlib.h>
	#include <string.h>
	#define PI 3.141593

	int variableValue[125];
%}

%token IFC ELSEC PLUS MINUS MULTIPLY DIVIDE MODULAR POWER ASSIGN FACTORIAL 
%token COS SINE TAN LN FBRS FBRE SBRS SBRE NUMBER VARIABLE START PRINT
%token LESSTHAN GREATERTHAN EQUAL

%nonassoc IFC
%nonassoc ELSEC

%left ASSIGN
%left PLUS MINUS
%left MULTIPLY DIVIDE
%left MODULAR
%right POWER
%left FACTORIAL
%nonassoc LESSTHAN GREATERTHAN

%%

stat: 
	| stat statement
	;
statement:  PRINT expr ','    		{printf("Exp: %d\n",$2);}
	| VARIABLE EQUAL expr ',' 		{variableValue[$1] = $3 ;}
	| IFC first expr last expr ',' %prec IFC {
								if($3){
									printf(" Value of Exp : %d \n",$5);
								}
							}
	| IFC first expr last expr  ELSEC  expr ',' {
								if($3){
									printf("Value of Exp in Jodi cond. : %d \n" , $5);
								}
								else{
									printf("Value of Exp in Nahoy cond. : %d \n",$7);
								}
							}
	;

expr: NUMBER 
	|VARIABLE 				{$$ = variableValue[$1] ;}
	| expr PLUS expr		{$$ = $1 + $3; }
    | expr MINUS expr		{$$ = $1 - $3;}
    | expr MULTIPLY expr	{$$ = $1 * $3;}
    | expr DIVIDE expr		{if($3) $$ = $1 / $3; else printf("\nDIVISION BY ZERO\n"); }
    | expr POWER expr		{$$ = pow($1, $3);}
    | expr MODULAR expr  	{$$ = $1 % $3;}
    | expr FACTORIAL		{int f=1; int i; for(i=1; i<=$1; i++) f*= i; $$= f;}
    | expr LESSTHAN expr 	{$$ = $1 < $3;}
    | expr GREATERTHAN expr {$$ = $1 > $3;}
    | first expr last 		{$$ = $2;}
    | SINE first expr last	{  printf("%lf\n", sin($3 * PI / 180.0)); }
    | COS first expr last	{  printf("%lf\n", cos($3 * PI / 180.0) ); }
    | TAN first expr last	{  printf("%lf\n", tan($3 * PI / 180.0)); }
    | LN first expr last		{  printf("%lf\n", log($3)); }
    ;
first: FBRS
;
last: FBRE
;
%%

yyerror(char *s) /* called by yyparse on error */
{
	printf("%s\n",s);
	return (0);
}
