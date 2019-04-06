all:
	yacc -d lua_syntax_check.yacc
	lex lua_syntax_check.lex
	g++ lex.yy.c y.tab.c

clean: 
	rm *.c *.h

clear:
	clean