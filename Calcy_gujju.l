%{
    #include <stdio.h>
    #include "y.tab.h"
    #include <stdlib.h>
    
    
%}
    
%%
    "jo"             { printf("Token Matched: JO\n"); return JO; }
    "nahi_to"        { printf("Token Matched: NAHI_TO\n"); return NAHI_TO; }
    "jodo"           { printf("Token Matched: JODO\n"); return JODO; }
    "kapo"           { printf("Token Matched: KAPO\n"); return KAPO; }
    "guno"           { printf("Token Matched: GUNO\n"); return GUNO; }
    "bhango"         { printf("Token Matched: BHANGO\n"); return BHANGO; }
    "barabar"        { printf("Token Matched: BARABAR\n"); return BARABAR; }
    "dekhado"        { printf("Token Matched: DEKHADO\n"); return DEKHADO; }
    "sachu"          { printf("Token Matched: SACHU\n"); return SACHU; }
    "khotu"          { printf("Token Matched: KHOTU\n"); return KHOTU; }
    "motu"           { printf("Token Matched: MOTU\n"); return MOTU; }
    "nanu"           { printf("Token Matched: NANU\n"); return NANU; }
    "undhu"          { printf("Token Matched: UNDHU\n"); return UNDHU; }

    [0-9]+      { printf("Token: INT_VAL (%s)\n", yytext); yylval.intval = atoi(yytext); return INT_VAL; }
    [0-9]+"."[0-9]+  { printf("Token: FLOAT_VAL (%s)\n", yytext); yylval.floatval = atof(yytext); return FLOAT_VAL; }

    [ \t\n]          { /* skip whitespace */ }
    .                { printf("Ela Bhai aa nay chale : %s\n", yytext); }
%%
    
int yywrap(void) {
        return 1;
    }
    