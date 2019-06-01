%{
	#include <iostream>	
	extern int yylineno;
	extern int yylex();

	#define YYPRINT(file, type, value) fprintf(file, "%d", value);

	void yyerror(char *s) {
		std::cerr << s << ", line " << yylineno << std::endl;
		exit(1);
	}
%}




%%

d:      d "0"
        | "0"
        ;


%% 

int main() {
    return yyparse();
}