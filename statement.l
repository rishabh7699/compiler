%{ 
/* Definition section */

#include<stdio.h> 
#include "y.tab.h" 
%} 


/* Rule Section */
%% 
([0-9]+|[0-9]+\.[0-9]+) { 
		yylval.str = (char*)yytext;
		return NUMBER; 

	} 
[\t] ; 

[\n] return 0; 

. return yytext[0]; 

%% 

int yywrap() 
{ 
return 1; 
} 
