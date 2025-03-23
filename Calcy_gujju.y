%{
#include <stdio.h>
#include <stdlib.h>
extern int yylex();
extern int yyparse();
extern char* yytext;
extern FILE* yyin;    /* For file input */

/* Declare line_num as external */
extern int line_num;

void yyerror(const char *s);
%}

%union {
    int intval;
    float floatval;
}

%token JO NAHI_TO JODO KAPO GUNO BHANGO BARABAR DEKHADO SACHU KHOTU MOTU NANU UNDHU
%token <intval> INT_VAL
%token <floatval> FLOAT_VAL

%type <intval> expression

/* Define operator precedence and associativity */
%left JODO KAPO        /* lowest precedence */
%left GUNO BHANGO      /* higher precedence */
%left BARABAR MOTU NANU /* higher precedence */
%right UNDHU           /* highest precedence */

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
    | error '\n'                { yyerrok; } /* Error recovery rule */
;

expression:
      expression JODO expression  { $$ = $1 + $3; printf("Addition Performed: %d + %d = %d\n", $1, $3, $$); }
    | expression KAPO expression  { $$ = $1 - $3; printf("Subtraction Performed: %d - %d = %d\n", $1, $3, $$); }
    | expression GUNO expression  { $$ = $1 * $3; printf("Multiplication Performed: %d * %d = %d\n", $1, $3, $$); }
    | expression BHANGO expression  { 
        if ($3 == 0) {
            yyerror("Division by zero");
            $$ = 0;
        } else {
            $$ = $1 / $3; 
            printf("Division Performed: %d / %d = %d\n", $1, $3, $$);
        }
      }
    | expression BARABAR expression { $$ = ($1 == $3); printf("Comparison: %d == %d -> %s\n", $1, $3, $$ ? "True" : "False"); }
    | expression MOTU expression   { $$ = $1 > $3; printf("Comparison: %d > %d -> %s\n", $1, $3, $$ ? "True" : "False"); }
    | expression NANU expression   { $$ = $1 < $3; printf("Comparison: %d < %d -> %s\n", $1, $3, $$ ? "True" : "False"); }
    | UNDHU expression             { $$ = !$2; printf("Negation: !%d -> %d\n", $2, $$); }
    | INT_VAL                     { $$ = $1; }
    | FLOAT_VAL                   { $$ = (int)$1; printf("Converting float %f to int %d\n", $1, $$); }
    | SACHU                       { $$ = 1; }
    | KHOTU                       { $$ = 0; }
;
%%
void yyerror(const char *s) {
    fprintf(stderr, "Error at line %d: %s", line_num, s);
    
    /* Show the current token if available */
    if (yytext[0] != '\0')
        fprintf(stderr, " near token '%s'", yytext);
    
    fprintf(stderr, "\n");
}

int main(int argc, char **argv) {
    printf("Welcome to Calcy Gujju - Enter your expressions below:\n");
    
    /* Handle file input if provided */
    if (argc > 1) {
        FILE *input_file = fopen(argv[1], "r");
        if (!input_file) {
            fprintf(stderr, "Cannot open input file %s\n", argv[1]);
            return 1;
        }
        yyin = input_file;
    }
    
    int result = yyparse();
    
    /* Close file if we opened one */
    if (argc > 1) {
        fclose(yyin);
    }
    
    return result;
}