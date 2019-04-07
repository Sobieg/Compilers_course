CXX=g++
LEX=lex
YACC=yacc
YFLAGS=-d
RM=rm -f
PY=python3

TARGET=compile

.PHONY: all clean clear tests


all: $(TARGET)


clean clear: 
	-$(RM) *.c *.h

lex.yy.c: lua_syntax_check.lex
	$(LEX) lua_syntax_check.lex

y.tab.c: lua_syntax_check.yacc
	$(YACC) $(YFLAGS) lua_syntax_check.yacc

compile: lex.yy.c y.tab.c y.tab.h
	$(CXX) lex.yy.c y.tab.c

debug: lex.yy.c
	$(CXX) lex.yy.c 

tests: 
	$(PY) autotests.py