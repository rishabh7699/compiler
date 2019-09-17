
%{
	#include<time.h>
%}

%%
(inta|int|float|char|void|double|return|using|namespace) {
	printf("%s", yytext);
	printf(" \t\t: keyword\n");
}
\"[a-z A-Z0-9]*\" {
	printf("%s", yytext);
	printf(" \t\t: string\n"); 
}
("<<"|">>"|"+"|"-"|"="|"*"|"->"|"."|"^"|"&"|"|"|"||"|"&&"|",") {
	printf("%s", yytext);
	printf(" \t\t: operator\n");
}
([0-9]+|[0-9]+.[0-9]+) {
	printf("%s", yytext);
	printf(" \t\t: constant literal\n");
}
[\n \t] {
}
[a-zA-Z_][a-zA-Z0-9_]* {
	printf("%s", yytext);
	printf(" \t\t: identifier\n");	
} 
("\""|"'"|"{"|"}"|"["|"]"|"("|")"|"<"|">"|";") {
	printf("%s", yytext);
	printf(" \t\t: separator\n");	
}
. {
	printf("%s", yytext);
	printf(" \t\t: unknown\n");
}
%%

int yywrap(){} 
int main(){
FILE *fp; 
fp = fopen("program.cpp","r"); 
yyin = fp; 
clock_t start, end;
start = clock();
yylex();
end = clock();
printf("time taken = %f seconds\n", ((double)(end-start))/CLOCKS_PER_SEC);
return 0;
}