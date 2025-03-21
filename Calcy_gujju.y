%{
#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern int yylval;
void yyerror(const char *s);
%}

%token JO NAHI_TO JODO KAPO GUNO BHANGO BARABAR DEKHADO SACHU KHOTU MOTU NANU UNDHU NUMBER

%%

program:
    statements
;

statements:
      statements statement
    | statement
;

statement:
      expression DEKHADO        { printf("Output: %d\n", $1); }
    | JO expression NAHI_TO expression { if ($2) printf("Sachu\n"); else printf("Khotu\n"); }
    | JO expression              { if ($2) printf("Sachu\n"); else printf("Khotu\n"); }
    
;

expression:
      expression JODO expression  { $$ = $1 + $3; printf("Addition Performed: %d + %d = %d\n", $1, $3, $$); }
    | expression KAPO expression  { $$ = $1 - $3; printf("Subtraction Performed: %d - %d = %d\n", $1, $3, $$); }
    | expression GUNO expression  { $$ = $1 * $3; printf("Multiplication Performed: %d * %d = %d\n", $1, $3, $$); }
    | expression BHANGO expression  { $$ = $1 / $3; printf("Division Performed: %d / %d = %d\n", $1, $3, $$); }
    | expression BARABAR expression { $$ = ($1 == $3); printf("Comparison: %d == %d -> %s\n", $1, $3, $$ ? "True" : "False"); }
    | NUMBER                       { $$ = $1; }
    | SACHU                         { $$ = 1; }
    | KHOTU                         { $$ = 0; }
    | expression MOTU expression   { $$ = $1 > $3; printf("Comparison: %d > %d -> %s\n", $1, $3, $$ ? "True" : "False"); }
    | expression NANU expression   { $$ = $1 < $3; printf("Comparison: %d < %d -> %s\n", $1, $3, $$ ? "True" : "False"); }
    | UNDHU expression             { $$ = !$2; printf("Negation: !%d -> %d\n", $2, $$); }
;

%%

void yyerror(const char *s) {
    printf("Error: %s\n", s);
}

int main() {
    printf("Welcome to Calcy Gujju - Enter your expressions below:\n");
    yyparse();
    return 0;
}
