%{
	#include <iostream>	
	extern int yylineno;
	extern int yylex();

	extern int yy_flex_debug;

	#define YYPRINT(file, type, value) fprintf(file, "%d", value);

	void yyerror(char *s) {
		std::cerr << s << ", line " << yylineno << std::endl;
		exit(1);
	}
%}



%token AND BREAK DO ELSE ELSEIF END FALSE GOTO FOR FUNCTION IF IN 
%token LOCAL NIL NOT OR REPEAT RETURN THEN TRUE UNTIL WHILE
%token ID NUM STRING 


%%
	program: 		ops;

	ops: 			op | ops op;

	op:				expr
					| func_call
					; 

	exprs:			expr
					| exprs expr
					|
					;

	expr:			ID '=' ID 
					| ID '=' value
					;
	
	value:			NUM 
					| STRING
					| TRUE
					| FALSE
					| NIL
					| '-' value
					| '!' value
					| '(' expr ')'
					;

	func_call:		ID '(' func_args ')'
					| ID single_arg
					;

	func_args:		func_arg 
					| func_args ',' func_arg
					;

	func_arg:		TRUE
					| FALSE
					| STRING
					| ID
					| NUM
					| table
					;
	single_arg:		STRING
					| table
					;
	
	table: 			'{' exprs '}'

					;


%%

int main(int argc, char** argv) {
	yy_flex_debug = 0;
	yydebug = 0;
	std::cout << (!yyparse()? "OK" : "Not OK") << std::endl;
}
