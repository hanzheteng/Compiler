/* mini_l parser */
/* mini_l.y */
/* Author: Zhenxiao Qi, Hanzhe Teng */

%{
#include "heading.h"
void yyerror(char *s);
int yylex(void);
%}

%union{
  int       int_val;
  char *   op_val;
}

%start	input 

%token  <int_val> NUMBER
%token  <op_val> IDENT
%token  FUNCTION SEMICOLON BEGIN_LOCALS BEGIN_PARAMS END_PARAMS END_LOCALS BEGIN_BODY END_BODY
%token  INTEGER ARRAY OF IF THEN ENDIF ELSE WHILE DO BEGINLOOP ENDLOOP CONTINUE READ WRITE
%token  L_BRACKET R_BRACKET 
%token  TRUE FALSE RETURN COLON COMMA  
%token  L_PAREN R_PAREN L_SQUARE_BRACKET R_SQUARE_BRACKET ASSIGN 
%left   AND OR NOT SUB ADD MULT DIV MOD EQ NEQ LT GT LTE GTE

%%
input:		program{
                printf("input->program\n");
                }
	        ;

program:	functions{
                printf("program->functions\n");
                }
	        ;

functions:      /* empty */{
                printf("functions->empty\n");
                }
                /*function{
                  printf("functions->function");
                  }*/
                | function functions{
                  printf("functions->function functions\n");
                  }
                ;

function:	FUNCTION IDENT SEMICOLON BEGIN_PARAMS declarations END_PARAMS BEGIN_LOCALS declarations END_LOCALS BEGIN_BODY statements END_BODY{
                printf("function->FUNCTION IDENT SEMICOLON BEGIN_PARAMS declarations END_PARAMS BEGIN_LOCALS declarations END_LOCALS BEGIN_BODY statements END_BODY\n");
                }
                ;

declarations:   /* empty */ {
                printf("declarations->empty\n");
                }
                /*| declaration SEMICOLON{
                  printf("declarations->declaration SEMICOLON");
                  }*/
                | declaration SEMICOLON declarations{
                  printf("declarations->declaration SEMICOLON declarations\n");
                  }
                ;

statements:     statement SEMICOLON{
                printf("statements->statement SEMICOLON\n");
                }
                | statement SEMICOLON statements{
                  printf("statements->statement SEMICOLON statements\n");
                  }
                ;

declaration:    identifiers COLON INTEGER{
                printf("declaration->identifiers COLON INTEGER\n");
                }
                | identifiers COLON ARRAY L_BRACKET NUMBER R_BRACKET OF INTEGER{
                  printf("declaration->identifiers COLON ARRAY L_BRACKET NUMBER R_BRACKET OF INTEGER\n");
                  }
                ;

identifiers:    IDENT{
                printf("identifiers->IDENT\n");
                }
                | IDENT COMMA identifiers{
                  printf("identifiers->IDENT COMMA identifiers\n");
                  }
                ;

expression:       multiplicative_expr{
                  printf("expression->multiplicative_expr\n");
                  }
                 | multiplicative_expr ADD multiplicative_expr{
                   printf("expression->multiplicative_expr ADD multiplicative_expr\n");
                   } 
                 | multiplicative_expr SUB multiplicative_expr{
                   printf("expression->multiplicative_expr SUB multiplicative_expr\n");
                   } 
                 ;
statement:      variable ASSIGN expression{
                printf("statement->variable ASSIGN expression\n");
                }
                | IF bool_expr THEN statements ENDIF{
                  printf("statement->IF bool_expr THEN statements ENDIF\n");
                  }
                | IF bool_expr THEN statements ELSE statements ENDIF{
                  printf("statement->IF bool_expr THEN statements ELSE statements ENDIF\n");
                  } 
                | WHILE bool_expr BEGINLOOP statements ENDLOOP{
                  printf("statement->WHILE bool_expr BEGINLOOP statements ENDLOOP\n");
                  }
                | DO BEGINLOOP statements ENDLOOP WHILE bool_expr{
                  printf("statement->DO BEGINLOOP statements ENDLOOP WHILE bool_expr\n");
                  }
                | READ variables{
                  printf("statement->READ variables\n");
                  }
                | WRITE variables{
                  printf("statement->WRITE variables\n");
                  }
                | CONTINUE{
                  printf("statement->CONTINUE\n");
                  }
                | RETURN expression{
                  printf("statement->RETURN expression\n");
                  }
                ;

