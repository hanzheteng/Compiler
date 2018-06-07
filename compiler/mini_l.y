/* mini_l parser */
/* mini_l.y */
/* Author: Zhenxiao Qi, Hanzhe Teng */

%{
  #include "heading.h"
  void yyerror(const char *);
  int yylex(void);
  string program_code;
  int comment_on = 1;
%}

%union{
  int   int_val;
  char* op_val;
  struct state{
    string code;
    string id;    // identifier
    string ids[10];  // id list, max = 10
    int id_num;
    string temp;    // temp variable
    string label_true;
    string label_false;
    //uint length;
    //symbol_type type;
  }state;

}

%error-verbose
%start	input 

%token  <int_val> NUMBER
%token  <op_val> IDENT
%token  FUNCTION SEMICOLON BEGIN_LOCALS BEGIN_PARAMS END_PARAMS END_LOCALS BEGIN_BODY END_BODY
%token  INTEGER ARRAY OF IF THEN ENDIF ELSE WHILE DO BEGINLOOP ENDLOOP CONTINUE READ WRITE
%token  TRUE FALSE RETURN COLON COMMA  
%token  L_PAREN R_PAREN L_SQUARE_BRACKET R_SQUARE_BRACKET ASSIGN 
%left   AND OR NOT SUB ADD MULT DIV MOD EQ NEQ LT GT LTE GTE


%type <state> identifiers identifier functions function 
%type <state> declarations declaration statement statements
%type <state> variables variable term expression expressions
%type <state> bool_expr multiplicative_expr relation_and_expr relation_expr
%type <op_val> comparison
%type <int_val> number

%%
input:		program{
                if(comment_on) printf("input->program\n");
                }
	        ;

program:	functions{
                program_code = $1.code;
                if(comment_on) printf("program->functions\n");
                }
	        ;

functions:      /* empty */{     //done this one
                $$.code = "";
                if(comment_on) printf("functions->empty\n");
                }
                | function functions{
                  $$.code = $1.code + "\n" + $2.code;
                  if(comment_on) printf("functions->function functions\n");
                  }
                ;

function:	FUNCTION identifier SEMICOLON BEGIN_PARAMS declarations END_PARAMS BEGIN_LOCALS declarations END_LOCALS BEGIN_BODY statements END_BODY{
                string param_init;      //done this one
                int cnt = 0;
                while($5.id_num--) {param_init += gen_param_init($5.ids[cnt++]);}  //while
                $$.code = gen("func", $2.id) + $5.code + param_init + $8.code + $11.code + "endfunc";
                }
                | error {yyerrok;yyclearin;}
                ;

declarations:   /* empty */ {      //done this one
                $$.code = "";
                if(comment_on) printf("declarations->empty\n");
                }
                | declaration SEMICOLON declarations{
                  $$.code = $1.code + $3.code;
                  if(comment_on) printf("declarations->declaration SEMICOLON declarations\n");
                  }
                ;

declaration:    identifiers COLON INTEGER{      //done this one
                int cnt = 0;
                while($1.id_num--) {$$.code += gen(".", $1.ids[cnt++]);}  //while
                if(comment_on) printf("declaration->identifiers COLON INTEGER\n");
                }
                | identifiers COLON ARRAY L_SQUARE_BRACKET number R_SQUARE_BRACKET OF INTEGER{
                  int cnt = 0;
                  while($1.id_num--) {$$.code += gen(".[]", $1.ids[cnt++], number);}  //while
                  if(comment_on) printf("declaration->identifiers COLON ARRAY L_SQUARE_BRACKET number R_SQUARE_BRACKET OF INTEGER\n");
                  }
                | error {yyerrok;yyclearin;}
                ;

statements:     statement SEMICOLON{     //done this one
                $$.code = $1.code;
                if(comment_on) printf("statements->statement SEMICOLON\n");
                }
                | statement SEMICOLON statements{
                  $$.code = $1.code + $3.code;
                  if(comment_on) printf("statements->statement SEMICOLON statements\n");
                  }
                ;


