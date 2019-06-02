%{
	#include <iostream>	
	#include "y.tab.h"
	void yyerror(char *s);
%}

%option yylineno
%option noyywrap

/*
/*string ({single_string})([ \t\r\n]*".."[ \t\r\n]*({single_string}|{id}))*
/*stingid {id}([ \t\r\n]*".."[ \t\r\n]*({single_string}|{classid}|{id}))+
/**/

rigtend "]=]"
lefend "[=["
multiline_string (("[["([^]]*|[]]{1})"]]")|("[=["([^]*]|("]"[^=])*|("]="[^]])*)"]=]"))
instring_1 ([^\\\n"]|\\\n|\\["']|\\\\|\\n|\\[0-9]{1,3}|\\r|\\t|\\"["|\\"]"|\\a|\\f|\\z|\\v|\\b)*
instring_2 ([^\\\n']|\\\n|\\["']|\\\\|\\n|\\[0-9]{1,3}|\\r|\\t|\\"["|\\"]"|\\a|\\f|\\z|\\v|\\b)*
single_id [a-zA-Z_]+[a-z0-9_]*
single_string ["]{instring_1}["]|[']{instring_2}[']
string ({single_string})
stingid {single_string}
id ({single_id}("."{single_id})+)|{single_id}
classid {id}(":"{id})+
onesymb [-+*/%=<>().,{}^]
whitespace [ \t\r\n]
int [0-9]+
double [0-9]"."[0-9]+
hex "0x"[0-9a-fA-F]+

%%
"and"						return AND;
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
"~="						return NE;
"=="						return EQ;
"<+"						return LE;
">="						return GE;
".."						return CONC; //только на случай, если к переменной клеится строка или переменная к строке или две переменных. Случай строка-строка разобран
"..."						return DOTS;
{onesymb}					{
								// std::cout << *yytext << std::endl;
								return *yytext;
							}


"debug"						{	
								std::cout << "Debug switched" << std::endl;
								yydebug = yydebug?0:1;
							}

{single_id}					{	
								// std::cout << "ID" << std::endl;
								return ID;
							}

{id}						{
								// std::cout << "ID" << std::endl;
								return ID;
							}
{classid}					{
								// std::cout << "ID" << std::endl;
								return ID;
							}

{int}					{	
								// std::cout << yytext << std::endl;
								return NUM;
							}
{double}			{
								// std::cout << yytext << std::endl;
								return NUM;
							}
{hex}						{return NUM;}


{string} 					{

								 //std::cout << yytext << std::endl;
								return STRING;
							}

{stingid}					{
								//std::cout << yytext << std::endl;
								return STRING;
							}

{multiline_string}			{
								// std::cout << "Multiline string" << std::endl;
								return STRING;
							}


"--"{multiline_string}	{
								//printf("Multiline comment\n");
								//return 0;
							}

"--".*?						{
								//printf("Singleline comment\n");
								//return 0;
							}

[ \t\r\n] 					{}

. 							{return *yytext;}
%%