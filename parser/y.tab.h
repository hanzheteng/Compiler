/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    NUMBER = 258,
    IDENT = 259,
    FUNCTION = 260,
    SEMICOLON = 261,
    BEGIN_LOCALS = 262,
    BEGIN_PARAMS = 263,
    END_PARAMS = 264,
    END_LOCALS = 265,
    BEGIN_BODY = 266,
    END_BODY = 267,
    INTEGER = 268,
    ARRAY = 269,
    OF = 270,
    IF = 271,
    THEN = 272,
    ENDIF = 273,
    ELSE = 274,
    WHILE = 275,
    DO = 276,
    BEGINLOOP = 277,
    ENDLOOP = 278,
    CONTINUE = 279,
    READ = 280,
    WRITE = 281,
    L_BRACKET = 282,
    R_BRACKET = 283,
    TRUE = 284,
    FALSE = 285,
    RETURN = 286,
    COLON = 287,
    COMMA = 288,
    L_PAREN = 289,
    R_PAREN = 290,
    L_SQUARE_BRACKET = 291,
    R_SQUARE_BRACKET = 292,
    ASSIGN = 293,
    AND = 294,
    OR = 295,
    NOT = 296,
    SUB = 297,
    ADD = 298,
    MULT = 299,
    DIV = 300,
    MOD = 301,
    EQ = 302,
    NEQ = 303,
    LT = 304,
    GT = 305,
    LTE = 306,
    GTE = 307
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 11 "mini_l.y" /* yacc.c:1909  */

  int		int_val;
  string*	op_val;

#line 112 "y.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
