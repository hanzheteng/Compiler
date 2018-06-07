%{
#include "y.tab.h"
#include <string>
int line_num = 1, column = 0;
%}
%%
"function"	{column += yyleng;return FUNCTION;}
"beginlocals"	{column += yyleng;return BEGIN_LOCALS;}
"beginparams"	{column += yyleng;return BEGIN_PARAMS;}
"endparams"	{column += yyleng;return END_PARAMS;}
"endlocals"	{column += yyleng;return END_LOCALS;}
"beginbody"	{column += yyleng;return BEGIN_BODY;}
"endbody"	{column += yyleng;return END_BODY;}
"integer"	{column += yyleng;return INTEGER;}
"array"		{column += yyleng;return ARRAY;}
"of"		{column += yyleng;return OF;}
"if"        {column += yyleng;return IF;}
"then"      {column += yyleng;return THEN;}
"endif"     {column += yyleng;return ENDIF;}
"else"      {column += yyleng;return ELSE;}
"while"     {column += yyleng;return WHILE;}
"do"        {column += yyleng;return DO;}
"beginloop" {column += yyleng;return BEGINLOOP;}
"endloop"   {column += yyleng;return ENDLOOP;}
"continue"  {column += yyleng;return CONTINUE;}
"read"      {column += yyleng;return READ;}
"write"     {column += yyleng;return WRITE;}
"and"       {column += yyleng;return AND;}
"or"        {column += yyleng;return OR;}
"not"       {column += yyleng;return NOT;}
"true"      {column += yyleng;return TRUE;}
"false"     {column += yyleng;return FALSE;}
"return"    {column += yyleng;return RETURN;}
"-"         {column += yyleng;return SUB;}
"+"         {column += yyleng;return ADD;}
"*"         {column += yyleng;return MULT;}
"/"         {column += yyleng;return DIV;}
"%"         {column += yyleng;return MOD;}
"=="        {column += yyleng;return EQ;}
"<>"        {column += yyleng;return NEQ;}
"<"         {column += yyleng;return LT;}
">"         {column += yyleng;return GT;}
"<="        {column += yyleng;return LTE;}
">="        {column += yyleng;return GTE;}
";"         {column += yyleng;return SEMICOLON;}
":"         {column += yyleng;return COLON;}
","         {column += yyleng;return COMMA;}
"("         {column += yyleng;return L_PAREN;}
")"         {column += yyleng;return R_PAREN;}
"["         {column += yyleng;return L_SQUARE_BRACKET;}
"]"         {column += yyleng;return R_SQUARE_BRACKET;}
":="        {column += yyleng;return ASSIGN;}
"\n"        {line_num++; column = 0;}
"\t"        {column += yyleng;}
(" ")+      {column += yyleng;}
["#"]{2}(.*)("\n")    {line_num++;}
[0-9]+      {column += yyleng;yylval.int_val = atoi(yytext); return NUMBER;}
[a-zA-Z]+   {column += yyleng;yylval.op_val = yytext; ;return IDENT;}
[a-zA-Z][a-zA-Z0-9"_"]*[a-zA-Z0-9]    {column += yyleng; yylval.op_val = yytext; return IDENT;}
[0-9"_"]+[a-zA-Z0-9"_"]+       {printf("Error at line %d, column %d: Identifier \"%s\" must begin with a letter\n", line_num, column, yytext);}
[a-zA-Z][a-zA-Z0-9"_"]*["_"]+    {printf("Error at line %d, column %d: identifier \"%s\" cannot end with an underscore\n", line_num, column, yytext);}
. 	    {printf("Error at line %d, column %d: unrecognized symbol \"%s\"\n", line_num, column, yytext);}
%%

/*int main(int argc, char ** argv)
{
    yylex();
}*/
