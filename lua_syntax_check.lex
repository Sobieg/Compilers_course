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
"--[[".*?|[\n]*?"]]--"			{
								printf("KEK\n");
								return 0;
							}
.			 				{
							printf("%c", *yytext);	
							}
%%
