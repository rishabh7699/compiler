%{ 
/* Definition section */

#include<stdio.h> 
#include "y.tab.h" 
%} 


/* Rule Section */
%% 
(integer) {
	yylval.num = 1;
	return DATATYPE;
}
(decimal) {
	yylval.num = 2;
	return DATATYPE;
}
(print) {
	return PRINT;
}
(if) {
	return IF;
}

(else) {
	return ELSE;
}

\"[a-zA-Z0-9 ]*\" {
		yylval.str = strdup((char*)yytext);
		return STRING;
}
([0-9]+|[0-9]+\.[0-9]+) { 
		yylval.str = strdup((char*)yytext);
		return NUMBER; 
	} 

[a-zA-Z_][a-zA-Z0-9_]* { 
		yylval.str = strdup((char*)yytext);
		return Identifier; 
	} 

[\t] ; 

[\n] return NEWLINE;

[ ] ;

. return yytext[0]; 

%% 

int yywrap() 
{ 
return 1; 
} 