bool_expr:      relation_and_expr{
                printf("bool_expr->relation_and_expr\n");
                }
                | relation_and_expr OR relation_and_expr{
                  printf("bool_expr->relation_and_expr OR relation_and_expr\n");
                  }
                ;

relation_and_expr:  relation_expr{
                    printf("relation_and_expr->relation_expr\n");
                    }
                    | relation_expr AND relation_expr{
                      printf("relation_and_expr->relation_expr AND relation_expr\n");
                      }
                    ;

relation_expr:    NOT relation_expr{
                  printf("relation_expr->NOT relation_expr\n");
                  }
                 | expression comparison expression{
                   printf("relation_expr->expression comparison expression\n");
                   }
                 | TRUE{
                   printf("relation_expr->TRUE\n");
                   }
                 | FALSE{
                   printf("relation_expr->FALSE\n");
                   }
                 | L_PAREN bool_expr R_PAREN{
                   printf("relation_expr->L_PAREN bool_expr R_PAREN\n");
                   }
                 ;

comparison:      EQ{
                 printf("comparison->EQ\n");
                 }
                 | NEQ{
                   printf("comparison->NEQ\n");
                   }
                 | LTE{
                   printf("comparison->LTE\n");
                   }
                 | GTE{
                   printf("comparison->GTE\n");
                   }
                 | LT{
                   printf("comparison->LT\n");
                   }
                 | GT{
                   printf("comparison->GT\n");
                   }
                 ;

 

multiplicative_expr:  term{
                      printf("multiplicative_expr->term\n");
                      }
                      | term MULT term{
                        printf("multiplicative_expr->term MULT term\n");
                        }
                      | term DIV term{
                        printf("multiplicative_expr->term DIV term\n");
                        }
                      | term MOD term{
                        printf("multiplicative_expr->term MOD term\n");
                        }
                      ;

term:           variable{
                printf("term->variable\n");
                }
                | SUB variable{
                  printf("term->SUB variable\n");
                  }
                | NUMBER{
                  printf("term->NUMBER\n");
                  }
                | SUB NUMBER{
                  printf("term->SUB NUMBER\n");
                  }
                | L_PAREN expression R_PAREN{
                  printf("term->L_PAREN expression R_PAREN\n");
          	  }
                | SUB L_PAREN expression R_PAREN{
                  printf("term->SUB L_PAREN expression R_PAREN\n");
                  }
                | IDENT L_PAREN expressions R_PAREN{
                  printf("term->IDENT L_PAREN expressions R_PAREN\n");
                  }
                ;

expressions:     /* empty */
                | expression{
                  printf("expressions->expression\n");
                  }
                | expression COMMA expressions{
                  printf("expressions->expression COMMA expressions\n");
                  }
                ;

variables:      variable{
                printf("variables->variable\n");
                }
                | variable COMMA variables{
                  printf("variables->variable COMMA variables\n");
                  }
                ; 

variable:       IDENT{
                printf("variable->IDENT\n");
                }
                | IDENT L_BRACKET expression R_BRACKET{
                  printf("variable->IDENT L_BRACKET expression R_BRACKET\n");
                  }
                ;
%%

void yyerror(char *s)
{
  extern int yylineno;	// defined and maintained in lex.c
  extern char *yytext;	// defined and maintained in lex.c
  //exit(1);
}

int main(int argc, char **argv)
{
  if ((argc > 1) && (freopen(argv[1], "r", stdin) == NULL))
  {
    cerr << argv[0] << ": File " << argv[1] << " cannot be opened.\n";
    exit( 1 );
  }
  
  yyparse();

  return 0;
}
