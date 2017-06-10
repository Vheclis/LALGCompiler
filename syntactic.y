%{
	#include <stdio.h>
	#include <stdlib.h>
	int yylex();
	void yyerror(char *s);
	extern int line;
	extern char *yytext;
	extern int column;
%}
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

%precedence NO_ELSE
%precedence ELSE_RESERVED

%%

program:	PROGRAM_RESERVED IDENTIFIER SEMICOLON_SYMBOL body DOT_SYMBOL  { printf("Matched program\n"); }	/*| 
			error SEMICOLON_SYMBOL 											| 
		 	error DOT_SYMBOL												*/; //

body: 	dc BEGIN_RESERVED commands END_RESERVED 	{ printf("Matched body\n"); } /*| 
	  	error READ_RESERVED							| //comeco do first de cmd
	  	error WRITE_RESERVED						|
	  	error WHILE_RESERVED						|
	  	error IF_RESERVED							|
	  	error IDENTIFIER							|
	  	error FOR_RESERVED							|
	  	error BEGIN_RESERVED						| //fim do first de cmd
	  	error DOT_SYMBOL 							*/; 

dc:	dc_c dc_v dc_p 			{ printf("Matched dc\n"); }/*| 
	error CONST_RESERVED 	| 
	error PROCEDURE_RESERVED*/; //

dc_c: 	%empty 																{ printf("dc_c is empty\n"); }	|
		CONST_RESERVED IDENTIFIER EQUAL_SYMBOL number SEMICOLON_SYMBOL dc_c { printf("Matched dc_c\n"); }	/*|  
	  	error IDENTIFIER	 	|
	  	error EQUAL_SYMBOL 		|
	  	error INTEGER 			|
	  	error REAL 				|
	  	error CONST_RESERVED	|
	  	error SEMICOLON_SYMBOL 	|
	  	error VAR_RESERVED		*/; //

dc_v: 	%empty 																{ printf("dc_v is empty\n"); }	| 
		VAR_RESERVED variables COLON_SYMBOL var_type SEMICOLON_SYMBOL dc_v 	{ printf("Matched dc_v\n"); } 	/*| 
	  	error IDENTIFIER			|
	  	error SEMICOLON_SYMBOL 		|
	  	error REAL_RESERVED			|
	  	error VAR_RESERVED			|
	  	error PROCEDURE_RESERVED	*/; //

var_type: 	REAL_RESERVED			{ printf("Matched real reserved\n"); }		| 
		  	INTEGER_RESERVED 		{ printf("Matched integer reserved\n"); }	/*|
		  	error SEMICOLON_SYMBOL 	|
		  	error RIGHT_PARENTHESIS	*/; //

variables: 	IDENTIFIER more_var 	{ printf("Matched variables\n"); }	/*| 
		   	error COLON_SYMBOL 		| 
		   	error RIGHT_PARENTHESIS	|
		   	error COMMA_SYMBOL		*/; //

more_var: 	%empty															| 
			COMMA_SYMBOL variables 	{ printf("Matched more variables\n"); }	/*|
		  	error IDENTIFIER		*/; //

dc_p: 	%empty 				 												   { printf("dc_p is empty\n"); }	|
		PROCEDURE_RESERVED IDENTIFIER parameters SEMICOLON_SYMBOL body_p dc_p  { printf("Matched dc_p\n"); }	/*| 
	  	error SEMICOLON_SYMBOL 	|
	  	error IDENTIFIER 		|
	  	error VAR_RESERVED 		|
	  	error LEFT_PARENTHESIS 	|
	  	error BEGIN_RESERVED	*/; //

parameters: %empty 																			| 
			LEFT_PARENTHESIS par_list RIGHT_PARENTHESIS { printf("Matched parameters\n"); }	/*| 
			error IDENTIFIER 		|
			error SEMICOLON_SYMBOL 	|
			error RIGHT_PARENTHESIS	*/; //

par_list: 	variables COLON_SYMBOL var_type more_par { printf("Matched a parameters list\n"); }	/*| 
		  	error REAL_RESERVED 	| 
		  	error INTEGER_RESERVED	*/; //

more_par: 	%empty 																	/*|
			SEMICOLON_SYMBOL par_list 	{ printf("Matched  moew parameters\n"); }	|
		  	error IDENTIFIER*/; //

body_p: dc_loc BEGIN_RESERVED commands END_RESERVED { printf("Matched body_p\n"); } /*|
		error END_RESERVED 		|
		error READ_RESERVED		| //comeco do first de cmd
	  	error WRITE_RESERVED	|
	  	error WHILE_RESERVED	|
	  	error IF_RESERVED		|
	  	error IDENTIFIER		|
	  	error FOR_RESERVED		|
	  	error BEGIN_RESERVED	| //fim do first de cmd
		error PROCEDURE_RESERVED*/; 

dc_loc: dc_v { printf("Matched dc_loc\n"); }; //

arg_list: 	%empty 																				|
			LEFT_PARENTHESIS args RIGHT_PARENTHESIS { printf("Matched a arguments list\n"); }	/*|
		  	error IDENTIFIER 		|
		  	error RIGHT_PARENTHESIS | 
		  	error SEMICOLON_SYMBOL 	|
		  	error ELSE_RESERVED		*/; //

args: 	IDENTIFIER more_ident 	{ printf("Matched arguments\n"); }	/*|
	  	error SEMICOLON_SYMBOL	|
	  	error RIGHT_PARENTHESIS	*/; //

more_ident: %empty 																| 
			SEMICOLON_SYMBOL args 	{ printf("Matched more identifiers\n"); }	/*|
			error IDENTIFIER*/; //

