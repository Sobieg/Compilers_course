CXX=g++
LEX=lex
YACC=yacc
YFLAGS=-d -v -t
RM=rm -rf
PY=python3
RESULTDIR=results\\
TESTSDIR=tests\\
ETDIR=etalon\\
GIT=git
GITFLAGS=-am
DATE=date

TARGET=compile

.PHONY: tests


all: $(TARGET)


clean clear: 
	-$(RM) *.c *.h

lex.yy.c: lua_syntax_check.lex
	$(LEX) lua_syntax_check.lex

y.tab.c: lua_syntax_check.yacc
	$(YACC) $(YFLAGS) lua_syntax_check.yacc

git:
	$(GIT) checkout everymake-commit
	$(GIT) add .
	$(GIT) commit -am "$(shell date)"

test:
	$(DATE) + "%y.%m.%d %H:%M:%S"

compile: lex.yy.c y.tab.c y.tab.h git
	$(CXX) lex.yy.c y.tab.c

debug: lex.yy.c
	$(CXX) lex.yy.c 

tests: 
	-$(RM) $(RESULTDIR)*.result
	-$(RM) errors.log
	$(PY) autotests.py

etupd:
	-$(RM) errors.log
	-$(RM) $(ETDIR) 
	cp $(RESULTDIR)*.result $(ETDIR) 

