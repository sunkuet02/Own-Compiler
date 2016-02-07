%{
	#include <stdio.h>
	#include <string.h>
	#include <stdlib.h>
	#include "b.tab.h"
%}

%option noyywrap

comment     "/*"((\*+[^/*])|([^*]))*\**"*/"|("//".*)

digit	[0-9]
number	{digit}*[.]?{digit}+

%%
{digit}+		{  yylval = atoi(yytext); return NUMBER;}
jodi      		{return IFC ; }
nahoy 			{return ELSEC ;}
jog 			{return PLUS ;}
biyog 			{return MINUS; }
gun 			{return MULTIPLY ; }
vag 			{return DIVIDE ; }
vagsesh			{return MODULAR ; }
power			{return POWER ; }
equal 			{return EQUAL ;}
fac				{return FACTORIAL ; }
cosine			{return COS; }
sine 			{return SINE ;}
tangent 		{return TAN ; }
elog			{return LN ; }
[,]				{return *yytext;}
"("				{return FBRS ; }
")"				{return FBRE ; }
greaterthan		{return GREATERTHAN;}
lessthan		{return LESSTHAN; }
[a-zA-Z]		{ yylval = *yytext;  return VARIABLE;}
start_of_program {return START ;}
print 			{return PRINT; }
[ \t\n]	
{comment}


%%

int main()
{
	yyin = freopen("input.txt", "r",stdin);
	freopen("output.txt","w",stdout);
	yyparse();
	return 0;
}