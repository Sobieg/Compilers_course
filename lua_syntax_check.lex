%{
	#include <iostream>	
	#include "y.tab.h"
	void yyerror(char *s);
%}

%option yylineno
%option noyywrap

/*
for tests 
%option main
*/
string "[["([\]][ \n]+|[^\]][^\]]|\n)*?"]]"


%%
"and"						{return AND;}
"break"						return BREAK;
"do"						return DO;
"else" 						return ELSE;
"elseif"					return ELSEIF;
"end"						return END;
"false" 					return FALSE;
"goto"						return GOTO;
"for"						return FOR;
"function"					return FUNCTION;
"if"						return IF;
"in"						return IN;
"local"						return LOCAL;
"nil"						return NIL;
"not" 						return NOT;
"or"						return OR;
"repeat"					return REPEAT;
"return"					return RETURN;
"then"						return THEN;
"true"						return TRUE;
"until"						return UNTIL;
"while"						return WHILE;
"nil"						return NIL;



[0-9]+						{	
								return NUM;
							}
[0-9]"."[0-9]+				{
								return NUM;
							}

[a-zA-Z_]+[a-zA-Z0-9_]*		{
								//std::cout << "ID" << std::endl;
								return ID;
							}

'[^'\n]*'					{
								//std::cout << "STRING" << std::endl;
								return STRING;

							}

\"[^"\n]*\"					{
								//std::cout << "STRING" << std::endl;
								return STRING;
							}

string 						{

								//std::cout << "STRING" << std::endl;
								return STRING;
							}

"--"string	{
								//printf("Multiline comment\n");
								//return 0;
							}

"--".*?						{
								//printf("Singleline comment\n");
								//return 0;
							}

[ \t\r\n] 					{}

.			 				{							
							//printf("%c", *yytext);
							return *yytext;	
							}
%%
