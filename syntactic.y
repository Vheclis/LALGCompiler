%code{
	#include <stdio.h>
	#include <stdlib.h>
	extern int yylex();
	extern void yyerror(char *s);
	extern int line;
	extern int column;
}
%union {
	int intval;
	float realval;
	char* strval;
}

%token INTEGER
%token REAL
%token IDENTIFIER

%token PROGRAM_RESERVED
%token SEMICOLON_SYMBOL
%token BEGIN_RESERVED
%token END_RESERVED
%token CONST_RESERVED
%token EQUAL_SYMBOL
%token VAR_RESERVED
%token COLON_SYMBOL
%token DOT_SYMBOL
%token REAL_RESERVED
%token INTEGER_RESERVED
%token COMMA_SYMBOL
%token PROCEDURE_RESERVED
%token LEFT_PARENTHESIS
%token RIGHT_PARENTHESIS
%token ELSE_RESERVED
%token READ_RESERVED
%token WRITE_RESERVED
%token FOR_RESERVED
%token WHILE_RESERVED
%token DO_RESERVED
%token IF_RESERVED
%token THEN_RESERVED
%token ASSIGN_SYMBOL
%token DIF_SYMBOL
%token MAJOR_EQUAL_SYMBOL
%token MINOR_EQUAL_SYMBOL
%token MAJOR_SYMBOL
%token MINOR_SYMBOL
%token PLUS_SYMBOL
%token MINUS_SYMBOL
%token MULTIPLICATION_SYMBOL
%token DIVISION_SYMBOL

%precedence NO_ELSE
%precedence ELSE_RESERVED;

%%

program: PROGRAM_RESERVED IDENTIFIER SEMICOLON_SYMBOL body DOT_SYMBOL ;

body: dc BEGIN_RESERVED commands END_RESERVED;

dc: dc_c dc_v dc_p;

dc_c: CONST_RESERVED IDENTIFIER EQUAL_SYMBOL number SEMICOLON_SYMBOL dc_c | %empty;

dc_v: VAR_RESERVED variables COLON_SYMBOL var_type SEMICOLON_SYMBOL dc_v | %empty;

var_type: REAL_RESERVED | INTEGER_RESERVED;

variables: IDENTIFIER more_var;

more_var: COMMA_SYMBOL variables | %empty;

dc_p: PROCEDURE_RESERVED IDENTIFIER parameters SEMICOLON_SYMBOL body_p dc_p | %empty;

parameters: LEFT_PARENTHESIS par_list RIGHT_PARENTHESIS | %empty;

par_list: variables COLON_SYMBOL var_type more_par;

more_par: SEMICOLON_SYMBOL par_list | %empty;

body_p: dc_loc BEGIN_RESERVED commands END_RESERVED;

dc_loc: dc_v;

arg_list: LEFT_PARENTHESIS args RIGHT_PARENTHESIS | %empty;

args: IDENTIFIER more_ident;

more_ident: SEMICOLON_SYMBOL args | %empty;

falsep: %empty %prec NO_ELSE 	| 
		ELSE_RESERVED cmd 	;

commands: cmd SEMICOLON_SYMBOL commands | %empty;

cmd: READ_RESERVED LEFT_PARENTHESIS variables RIGHT_PARENTHESIS 	|
	 WRITE_RESERVED LEFT_PARENTHESIS variables RIGHT_PARENTHESIS	|
	 WHILE_RESERVED LEFT_PARENTHESIS (condition) DO_RESERVED cmd 	|
	 IF_RESERVED condition THEN_RESERVED cmd falsep					|
	 IDENTIFIER ASSIGN_SYMBOL expression 							|
	 IDENTIFIER arg_list											|
	 BEGIN_RESERVED commands END_RESERVED 							;

condition: expression relation expression;

relation: EQUAL_SYMBOL | DIF_SYMBOL | MAJOR_EQUAL_SYMBOL | MINOR_EQUAL_SYMBOL | MINOR_SYMBOL | MAJOR_SYMBOL;

expression: term other_terms;

op_un: PLUS_SYMBOL | MINUS_SYMBOL | %empty;

other_terms: op_ad term other_terms | %empty;

op_ad: PLUS_SYMBOL | MINUS_SYMBOL;

term: op_un factor more_factors;

more_factors: op_mul factor more_factors | %empty;

op_mul: MULTIPLICATION_SYMBOL | DIVISION_SYMBOL;

factor: IDENTIFIER | number | LEFT_PARENTHESIS expression RIGHT_PARENTHESIS;

number: int_number | int_real;
