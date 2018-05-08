
%%
[0-9]+    printf("%s %s\n", "NUMBER",yytext);
"+"    printf("%s\n", "PLUS");
"-"    printf("%s\n", "MINUS");
"*"    printf("%s\n", "MULT");
"/"    printf("%s\n", "DIV");
"("    printf("%s\n", "L_PAREN");
")"    printf("%s\n", "R_PAREN");
"="    printf("%s\n", "EQUAL");

%%
int 
main()
{
  yylex();
}
