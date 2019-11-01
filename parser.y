%{ 
/* Definition section */
#include<stdio.h> 
#include <stdlib.h>
int flag=0; 
int line=1;
extern FILE *yyin;
%} 

%token NUMBER Identifier NEWLINE DATATYPE PRINT STRING

%union { char* str;
          float num;
 }

%left '+' '-'

%left '*' '/' '%'

%left '(' ')'

%type<num> E Expression DATATYPE
%type<str> NUMBER Identifier STRING

/* Rule Section */
%% 

program :  {
    printf("\nlines=%d\n", line);
    return 0;}
| statement program;

statement : Expression

| Declaration

| Input

| Output ';'

| newline {
    line++;
}
| emptyline

;

emptyline: ';';

Declaration: DATATYPE Identifier More ';'

| DATATYPE Identifier '=' E More ';' { 

    printf("\nResult=%f\n", $4); 
    }
;

More: 

| ',' Identifier More

| ',' Identifier '=' E More { 

    printf("\nResult=%f\n", $4); 
    }

;

Input : 'i''n''p''u''t';

Output : PRINT STRING {
    printf("\n%s\n",$2);
}
| PRINT Identifier
;

newline : NEWLINE;

Expression: Identifier '=' E ';'{ 

    printf("\nResult=%f\n", $3); 

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
} 

void yyerror() 
{ 
printf("\nError in line %d\n\n", line); 
flag=1; 
} 
