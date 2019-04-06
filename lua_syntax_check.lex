%{
	#include <stdio.h>	
%}

%option yylineno
%option noyywrap

/*
for tests 
*/
%option main



%%
"//".*						{printf("C -comment");}
"--[[".*"]]--"				{printf("KEK\n");}
"--[["[\n*?\S]*?"]]--"				{printf("KEK\n");}
.			 					{printf("%c", *yytext);	}
%%

