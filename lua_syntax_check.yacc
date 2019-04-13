%{
	#include <iostream>	
	extern int yylineno;
	extern int yylex();
	void yyerror(char *s) {
		std::cerr << s << ", line " << yylineno << std::endl;
		exit(1);
	}
%}



%token AND BREAK DO ELSE ELSEIF END FALSE GOTO FOR FUNCTION IF IN 
%token LOCAL NIL NOT OR REPEAT RETURN THEN TRUE UNTIL WHILE
%token VAR NUM STRING NIL


%%
	program: 		ops;

	ops: 			op | ops op;

	op:				expr; //there

	expr:			VAR '=' VAR 
					| VAR '=' value
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
		


%%

int main(int argc, char** argv) {
	//yyparse();
	std::cout << (!yyparse()? "OK" : "Not OK") << std::endl;
}
