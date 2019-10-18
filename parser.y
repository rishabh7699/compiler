%{ 
/* Definition section */
#include<stdio.h> 
#include <stdlib.h>
int flag=0; 
extern FILE *yyin;
%} 

%token NUMBER

%union { char* str;
          float num;
 }

%left '+' '-'

%left '*' '/' '%'

%left '(' ')'

%type<num> E ArithmeticExpression
%type<str> NUMBER

/* Rule Section */
%% 

ArithmeticExpression: E{ 

    printf("\nResult=%f\n", $$); 

    return 0; 

    }; 
E:E'+'E {$$=$1+$3;} 

|E'-'E {$$=$1-$3;} 

|E'*'E {$$=$1*$3;} 

|E'/'E {$$=$1/$3;} 

|'('E')' {$$=$2;} 

| NUMBER {
            $$=atof($1);} 

; 

%% 

//driver code 
void main() 
{ 
yyin=fopen("exp","r");
yyparse(); 
if(flag==0) 
printf("\nEntered arithmetic expression is Valid\n\n"); 
} 

void yyerror() 
{ 
printf("\nEntered arithmetic expression is Invalid\n\n"); 
flag=1; 
} 