statement:      variable ASSIGN expression{
                $$.code = $1.code;
                if(comment_on) printf("statement->variable ASSIGN expression\n");
                }
                | IF bool_expr THEN statements ENDIF{
                  $$.label_true = new_label();
                  $$.label_false = new_label();
                  $$.code = $2.code;
                  $$.code +=
                  gen("?:=", $$.label_true, $2.temp) +//continue!!!!!!!! 
                  gen(":=", $$.label_false) +
                  gen(":", $$.label_true) +
                  $4.code +
                  gen(":", $$.label_false);
                  if(comment_on) printf("statement->IF bool_expr THEN statements ENDIF\n");
                  }
                | IF bool_expr THEN statements ELSE statements ENDIF{
                  $$.code = $2.code +
                  gen("?:=", $$.label_false, $2.temp) +
                  $4.code +
                  $6.code;
                  //not uesful yet
                  if(comment_on) printf("statement->IF bool_expr THEN statements ELSE statements ENDIF\n");
                  } 
                | WHILE bool_expr BEGINLOOP statements ENDLOOP{
                  
                  if(comment_on) printf("statement->WHILE bool_expr BEGINLOOP statements ENDLOOP\n");
                  }
                | DO BEGINLOOP statements ENDLOOP WHILE bool_expr{
                  if(comment_on) printf("statement->DO BEGINLOOP statements ENDLOOP WHILE bool_expr\n");
                  }
                | READ variables{
                  $$.code = gen(".<", $2.id);
                  if(comment_on) printf("statement->READ variables\n");
                  }
                | WRITE variables{
                   $$.code = gen(".>", $2.id); 
                  if(comment_on) printf("statement->WRITE variables\n");
                  }
                | CONTINUE{
                  if(comment_on) printf("statement->CONTINUE\n");
                  }
                | RETURN expression{
                  $$.code = gen("ret", $2.temp);
                  if(comment_on) printf("statement->RETURN expression\n");
                  }
                | error {yyerrok;yyclearin;}
                ;

bool_expr:      relation_and_expr{    //done this one
                $$.temp = $1.temp;
                $$.code = $1.code;
                if(comment_on) printf("bool_expr->relation_and_expr\n");
                }
                | relation_and_expr OR bool_expr{
                  $$.temp = new_temp();
                  $$.code = $1.code + $3.code + gen("||", $$.temp, $1.temp, $3.temp);
                  if(comment_on) printf("bool_expr->relation_and_expr OR bool_expr\n");
                  }
                ;

relation_and_expr:  relation_expr{   //done this one
                    $$.temp = $1.temp;
                    $$.code = $1.code;
                    if(comment_on) printf("relation_and_expr->relation_expr\n");
                    }
                    | relation_expr AND relation_and_expr{
                      $$.temp = new_temp();
                      $$.code = $1.code + $3.code + gen("&&", $$.temp, $1.temp, $3.temp);
                      if(comment_on) printf("relation_and_expr->relation_expr AND relation_and_expr\n");
                      }
                    ;

relation_expr:    NOT relation_expr{    //done this one
                  $$.temp = $2.temp;
                  $$.code = $2.code + gen("!", $$.temp, $$.temp);
                  if(comment_on) printf("relation_expr->NOT relation_expr\n");
                  }
                 | expression comparison expression{
                   $$.temp = new_temp();
                   $$.code = $1.code + $3.code + gen(comparison, $$.temp, $1.temp, $3.temp);
                   if(comment_on) printf("relation_expr->expression comparison expression\n");
                   }
                 | TRUE{
                   $$.temp = new_temp();
                   $$.code = gen("=", $$.temp, to_string(1));
                   if(comment_on) printf("relation_expr->TRUE\n");
                   }
                 | FALSE{
                   $$.temp = new_temp();
                   $$.code = gen("=", $$.temp, to_string(0));
                   if(comment_on) printf("relation_expr->FALSE\n");
                   }
                 | L_PAREN bool_expr R_PAREN{
                   $$.temp = $2.temp;
                   $$.code = $2.code;
                   if(comment_on) printf("relation_expr->L_PAREN bool_expr R_PAREN\n");
                   }
                 ;

comparison:      EQ{  //done this one
                 $$ = "==";
                 if(comment_on) printf("comparison->EQ\n");
                 }
                 | NEQ{
                   $$ = "!=";
                   if(comment_on) printf("comparison->NEQ\n");
                   }
                 | LTE{
                   $$ = "<=";
                   if(comment_on) printf("comparison->LTE\n");
                   }
                 | GTE{
                   $$ = ">=";
                   if(comment_on) printf("comparison->GTE\n");
                   }
                 | LT{
                   $$ = "<";
                   if(comment_on) printf("comparison->LT\n");
                   }
                 | GT{
                   $$ = ">";
                   if(comment_on) printf("comparison->GT\n");
                   }
                 ;

expressions:      /* empty */ {
                  $$.code = "";
                  if(comment_on) printf("expressions->empty\n");
                  }
                | expression{
                  if(comment_on) printf("expressions->expression\n");
                  }
                | expression COMMA expressions{
                  if(comment_on) printf("expressions->expression COMMA expressions\n");
                  }
                ;

expression:        multiplicative_expr{
                   $$.code = $1.code;
                   $$.temp = $1.temp;
                   if(comment_on) printf("expression->multiplicative_expr\n");
                   }
                 | multiplicative_expr ADD expression{
                   //写到这 最后的return加起来的code expression里已经生成了上面部分的代码
                   $$.temp = new_temp();
                   $$.code = $1.code;
                   $$.code +=
                   $3.code +
                   gen(".", $$.temp) +
                   gen("+", $$.temp, $1.temp, $3.temp);//order matters????
                   if(comment_on) printf("expression->multiplicative_expr ADD expression\n");
                   } 
                 | multiplicative_expr SUB expression{
                   if(comment_on) printf("expression->multiplicative_expr SUB expression\n");
                   } 
                 ;

