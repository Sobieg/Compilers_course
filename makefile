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

lex.yy.c: course.l
	$(LEX) course.l

y.tab.c: course.y
	$(YACC) $(YFLAGS) course.y

git:
	$(GIT) commit -m "make commit on $(shell date)"

compile: lex.yy.c y.tab.c y.tab.h
	$(CXX) lex.yy.c y.tab.c

compile-git: git compile 

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

