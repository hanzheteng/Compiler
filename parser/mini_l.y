/* mini_l parser */
/* mini_l.y */
/* Author: Zhenxiao Qi, Hanzhe Teng */

%{
#include "heading.h"
int yyerror(char *s);
int yylex(void);
%}

%union{
  int		int_val;
  string*	op_val;
}

%start	input 

%token  <int_val>  NUMBER
%token  <op_val>   IDENT
%token  FUNCTION SEMICOLON BEGIN_LOCALS BEGIN_PARAMS END_PARAMS END_LOCALS BEGIN_BODY END_BODY
%token  INTEGER ARRAY OF IF THEN ENDIF ELSE WHILE DO BEGINLOOP ENDLOOP CONTINUE READ WRITE
%token  L_BRACKET R_BRACKET 
%token  TRUE FALSE RETURN COLON COMMA  
%token  L_PAREN R_PAREN L_SQUARE_BRACKET R_SQUARE_BRACKET ASSIGN 
%left   AND OR NOT SUB ADD MULT DIV MOD EQ NEQ LT GT LTE GTE

%%

input:		program{
                printf("input->program");
                }
		;

program:	functions{
                printf("program->functions");
                }
		;

functions:      /* empty */ 
                /*| function{
                  printf("functions->function");
                  }*/
                | function functions{
                  printf("functions->function functions");
                  }
                ;

function:	FUNCTION IDENT SEMICOLON BEGIN_PARAMS declarations END_PARAMS BEGIN_LOCALS declarations END_LOCALS BEGIN_BODY statements END_BODY{
                printf("function->FUNCTION IDENT SEMICOLON BEGIN_PARAMS declarations END_PARAMS BEGIN_LOCALS declarations END_LOCALS BEGIN_BODY statements END_BODY");
                }
                ;

declarations:   /* empty */ 
                /*| declaration SEMICOLON{
                  printf("declarations->declaration SEMICOLON");
                  }*/
                | declaration SEMICOLON declarations{
                  printf("declarations->declaration SEMICOLON declarations");
                  }
                ;

statements:     statement SEMICOLON{
                printf("statements->statement SEMICOLON");
                }
                | statement SEMICOLON statements{
                  printf("statements->statement SEMICOLON statements");
                  }
                ;

declaration:    identifiers COLON INTEGER{
                prinf("declaration->identifiers COLON INTEGER");
                }
                | identifiers COLON ARRAY L_BRACKET NUMBER R_BRACKET OF INTEGER{
                  printf("declaration->identifiers COLON ARRAY L_BRACKET NUMBER R_BRACKET OF INTEGER");
                  }
                ;

identifiers:    IDENT{
                printf("identifiers->IDENT");
                }
                | IDENT COMMA identifiers{
                  printf(identifiers->IDENT COMMA identifiers);
                  }
                ;

expression:       multiplicative_expr{
                  printf("expression->multiplicative_expr");
                  }
                 | multiplicative_expr ADD multiplicative_expr{
                   printf("expression->multiplicative_expr ADD multiplicative_expr");
                   } 
                 | multiplicative_expr SUB multiplicative_expr{
                   printf("expression->multiplicative_expr SUB multiplicative_expr");
                   } 
                 ;
statement:      variable ASSIGN expression{
                printf("statement->variable ASSIGN expression");
                }
                | IF bool_expr THEN statements ENDIF{
                  printf("statement->IF bool_expr THEN statements ENDIF");
                  }
                | IF bool_expr THEN statements ELSE statements ENDIF{
                  printf("statement->IF bool_expr THEN statements ELSE statements ENDIF");
                  } 
                | WHILE bool_expr BEGINLOOP statements ENDLOOP{
                  printf("statement->WHILE bool_expr BEGINLOOP statements ENDLOOP");
                  }
                | DO BEGINLOOP statements ENDLOOP WHILE bool_expr{
                  printf("statement->DO BEGINLOOP statements ENDLOOP WHILE bool_expr");
                  }
                | READ variables{
                  printf("statement->READ variables");
                  }
                | WRITE variables{
                  printf("statement->WRITE variables");
                  }
                | CONTINUE{
                  printf("statement->CONTINUE");
                  }
                | RETURN expression{
                  printf("statement->RETURN expression");
                  }
                ;

bool_expr:      relation_and_expr{
                printf("bool_expr->relation_and_expr");
                }
                | relation_and_expr OR relation_and_expr{
                  printf("bool_expr->relation_and_expr OR relation_and_expr");
                  }
                ;

relation_and_expr:  relation_expr{
                    printf("relation_and_expr->relation_expr");
                    }
                    | relation_expr AND relation_expr{
                      printf("relation_and_expr->relation_expr AND relation_expr");
                      }
                    ;

relation_expr:    NOT relation_expr{
                  printf("relation_expr->NOT relation_expr");
                  }
                 | expression comparison expression{
                   printf("relation_expr->expression comparison expression");
                   }
                 | TRUE{
                   printf("relation_expr->TRUE");
                   }
                 | FALSE{
                   printf("relation_expr->FALSE");
                   }
                 | L_PAREN bool_expr R_PAREN{
                   printf("relation_expr->L_PAREN bool_expr R_PAREN");
                   }
                 ;

comparison:      EQ{
                 printf("comparison->EQ");
                 }
                 | NEQ{
                   printf("comparison->NEQ");
                   }
                 | LTE{
                   printf("comparison->LTE");
                   }
                 | GTE{
                   printf("comparison->GTE");
                   }
                 | LT{
                   printf("comparison->LT");
                   }
                 | GT{
                   printf("comparison->GT");
                   }
                 ;

 

multiplicative_expr:  term{
                      printf("multiplicative_expr->term");
                      }
                      | term MULT term{
                        printf("multiplicative_expr->term MULT term");
                        }
                      | term DIV term{
                        printf("multiplicative_expr->term DIV term");
                        }
                      | term MOD term{
                        printf("multiplicative_expr->term MOD term");
                        }
                      ;

term:           variable{
                printf("term->variable");
                }
                | SUB variable{
                  printf("term->SUB variable");
                  }
                | NUMBER{
                  printf("term->NUMBER");
                  }
                | SUB NUMBER{
                  printf("term->SUB NUMBER");
                  }
                | L_PAREN expression R_PAREN{
                  printf("term->L_PAREN expression R_PAREN");
          	  }
                | SUB L_PAREN expression R_PAREN{
                  printf("term->SUB L_PAREN expression R_PAREN");
                  }
                | IDENT L_PAREN expressions R_PAREN{
                  printf("term->IDENT L_PAREN expressions R_PAREN");
                  }
                ;

expressions:     /* empty */
                | expression{
                  printf("expressions->expression");
                  }
                | expression COMMA expressions{
                  printf("expressions->expression COMMA expressions");
                  }
                ;

variables:      variable{
                printf("variables->variable");
                }
                | variable COMMA variables{
                  printf("variables->variable COMMA variables");
                  }
                ; 

variable:       IDENT{
                printf("variable->IDENT");
                }
                | IDENT L_BRACKET expression R_BRACKET{
                  printf("variable->IDENT L_BRACKET expression R_BRACKET");
                  }
                ;
%%

int yyerror(string s)
{
  extern int yylineno;	// defined and maintained in lex.c
  extern char *yytext;	// defined and maintained in lex.c

  exit(1);
}

int yyerror(char *s)
{
   yyerror(string(s));
}


