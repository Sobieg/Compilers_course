all:
	yacc -d lua_syntax_check.yacc
	lex lua_syntax_check.lex
	g++ lex.yy.c y.tab.c

clean: 
	rm *.c *.h

clear:
	clean

lex:
	lex lua_syntax_check.lex
	#DEBUG:
	cc lex.yy.c

yacc:
	yacc -d lua_syntax_check.yacc

compile:
	g++ lex.yy.c y.tab.c
