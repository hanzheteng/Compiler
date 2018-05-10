%{
#include "y.tab.h"
int line_num = 1, column = 0;
%}
%%
"function"	{printf("FUNCTION\n"); column += yyleng;return FUNCTION;}
"beginlocals"	{printf("BEGIN_LOCALS\n"); column += yyleng;return BEGIN_LOCALS;}
"beginparams"	{printf("BEGIN_PARAMS\n"); column += yyleng;return BEGIN_PARAMS;}
"endparams"	{printf("END_PARAMS\n"); column += yyleng;return END_PARAMS;}
"endlocals"	{printf("END_LOCALS\n"); column += yyleng;return END_LOCALS;}
"beginbody"	{printf("BEGIN_BODY\n"); column += yyleng;return BEGIN_BODY;}
"endbody"	{printf("END_BODY\n"); column += yyleng;return END_BODY;}
"integer"	{printf("INTEGER\n"); column += yyleng;return INTEGER;}
"array"		{printf("ARRAY\n"); column += yyleng;return ARRAY;}
"of"		{printf("OF\n"); column += yyleng;return OF;}
"if"        {printf("IF\n"); column += yyleng;return IF;}
"then"      {printf("THEN\n"); column += yyleng;return THEN;}
"endif"     {printf("ENDIF\n"); column += yyleng;return ENDIF;}
"else"      {printf("ELSE\n"); column += yyleng;return ELSE;}
"while"     {printf("WHILE\n"); column += yyleng;return WHILE;}
"do"        {printf("DO\n"); column += yyleng;return DO;}
"beginloop" {printf("BEGINLOOP\n"); column += yyleng;return BEGINLOOP;}
"endloop"   {printf("ENDLOOP\n"); column += yyleng;return ENDLOOP;}
"continue"  {printf("CONTINUE\n"); column += yyleng;return CONTINUE;}
"read"      {printf("READ\n"); column += yyleng;return READ;}
"write"     {printf("WRITE\n"); column += yyleng;return WRITE;}
"and"       {printf("AND\n"); column += yyleng;return AND;}
"or"        {printf("OR\n"); column += yyleng;return OR;}
"not"       {printf("NOT\n"); column += yyleng;return NOT;}
"true"      {printf("TRUE\n"); column += yyleng;return TRUE;}
"false"     {printf("FALSE\n"); column += yyleng;return "FALSE";}
"return"    {printf("RETURN\n"); column += yyleng;return "RETURN";}
"-"         {printf("SUB\n"); column += yyleng;return "SUB";}
"+"         {printf("ADD\n"); column += yyleng;return "ADD";}
"*"         {printf("MULT\n"); column += yyleng;return "MULT";}
"/"         {printf("DIV\n"); column += yyleng;return "DIV";}
"%"         {printf("MOD\n"); column += yyleng;return "MOD";}
"=="        {printf("EQ\n"); column += yyleng;return "EQ";}
"<>"        {printf("NEQ\n"); column += yyleng;return "NEQ";}
"<"         {printf("LT\n"); column += yyleng;return "LT";}
">"         {printf("GT\n"); column += yyleng;return "GT";}
"<="        {printf("LTE\n"); column += yyleng;return "LTE";}
">="        {printf("GTE\n"); column += yyleng;return "GTE";}
";"         {printf("SEMICOLON\n"); column += yyleng;return "SEMICOLON";}
":"         {printf("COLON\n"); column += yyleng;return "COLON";}
","         {printf("COMMA\n"); column += yyleng;return "COMMA";}
"("         {printf("L_PAREN\n"); column += yyleng;return "L_PAREN";}
")"         {printf("R_PAREN\n"); column += yyleng;return "R_PAREN";}
"["         {printf("L_SQUARE_BRACKET\n"); column += yyleng;return "L_SQUARE_BRACKET";}
"]"         {printf("R_SQUARE_BRACKET\n"); column += yyleng;return "R_SQUARE_BRACKET";}
":="        {printf("ASSIGN\n"); column += yyleng;return "ASSIGN";}
"\n"        {line_num++; column = 0;}
"\t"        {column += yyleng;}
(" ")+      {column += yyleng;}
["#"]{2}(.*)("\n")    {line_num++;}
[0-9]+      {printf("NUMBER %s\n", yytext); column += yyleng; return yytext;}
[a-zA-Z]+   {printf("IDENT %s\n", yytext); column += yyleng;return yytext;}
[a-zA-Z][a-zA-Z0-9"_"]*[a-zA-Z0-9]    {printf("IDENT %s\n", yytext); column += yyleng; return yytext;}
[0-9"_"]+[a-zA-Z0-9"_"]+       {printf("Error at line %d, column %d: Identifier \"%s\" must begin with a letter\n", line_num, column, yytext); exit(0);}
[a-zA-Z][a-zA-Z0-9"_"]*["_"]+    {printf("Error at line %d, column %d: identifier \"%s\" cannot end with an underscore\n", line_num, column, yytext); exit(0);}
. 	    {printf("Error at line %d, column %d: unrecognized symbol \"%s\"\n", line_num, column, yytext); exit(0);}
%%
/*int main(int argc, char ** argv)
{
    yylex();

}*/
