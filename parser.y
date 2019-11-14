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

%union { 
    char* str;
    float num;
 }

%left '+' '-'

%left '*' '/' '%'

%left '(' ')'

%type<str> NUMBER Identifier STRING

/* Rule Section */
%% 

    program :  
            {
                printf("\nTotal no. of lines compiled are %d\n", line);
                return 0;
            } | 
            statement program;

    statement : Expression | 
                Declaration | 
                Input | 
                Output ';' | 
                NEWLINE 
                {
                    line++;
                } | 
                ';' | 
                IFstatement;

    IFstatement : IF '(' Identifier ')' ENTER '{' IFblock '}' ENTER ELSE ENTER '{' IFblock '}' 
                {
                    printf("\n if else statement \n");
                };

    ENTER : | 
            NEWLINE ENTER 
            {
                line++;
            };

    IFblock : | 
            statement IFblock;

    Declaration: DATATYPE Identifier ';' 
                {
                    add_identifier($2, line);
                } | 
                DATATYPE Identifier '=' E MoreD ';' 
                { 
                    add_identifier($2, line);
                };

    MoreD: | 
            ',' Identifier MoreD 
            {
                add_identifier($2, line);
            } | 
            ',' Identifier '=' E MoreD 
            { 
                add_identifier($2, line);
            };

    Input : 'i''n''p''u''t';

    Output : PRINT STRING MoreOutput
            {
                printf("\nstring %s will be printed\n",$2);
            } | 
            PRINT Identifier MoreOutput 
            {
                if(!is_exist($2))
                    printf("\nE : variable %s is used in line %d but not declared\n", $2, line);
                else
                    printf("\nvariable %s will be printed\n", $2);
            };

    MoreOutput : | 
                ',' STRING MoreOutput 
                {
                    printf("\nstring %s will be printed\n",$2);
                } | 
                ',' Identifier MoreOutput 
                {
                    if(!is_exist($2))
                        printf("\nE : variable %s is used in line %d but not declared\n", $2, line);
                    else
                        printf("\nvariable %s will be printed\n", $2);
                };


    Expression: Identifier '=' E ';'
                { 
                    if(!is_exist($1))
                        printf("\nE : variable %s is used in line %d but not declared\n", $1, line);
                    else
                        printf("\nvalue of variable %s is updated\n", $1);
                }; 
    E: E'+'E 
        {
        } |
        E'-'E 
        {
        } |
        E'*'E 
        {
        } |
        E'/'E 
        {
        } |
        '('E')' 
        {
        } | 
        NUMBER 
        {
        } | 
        Identifier 
        {
            if(!is_exist($1))
                printf("\nE : variable %s is used in line %d but not declared\n", $1, line);
        }; 

%% 

//driver code 
void main() 
{ 
    initialize_map();
    yyin=fopen("exp","r");
    yyparse(); 
} 

void yyerror() 
{ 
    printf("\nE : Error in line %d\n\n", line); 
    flag=1; 
} 
