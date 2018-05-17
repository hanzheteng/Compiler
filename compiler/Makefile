## Makefile 

OBJS = mini_parser
CC = g++

compiler: lexer y.tab.c lex.yy.c
	$(CC) -o compiler y.tab.c lex.yy.c -lfl

lexer: bison_file mini_l.lex y.tab.h 
	flex mini_l.lex

bison_file: mini_l.y
	bison -v -d --file-prefix=y mini_l.y

clean:
	rm -rf *.c *.o *.output *.tab.h mini_parser *.stat parser
