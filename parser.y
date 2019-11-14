%{ 
/* Definition section */
#include<stdio.h> 
#include <stdlib.h>
#include "hash.h"
int flag=0; 
int line=1;
extern FILE *yyin;
%} 

%token NUMBER Identifier NEWLINE DATATYPE PRINT STRING IF ELSE

%union { char* str;
          float num;
 }

%left '+' '-'

%left '*' '/' '%'

%left '(' ')'

%type<num> E Expression DATATYPE
%type<str> NUMBER Identifier STRING emptyline

/* Rule Section */
%% 

program :  {
    printf("\nTotal no. of lines compiled are %d\n", line);
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

| IFstatement

;

IFstatement : IF '(' Identifier ')' ENTER '{' IFblock '}' ENTER ELSE ENTER '{' IFblock '}' {printf("\n if statement \n");}

;

ENTER : 

| newline ENTER {line++;};

IFblock : 

| statement IFblock ;

emptyline: ';' {
    $$ = ";";
};

Declaration: DATATYPE Identifier emptyline   {
    add_identifier($2, line);
}

| DATATYPE Identifier '=' E More ';' { 
    add_identifier($2, line);
    printf("\nResult=%f\n", $4); 
    }
;

More: 

| ',' Identifier More {
    add_identifier($2, line);
}

| ',' Identifier '=' E More { 
    add_identifier($2, line);
    printf("\nResult=%f\n", $4); 
    }

;

Input : 'i''n''p''u''t';

Output : PRINT STRING  MoreOutput{
    printf("\n%s\n",$2);
}
| PRINT Identifier MoreOutput {
    if(!is_exist($2))
        printf("\nvariable %s is used in line %d but not declared\n", $2, line);
} 
;

MoreOutput : 
| ',' STRING MoreOutput {
    printf("\n%s\n",$2);
} 
| ',' Identifier MoreOutput {
    if(!is_exist($2))
        printf("\nvariable %s is used in line %d but not declared\n", $2, line);
}
;

newline : NEWLINE;

Expression: Identifier '=' E ';'{ 
    if(!is_exist($1))
        printf("\nvariable %s is used in line %d but not declared\n", $1, line);
    printf("\nResult=%f\n", $3); 

    }; 
E:E'+'E {$$=$1+$3;} 

|E'-'E {$$=$1-$3;} 

|E'*'E {$$=$1*$3;} 

|E'/'E {$$=$1/$3;} 

|'('E')' {$$=$2;} 

| NUMBER {
            $$=atof($1);} 
| Identifier {
            if(!is_exist($1))
                printf("\nvariable %s is used in line %d but not declared\n", $1, line);
            $$ = 1;
}

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