multiplicative_expr:  term{
                      $$.code = $1.code;
                      $$.temp = $1.temp;
                      if(comment_on) printf("multiplicative_expr->term\n");
                      }
                      | term MULT multiplicative_expr{
                        
                        if(comment_on) printf("multiplicative_expr->term MULT multiplicative_expr\n");
                        }
                      | term DIV multiplicative_expr{
                        if(comment_on) printf("multiplicative_expr->term DIV multiplicative_expr\n");
                        }
                      | term MOD multiplicative_expr{
                        if(comment_on) printf("multiplicative_expr->term MOD multiplicative_expr\n");
                        }
                      ;

term:           variable{
                $$.code = $1.code;
                $$.temp = $1.temp;
                if(comment_on) printf("term->variable\n");
                }
                | SUB variable{
                  if(comment_on) printf("term->SUB variable\n");
                  }
                | number{
                  $$.code = $1.code;
                  $$.temp = $1.temp;//do we need to track the temp??
                  if(comment_on) printf("term->number\n");
                  }
                | SUB number{
                  if(comment_on) printf("term->SUB number\n");
                  }
                | L_PAREN expression R_PAREN{
                  if(comment_on) printf("term->L_PAREN expression R_PAREN\n");
          	  }
                | SUB L_PAREN expression R_PAREN{
                  if(comment_on) printf("term->SUB L_PAREN expression R_PAREN\n");
                  }
                | identifier L_PAREN expressions R_PAREN{
                  $$.temp = new_temp();//this is to store the return value
                  $$.code = $3.code;
                  $$.code += 
                  gen("param", $3.temp) +
                  gen(".", $$.temp) +
                  gen("call", $1.id, $$.temp); 
                  if(comment_on) printf("term->identifier L_PAREN expressions R_PAREN\n");
                  }
                ;

variables:      variable{
                $$.code = $1.code;
                $$.id = $1.id;
                if(comment_on) printf("variables->variable\n");
                }
                | variable COMMA variables{
                  if(comment_on) printf("variables->variable COMMA variables\n");
                  }
                ; 

variable:       identifier{
                $$.id = $1.id;
                $$.temp = new_temp();//generate temo here
                $$.code =
                gen(".", $$.temp) +
                gen("=", $$.temp, string($1));
                if(comment_on) printf("variable->identifier\n");
                }
                | identifier L_SQUARE_BRACKET expression R_SQUARE_BRACKET{
                  if(comment_on) printf("variable->identifier L_SQUARE_BRACKET expression R_SQUARE_BRACKET\n");
                  }
                ;

identifiers:    identifier{   //done this one
                $$.ids[0] = $1.id;
                $$.id_num = 1;
                if(comment_on) printf("identifiers->identifier\n");
                }
                | identifier COMMA identifiers{
                  $$.ids[0] = $1.id;
                  $$.id_num = 1;
                  int cnt = 0;
                  while($3.id_num--) {$$.ids[$$.id_num++] = $3.ids[cnt++];} //copy remaining ids
                  if(comment_on) printf("identifiers->identifier COMMA identifiers\n");
                  }
                ;

identifier:     IDENT{   //done this one
                $$.id = yylval.op_val;
                if(comment_on) printf("identifier->IDENT %s\n", yylval.op_val);
                }
                ;

number:         NUMBER{    // need to pay attention
                $$ = yylval.int_val;
                /*$$.temp = new_temp();
                $$.code +=
                gen(".", $$.temp) +
                gen("=", $$.temp, $1);*/
                if(comment_on) printf("number->NUMBER %d\n", yylval.int_val);
                }
                ;
%%

void yyerror(const char * msg)
{
  extern int line_num;
  extern int column;
  printf("** Line %d, position %d: %s\n", line_num, column, msg);
  //exit(1);
}

string new_label(){
  static int count = 0;
  return "__label__" + to_string(count++);
}

string new_temp(){
  static int count = 0;
  return "__temp__" + to_string(count++);
}

string gen_param_init(string id){
  static int count = 0;
  return "= " + id + ", $" + to_string(count++) + "\n";
}

string gen(string operator, string operand1){
  return operator + " " + operand1 + "\n";
}

string gen(string operator, string operand1, string operand2){
  return operator + " " + operand1 + ", " + operand2 + "\n";
}

string gen(string operator, string operand1, string operand2, string operand3){
  return operator + " " + operand1 + ", " + operand2 + ", " + operand3 + "\n";
}

int main(int argc, char **argv)
{
  if ((argc > 1) && (freopen(argv[1], "r", stdin) == NULL))
  {
    cerr << argv[0] << ": File " << argv[1] << " cannot be opened.\n";
    exit( 1 );
  }

  yyparse();

  ofstream file;
  file.open("program.mil");
  file << program_code;
  file.close(); 

  return 0;
}
