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
%token FNAME
%token NE EQ LE GE
%token CONC DOTS

%start program

%%

	program:		stmt_list
					;

	stmt_list:		stmt
					| stmt_list stmt
					| stmt_list ',' stmt
					;
	
	stmt:			stmt1
					;

	stmt1:			
					id_list '=' stmt_list
					| expr_boolean_list
					| IF expr_boolean_list THEN stmt_list elsif_block
					| WHILE expr_boolean_list DO stmt_list END
					| FOR stmt_list DO stmt_list END
					| FOR stmt_list IN stmt_list DO stmt_list END
					| REPEAT stmt_list UNTIL expr_boolean_list
					| function ID '(' stmt_list ')' stmt_list END
					| function ID '(' ')' stmt_list END
					| function FNAME '(' stmt_list ')' stmt_list END
					| function FNAME '(' ')' stmt_list END
					| function '(' stmt_list ')' stmt_list END
					| function '(' ')' stmt_list END
					| ID '(' stmt_list ')'
					| ID '(' DOTS ')'
					| ID table
					| ID STRING
					| id ';'
					| RETURN
					| table
					| ID '(' '[' term1 ']' ')'
					| ID '[' stmt_list ']'
					| stmt1 EQ stmt1
					;


	table:			'{' assign_list '}'
					| '{' '}'
					;

	assign_list:	assign
					| assign_list ',' assign
					;

	assign:			ID '=' expr2
					| '[' stmt_list ']' '=' expr2
					| expr2
					;


	
	elsif_block:	END
					| ELSE stmt_list END
					| ELSEIF stmt_list THEN stmt_list elsif_block
					;
	


	id_list:		LOCAL nl_id_list
					| nl_id_list
					;
	
	nl_id_list:		ID 								{/*not local id list*/}
					| nl_id_list ',' ID
					;

	expr_boolean:	NOT expr_boolean
					| expr2_list				 		{/*в Lua все может быть кастнуто к bool*/}
					| expr2 EQ expr2
					| expr2 LE expr2
					| expr2 GE expr2
					| expr2 NE expr2
					| expr2 '<' expr2
					| expr2 '>' expr2
					;

	expr_boolean_list:
					expr_boolean
					| expr_boolean_list ',' expr_boolean
					| expr_boolean_list AND expr_boolean
					| expr_boolean_list OR expr_boolean
					;
	
	expr2:			term
					| expr2 '+' term
					| expr2 '-' term
					;

	expr2_list:		expr2
					| expr2_list ',' expr2
					;


	
	term:		
					 term1
					| term '*' rnumval
					| term '/' rnumval
					| term '%' rnumval
					;
	
	
	term1:			rnumval
					| string
					| FNAME '(' expr2_list ')'
					| ID '(' expr2_list ')'
					;
					
	string:			STRING	
					| string CONC STRING
					| string CONC ID
					;

	id:				ID
					| LOCAL ID
					;

	function:		FUNCTION
					| LOCAL FUNCTION
					;
	

	rnumval:		NUM
					| nl_id_list 					{/*такое поведение вызывает reduce/reduce конфликт с 
												nl_id_list. Я не придумал, как поправить его, но работает правильно 
												(по-умолчанию выбирается reduce в rnumval)
											*/}
					| '(' expr2 ')'
					| FALSE
					| TRUE
					| FNAME
					;





%%

int main(int argc, char** argv) {
	yy_flex_debug = 0;
	yydebug = 0;
	std::cout << (!yyparse()? "OK" : "Not OK") << std::endl;
}