falsep: %empty %prec NO_ELSE 															| 
		ELSE_RESERVED cmd 		{ printf("Matched else reserved\n"); }	/*|
		error READ_RESERVED		| //comeco do first de cmd
	 	error WRITE_RESERVED	|
	  	error WHILE_RESERVED	|
	  	error IF_RESERVED		|
	  	error IDENTIFIER		|
	  	error FOR_RESERVED		|
	  	error BEGIN_RESERVED	| //fim do first de cmd
		error SEMICOLON_SYMBOL	*/;

commands: 	%empty 																| 
			cmd SEMICOLON_SYMBOL commands 	{ printf("Matched commands\n"); }	/*| 
			error SEMICOLON_SYMBOL 		| 
			error READ_RESERVED			| //comeco do first de cmd
	  		error WRITE_RESERVED		|
	  		error WHILE_RESERVED		|
	  		error IF_RESERVED			|
	  		error IDENTIFIER			|
	  		error FOR_RESERVED			|
	  		error BEGIN_RESERVED		| //fim do first de cmd
			error ELSE_RESERVED			*/;

cmd:	READ_RESERVED LEFT_PARENTHESIS variables RIGHT_PARENTHESIS 								{ printf("Matched read\n"); }		|
		WRITE_RESERVED LEFT_PARENTHESIS variables RIGHT_PARENTHESIS								{ printf("Matched write\n"); }		|
		WHILE_RESERVED LEFT_PARENTHESIS condition RIGHT_PARENTHESIS DO_RESERVED cmd 			{ printf("Matched while\n"); }		|
		IF_RESERVED condition THEN_RESERVED cmd falsep											{ printf("Matched if\n"); }			|
		IDENTIFIER ASSIGN_SYMBOL expression 													{ printf("Matched assignment\n"); }	|
		IDENTIFIER arg_list														    			{ printf("Matched function\n"); }	|
		FOR_RESERVED IDENTIFIER ASSIGN_SYMBOL expression TO_RESERVED expression DO_RESERVED cmd { printf("Matched for\n"); }		| 
		BEGIN_RESERVED commands END_RESERVED 													{ printf("Matched scope\n"); }		/*| 
		error LEFT_PARENTHESIS  |
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
		error ASSIGN_SYMBOL 	*/;

condition: 	expression relation expression { printf("Matched condition\n"); }	;

relation: 	EQUAL_SYMBOL 		{ printf("Matched equal symbol\n"); }		| 
			DIF_SYMBOL 			{ printf("Matched dif symbol\n"); }			| 
			MAJOR_EQUAL_SYMBOL 	{ printf("Matched major equal sybol\n"); }	| 
			MINOR_EQUAL_SYMBOL 	{ printf("Matched minor equal symbol\n"); }	| 
			MINOR_SYMBOL 		{ printf("Matched minor symbol\n"); }		| 
			MAJOR_SYMBOL 		{ printf("Matched major symbol\n"); } 		/*|
			error PLUS_SYMBOL	|
			error MINUS_SYMBOL	*/;

expression: term other_terms { printf("Matched expression\n"); }	;

op_un: 	%empty															|
		PLUS_SYMBOL 			{ printf("Matched plus symbol\n"); }	| 
		MINUS_SYMBOL 			{ printf("Matched minus symbol\n"); }	/*| 
		error IDENTIFIER		|
		error INTEGER   		|
		error REAL 				|
		error LEFT_PARENTHESIS	*/;

other_terms: 	%empty				   										|
				op_ad term other_terms { printf("Matched other terms\n"); }	; 
				

op_ad: 	PLUS_SYMBOL 			{ printf("Matched plus symbol\n"); }	| 
		MINUS_SYMBOL 			{ printf("Matched minus symbol\n"); }	/*| 
		error PLUS_SYMBOL		|
		error MINUS_SYMBOL		|
		error IDENTIFIER		|
		error INTEGER   		|
		error REAL 				|
		error LEFT_PARENTHESIS	*/;

term: 	op_un factor more_factors { printf("Matched a term\n"); }	;

more_factors: 	%empty																|
				op_mul factor more_factors 	{ printf("Matched more factors\n"); }	; 
				

op_mul: MULTIPLICATION_SYMBOL 	{ printf("Matched multiplication symbol\n"); }	| 
		DIVISION_SYMBOL			{ printf("Matched division symbol\n"); }		/*|
		error IDENTIFIER		|
		error INTEGER   		|
		error REAL 				|
		error LEFT_PARENTHESIS	*/;

factor: IDENTIFIER 										{ printf("Matched factor\n"); }	| 
		number 											{ printf("Matched factor\n"); }	|
		LEFT_PARENTHESIS expression RIGHT_PARENTHESIS 	{ printf("Matched factor\n"); }	/*| 
		error RIGHT_PARENTHESIS							|
		error MULTIPLICATION_SYMBOL 					|
		error DIVISION_SYMBOL							|
		error PLUS_SYMBOL 								|
		error MINUS_SYMBOL								*/;

number: INTEGER 					{ printf("Matched a integer number\n"); }	| 
		REAL 						{ printf("Matched a real number\n"); }		/*|
		error SEMICOLON_SYMBOL		|
		error MULTIPLICATION_SYMBOL |
		error DIVISION_SYMBOL		*/;

%%

void yyerror(char *string)
{
	fprintf(stderr, "%s is close to  %s. Column %d; line %d", string, yytext, column, line);
}

int main(int argc, char *argv[])
{
	yyparse();
	return 0;
} 	