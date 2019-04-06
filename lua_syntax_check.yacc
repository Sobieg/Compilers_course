%{
	#include <iostream>	
%}



%token AND BREAK DO ELSE ELSEIF END FALSE GOTO FOR FUNCTION IF IN 
%token LOCAL NUK NOT OR REPEAT RETURN THEN TRUE UNTIL WHILE


%%
	program: 		OPS;

	OPS: 			;
%%

int main() {
	return 0;
}
