%code{
	#include <stdio.h>
	#include <stdlib.h>
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
%token TO_RESERVED
%token IF_RESERVED
%token THEN_RESERVED
%token FOR_RESERVED
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

%%

program:	PROGRAM_RESERVED IDENTIFIER SEMICOLON_SYMBOL body DOT_SYMBOL 	| 
			error SEMICOLON_SYMBOL 											| 
		 	error DOT_SYMBOL												; //

body: 	dc BEGIN_RESERVED commands END_RESERVED 	| 
	  	error READ_RESERVED							| //comeco do first de cmd
	  	error WRITE_RESERVED						|
	  	error WHILE_RESERVED						|
	  	error IF_RESERVED							|
	  	error IDENTIFIER							|
	  	error FOR_RESERVED							|
	  	error BEGIN_RESERVED						| //fim do first de cmd
	  	error DOT_SYMBOL 							; 

dc:	dc_c dc_v dc_p 			| 
	error CONST_RESERVED 	| 
	error PROCEDURE_RESERVED; //

dc_c: 	CONST_RESERVED IDENTIFIER EQUAL_SYMBOL number SEMICOLON_SYMBOL dc_c | 
	  	%empty 					| 
	  	error IDENTIFIER	 	|
	  	error EQUAL_SYMBOL 		|
	  	error INTEGER 			|
	  	error REAL 				|
	  	error CONST_RESERVED	|
	  	error SEMICOLON_SYMBOL 	|
	  	error VAR_RESERVED		; //

dc_v: 	VAR_RESERVED variables COLON_SYMBOL var_type SEMICOLON_SYMBOL dc_v | 
	  	%empty 						| 
	  	error IDENTIFIER			|
	  	error SEMICOLON_SYMBOL 		|
	  	error REAL_RESERVED			|
	  	error VAR_RESERVED			|
	  	error PROCEDURE_RESERVED	; //

var_type: 	REAL_RESERVED			| 
		  	INTEGER_RESERVED 		|
		  	error SEMICOLON_SYMBOL 	|
		  	error RIGHT_PARENTHESIS	; //

variables: 	IDENTIFIER more_var 	| 
		   	error COLON_SYMBOL 		| 
		   	error RIGHT_PARENTHESIS	|
		   	error COMMA_SYMBOL		; //

more_var: 	COMMA_SYMBOL variables 	| 
		  	%empty					| 
		  	error IDENTIFIER		; //

dc_p: 	PROCEDURE_RESERVED IDENTIFIER parameters SEMICOLON_SYMBOL body_p dc_p | 
	  	%empty 				 	| 
	  	error SEMICOLON_SYMBOL 	|
	  	error IDENTIFIER 		|
	  	error VAR_RESERVED 		|
	  	error LEFT_PARENTHESIS 	|
	  	error BEGIN_RESERVED	; //

parameters: LEFT_PARENTHESIS par_list RIGHT_PARENTHESIS | 
			%empty 					| 
			error IDENTIFIER 		|
			error SEMICOLON_SYMBOL 	|
			error RIGHT_PARENTHESIS	; //

par_list: 	variables COLON_SYMBOL var_type more_par | 
		  	error REAL_RESERVED 	| 
		  	error INTEGER_RESERVED	; //

more_par: 	SEMICOLON_SYMBOL par_list | 
		  	%empty 			| 
		  	error IDENTIFIER; //

body_p: dc_loc BEGIN_RESERVED commands END_RESERVED | 
		error END_RESERVED 		|
		error READ_RESERVED		| //comeco do first de cmd
	  	error WRITE_RESERVED	|
	  	error WHILE_RESERVED	|
	  	error IF_RESERVED		|
	  	error IDENTIFIER		|
	  	error FOR_RESERVED		|
	  	error BEGIN_RESERVED	| //fim do first de cmd
		error PROCEDURE_RESERVED; 

dc_loc: dc_v; //

arg_list: 	LEFT_PARENTHESIS args RIGHT_PARENTHESIS | 
		  	%empty 					| 
		  	error IDENTIFIER 		|
		  	error RIGHT_PARENTHESIS | 
		  	error SEMICOLON_SYMBOL 	|
		  	error ELSE_RESERVED		; //

args: 	IDENTIFIER more_ident 	| 
	  	error SEMICOLON_SYMBOL	|
	  	error RIGHT_PARENTHESIS	; //

more_ident: SEMICOLON_SYMBOL args | 
			%empty 			| 
			error IDENTIFIER; //

falsep: ELSE_RESERVED cmd 		| 
		%empty 					| 
		error READ_RESERVED		| //comeco do first de cmd
	 	error WRITE_RESERVED	|
	  	error WHILE_RESERVED	|
	  	error IF_RESERVED		|
	  	error IDENTIFIER		|
	  	error FOR_RESERVED		|
	  	error BEGIN_RESERVED	| //fim do first de cmd
		error SEMICOLON_SYMBOL	;

commands: 	cmd SEMICOLON_SYMBOL commands | 
			%empty 						| 
			error SEMICOLON_SYMBOL 		| 
			error READ_RESERVED			| //comeco do first de cmd
	  		error WRITE_RESERVED		|
	  		error WHILE_RESERVED		|
	  		error IF_RESERVED			|
	  		error IDENTIFIER			|
	  		error FOR_RESERVED			|
	  		error BEGIN_RESERVED		| //fim do first de cmd
			error ELSE_RESERVED			;

cmd:	READ_RESERVED LEFT_PARENTHESIS variables RIGHT_PARENTHESIS 								|
		WRITE_RESERVED LEFT_PARENTHESIS variables RIGHT_PARENTHESIS								|
		WHILE_RESERVED LEFT_PARENTHESIS condition RIGHT_PARENTHESIS DO_RESERVED cmd 			|
		IF_RESERVED condition THEN_RESERVED cmd falsep											|
		IDENTIFIER ASSIGN_SYMBOL expression 													|
		IDENTIFIER arg_list														    			|
		FOR_RESERVED IDENTIFIER ASSIGN_SYMBOL expression TO_RESERVED expression DO_RESERVED cmd | 
		BEGIN_RESERVED commands END_RESERVED 													| 
		error LEFT_PARENTHESIS  |
		error DO_RESERVED		|
		error IDENTIFIER 		|
		error READ_RESERVED		| //comeco do first de cmd
		error WRITE_RESERVED	|
		error WHILE_RESERVED	|
		error IF_RESERVED		|
		error FOR_RESERVED		|
		error BEGIN_RESERVED	| //fim do first de cmd
		error SEMICOLON_SYMBOL  | 
		error ELSE_RESERVED	 	|
		error PLUS_SYMBOL	 	|
		error MINUS_SYMBOL 	 	|
		error DO_RESERVED  	 	|
		error ASSIGN_SYMBOL 	;

condition: 	expression relation expression;

relation: 	EQUAL_SYMBOL 		| 
			DIF_SYMBOL 			| 
			MAJOR_EQUAL_SYMBOL 	| 
			MINOR_EQUAL_SYMBOL 	| 
			MINOR_SYMBOL 		| 
			MAJOR_SYMBOL 		|
			error PLUS_SYMBOL	|
			error MINUS_SYMBOL	;

expression: term other_terms;

op_un: 	PLUS_SYMBOL 			| 
		MINUS_SYMBOL 			| 
		%empty					|
		error IDENTIFIER		|
		error INTEGER   		|
		error REAL 				|
		error LEFT_PARENTHESIS	;

other_terms: 	op_ad term other_terms | 
				%empty;

op_ad: 	PLUS_SYMBOL 			| 
		MINUS_SYMBOL			|
		error PLUS_SYMBOL		|
		error MINUS_SYMBOL		|
		error IDENTIFIER		|
		error INTEGER   		|
		error REAL 				|
		error LEFT_PARENTHESIS	;

term: 	op_un factor more_factors;

more_factors: 	op_mul factor more_factors | 
				%empty;

op_mul: MULTIPLICATION_SYMBOL | 
		DIVISION_SYMBOL			|
		error IDENTIFIER		|
		error INTEGER   		|
		error REAL 				|
		error LEFT_PARENTHESIS	;

factor: IDENTIFIER 										| 
		number 											| 
		LEFT_PARENTHESIS expression RIGHT_PARENTHESIS 	| 
		error RIGHT_PARENTHESIS							|
		error MULTIPLICATION_SYMBOL 					|
		error DIVISION_SYMBOL							|
		error PLUS_SYMBOL 								|
		error MINUS_SYMBOL								;

number: INTEGER 					| 
		REAL 						|
		error SEMICOLON_SYMBOL		|
		error MULTIPLICATION_SYMBOL |
		error DIVISION_SYMBOL		;

%%

void yyerror(char *string)
{
	
}

int main(int argc, char *argv[])
{
	yyparse();
	return 0;
}