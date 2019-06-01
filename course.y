%{
	#include <iostream>	
	extern int yylineno;
	extern int yylex();

	extern int yy_flex_debug;
    void yyerror(char *s);

	#define YYPRINT(file, type, value) fprintf(file, "%d", value);


%}

/*LOCAL приходится отличать в яке, потому что локал может быть почти все, 
но не когда оно передается в качестве аргумента
но некогда оно передается в качестве аргумента (там просто не надо писать LOCAL)*/

%token AND BREAK DO ELSE ELSEIF END FALSE GOTO FOR FUNCTION IF IN 
%token LOCAL NIL NOT OR REPEAT RETURN THEN TRUE UNTIL WHILE
%token ID FID NUM STRING 
%token FNAME
%token NE EQ LE GE
%token CONC DOTS

%%
    program:                        list_of_statements
                                    ;

    list_of_statements:             statement
                                    | list_of_statements statement
                                    ;

    statement:                      list_of_id '=' list_of_assignable
                                    | LOCAL list_of_id '=' list_of_assignable
                                    | LOCAL list_of_id ';'
                                    | LOCAL list_of_id
                                    | func_def
                                    | func_call
                                    | RETURN func_returnable
                                    | IF expr THEN list_of_statements elseif_block
                                    | WHILE expr DO list_of_statements END
                                    | REPEAT list_of_statements UNTIL expr
                                    | FOR ID '=' list_of_assignable DO list_of_statements END
                                    | FOR list_of_id IN assignable DO list_of_statements END
                                    ;

    elseif_block:                   END
                                    | ELSE list_of_statements END
                                    | ELSEIF expr THEN list_of_statements elseif_block
                                    ;

    
    list_of_id:                     ID
                                    | list_of_id ',' ID
                                    ;

    list_of_assignable:             list_of_assignable ',' expr
                                    | expr
                                    ;

    list_of_assignable_without_func_def:
                                    list_of_assignable_without_func_def ',' expr_without_func_def {/*аааааа пришлось делать, потому что функция может возвращаться только если она без имени, но может быть присвоена без имени*/}
                                    | expr_without_func_def
                                    ;

    expr_without_func_def:          NOT expr_without_func_def  
                                    | assignable_without_func_def EQ expr_without_func_def
                                    | assignable_without_func_def NE expr_without_func_def
                                    | assignable_without_func_def LE expr_without_func_def
                                    | assignable_without_func_def GE expr_without_func_def
                                    | assignable_without_func_def '<' expr_without_func_def
                                    | assignable_without_func_def '>' expr_without_func_def
                                    | assignable_without_func_def AND expr_without_func_def
                                    | assignable_without_func_def OR expr_without_func_def
                                    | assignable_without_func_def ',' expr_without_func_def
                                    | assignable_without_func_def '+' expr_without_func_def        
                                    | assignable_without_func_def '-' expr_without_func_def
                                    | assignable_without_func_def '*' expr_without_func_def
                                    | assignable_without_func_def '/' expr_without_func_def
                                    | assignable_without_func_def '%' expr_without_func_def 
                                    | '(' expr_without_func_def ')'
                                    | assignable_without_func_def
                                    ;

    assignable_without_func_def:    ID
                                    | NUM
                                    | '-' NUM   
                                    | STRING
                                    | NIL  
                                    | TRUE
                                    | FALSE
                                    | func_call
                                    | table_index
                                    | table_def
                                    ;

    table_index:                    ID '[' expr ']'
                                    ;

    expr:                           NOT expr   
                                    | assignable EQ expr
                                    | assignable NE expr
                                    | assignable LE expr
                                    | assignable GE expr
                                    | assignable '<' expr
                                    | assignable '>' expr
                                    | assignable AND expr
                                    | assignable OR expr
                                    | assignable ',' expr
                                    | assignable '+' expr         {/*нет необходимости поддерживтаь приоритет операций*/}
                                    | assignable '-' expr
                                    | assignable '*' expr
                                    | assignable '/' expr
                                    | assignable '%' expr 
                                    | '(' expr ')'
                                    | assignable
                                    ;

    assignable:                     assignable_without_func_def
                                    | nameles_func_def
                                    ;

    func_call:                      ID '(' list_of_assignable ')'
                                    | ID '(' DOTS ')'
                                    | ID '(' ')'
                                    | ID table_def
                                    | ID STRING
                                    ;
    
    table_def:                      '{' '}'
                                    | '{' list_of_assignable '}'
                                    | '{' assign_list '}'
                                    ;
    
    assign_list:                    table_assign
                                    | assign_list ',' table_assign
                                    ;

    table_assign:                   ID '=' assignable
                                    | '[' expr ']' '=' assignable
                                    ;

    func_def:                       FUNCTION ID '(' list_of_func_arg ')' list_of_statements END
                                    | LOCAL FUNCTION ID '(' list_of_func_arg ')' list_of_statements END
                                    | FUNCTION ID '(' ')' list_of_statements END
                                    | LOCAL FUNCTION ID '(' ')' list_of_statements END
                                    | FUNCTION ID '(' ')' END
                                    | LOCAL FUNCTION ID '(' ')' END
                                    ;
    
    nameles_func_def:               FUNCTION '(' ')' list_of_statements END
                                    | FUNCTION '(' list_of_func_arg ')' list_of_statements END
                                    ;

    list_of_func_arg:               func_arg
                                    | list_of_func_arg ',' func_arg
                                    ;
    
    func_returnable:                list_of_assignable_without_func_def
                                    | nameles_func_def
                                    |
                                    ;
    
    func_arg:                       list_of_assignable
                                    | list_of_id
                                    ;


                                
                                    
%%


void yyerror(char *s) {
   if (yydebug) {
	    std::cerr << s << ", line " << yylineno << std::endl;
    }
}

int main(int argc, char** argv) {
	yy_flex_debug = 0;
	yydebug = 0;
	std::cout << (!yyparse()? "OK" : "Not OK") << std::endl;
}