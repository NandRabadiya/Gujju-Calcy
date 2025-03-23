%{
#include <stdio.h>
#include "Calcy_gujju.tab.h"
#include <stdlib.h>
/* Add line number tracking */
int line_num = 1;  /* Define line_num here */
%}
%%
"jo"             { printf("Token Matched: JO\n"); fflush(stdout); return JO; }
"nahi_to"        { printf("Token Matched: NAHI_TO\n"); fflush(stdout); return NAHI_TO; }
"jodo"           { printf("Token Matched: JODO\n"); fflush(stdout); return JODO; }
"kapo"           { printf("Token Matched: KAPO\n"); fflush(stdout); return KAPO; }
"guno"           { printf("Token Matched: GUNO\n"); fflush(stdout); return GUNO; }
"bhango"         { printf("Token Matched: BHANGO\n"); fflush(stdout); return BHANGO; }
"barabar"        { printf("Token Matched: BARABAR\n"); fflush(stdout); return BARABAR; }
"dekhado"        { printf("Token Matched: DEKHADO\n"); fflush(stdout); return DEKHADO; }
"sachu"          { printf("Token Matched: SACHU\n"); fflush(stdout); return SACHU; }
"khotu"          { printf("Token Matched: KHOTU\n"); fflush(stdout); return KHOTU; }
"motu"           { printf("Token Matched: MOTU\n"); fflush(stdout); return MOTU; }
"nanu"           { printf("Token Matched: NANU\n"); fflush(stdout); return NANU; }
"undhu"          { printf("Token Matched: UNDHU\n"); fflush(stdout); return UNDHU; }
";"              { printf("Token Matched: SEMICOLON\n"); fflush(stdout); return ';'; } /* Semicolon handler */
[0-9]+           { printf("Token: INT_VAL (%s)\n", yytext); fflush(stdout); yylval.intval = atoi(yytext); return INT_VAL; }
[0-9]+"."[0-9]+  { printf("Token: FLOAT_VAL (%s)\n", yytext); fflush(stdout); yylval.floatval = atof(yytext); return FLOAT_VAL; }
\n               { line_num++; /* Increment line number counter */ }
[ \t]            { /* skip other whitespace */ }
.                { printf("Ela Bhai aa nay chale : %s (Line %d)\n", yytext, line_num); fflush(stdout); }
%%
int yywrap(void) {
    return 1;
}