%{
	#include <stdio.h>
	#include <string.h>
	#include <stdlib.h>
	#include "bfile.tab.h"
	extern YYSTYPE yylval;
%}

%option noyywrap

delim [ \t]
whitesp {delim}+
digit [0-9]
number {digit}*[.]?{digit}+

%%

{number}		{ sscanf(yytext,"%lf",&yylval); return NUMBER;}
"+"				{ return PLUS;}
"-"				{ return MINUS;}
"^"				{return POWER;}
"!" 			{return FACT;}
"\n"			{ return NEWLINE;}
{whitesp}		{ /*no action and no return */}

