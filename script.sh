lex lexer.l
bison -dy parser.y
gcc lex.yy.c y.tab.c -w
./a.out