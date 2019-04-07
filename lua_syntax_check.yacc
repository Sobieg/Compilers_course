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
%token VAR NUM


%%
	program: 		OPS;

	OPS: 			;
%%

int main() {
	return yyparse();
}
