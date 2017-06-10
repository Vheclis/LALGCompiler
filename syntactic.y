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

program:	PROGRAM_RESERVED IDENTIFIER SEMICOLON_SYMBOL body DOT_SYMBOL  { printf("Matched program\n"); }		|
			//error on PROGRAM_RESERVED
			error IDENTIFIER SEMICOLON_SYMBOL body DOT_SYMBOL			{printf("\nprogram expected\n" );}		|
			//error on IDENTIFIER
			PROGRAM_RESERVED error SEMICOLON_SYMBOL body DOT_SYMBOL		{printf("\nidentifier expected\n" );} 	| 
			//error on SEMICOLON_SYMBOL
			PROGRAM_RESERVED IDENTIFIER error body DOT_SYMBOL 			{printf("\n; expected\n" );} 			|
			//error on DOT_SYMBOL
			PROGRAM_RESERVED IDENTIFIER SEMICOLON_SYMBOL body error 	{printf("\n. expected\n" );}			;

body: 	dc BEGIN_RESERVED commands END_RESERVED 	{ printf("Matched body\n"); } 	/*| 
		//error on BEGIN_RESERVED
	  	dc error commands END_RESERVED	  |
	  	//erro on END_RESERVED
	  	dc BEGIN_RESERVED commands error*/;

dc:	dc_c dc_v dc_p 			{ printf("Matched dc\n"); }	;

dc_c: 	%empty 																								|
		CONST_RESERVED IDENTIFIER EQUAL_SYMBOL number SEMICOLON_SYMBOL dc_c { printf("Matched dc_c\n"); }	/*|  
		//error on CONST_RESERVED
	  	error IDENTIFIER EQUAL_SYMBOL number SEMICOLON_SYMBOL dc_c				|
	  	//error on IDENTIFIER
	  	CONST_RESERVED error EQUAL_SYMBOL number SEMICOLON_SYMBOL dc_c 			|
	  	//error on EQUAL_SYMBOL
	  	CONST_RESERVED IDENTIFIER error number SEMICOLON_SYMBOL dc_c 			|
	  	//error on SEMICOLON_SYMBOL
	  	CONST_RESERVED IDENTIFIER EQUAL_SYMBOL number error dc_c				*/;

dc_v: 	%empty 																								| 
		VAR_RESERVED variables COLON_SYMBOL var_type SEMICOLON_SYMBOL dc_v 	{ printf("Matched dc_v\n"); } 	/*| 
		//error on VAR_RESERVED
	  	error variables COLON_SYMBOL var_type SEMICOLON_SYMBOL dc_v		|
	  	//error on COLON_SYMBOL
	  	VAR_RESERVED variables error var_type SEMICOLON_SYMBOL dc_v		|
	  	//error on SEMICOLON_SYMBOL
	  	VAR_RESERVED variables COLON_SYMBOL var_type error dc_v			*/;

var_type: 	REAL_RESERVED			{ printf("Matched real reserved\n"); }		| 
		  	INTEGER_RESERVED 		{ printf("Matched integer reserved\n"); }	/*|
		  	//error on REAL_RESERVED or INTEGER_RESERVED
		  	error */;

variables: 	IDENTIFIER more_var 	{ printf("Matched variables\n"); }	/*| 
			//error on IDENTIFIER
		   	error more_var	 		*/;

more_var: 	%empty															| 
			COMMA_SYMBOL variables 	{ printf("Matched more variables\n"); }	/*|
			//error on COMMA_SYMBOL
		  	error variables			*/;

dc_p: 	%empty 				 												   									|
		PROCEDURE_RESERVED IDENTIFIER parameters SEMICOLON_SYMBOL body_p dc_p  { printf("Matched dc_p\n"); }	/*|
		//error on PROCEDURE_RESERVED
	  	error IDENTIFIER parameters SEMICOLON_SYMBOL body_p dc_p 	|
	  	//error on IDENTIFIER
	  	error parameters SEMICOLON_SYMBOL body_p dc_p 				|
	  	//error on SEMICOLON_SYMBOL
	  	error body_p dc_p											*/;

parameters: %empty 																			| 
			LEFT_PARENTHESIS par_list RIGHT_PARENTHESIS { printf("Matched parameters\n"); }	/*| 
			//error on LEFT_PARENTHESIS
			error par_list RIGHT_PARENTHESIS	|
			//error on RIGHT_PARENTHESIS
			error 							 	*/;

par_list: 	variables COLON_SYMBOL var_type more_par { printf("Matched a parameters list\n"); }	/*| 
			//error on COLON_SYMBOL
		  	error var_type more_par	*/;

more_par: 	%empty 																	|
			SEMICOLON_SYMBOL par_list 	{ printf("Matched  more parameters\n"); }	/*|
			//error on SEMICOLON_SYMBOL
		  	error par_list	*/;

body_p: dc_loc BEGIN_RESERVED commands END_RESERVED { printf("Matched body_p\n"); }	/*|
		//error on BEGIN_RESERVED
		error commands END_RESERVED |
		//error on END_RESERVED
		error 						*/;

dc_loc: dc_v { printf("Matched dc_loc\n"); }; //

arg_list: 	%empty 																				|
			LEFT_PARENTHESIS args RIGHT_PARENTHESIS { printf("Matched a arguments list\n"); }	/*|
			// error on LEFT_PARENTHESIS
		  	error args RIGHT_PARENTHESIS	|
		  	//error on RIGHT_PARENTHESIS
		  	error 							*/;
		  	
args: 	IDENTIFIER more_ident 	{ printf("Matched arguments\n"); }	/*|
		//error on IDENTIFIER
	  	error more_ident	*/;

more_ident: %empty 																| 
			SEMICOLON_SYMBOL args 	{ printf("Matched more identifiers\n"); }	/*|
			//error on SEMICOLON_SYMBOL
			error args 	*/;

falsep: %empty %prec NO_ELSE 															| 
		ELSE_RESERVED cmd 		{ printf("Matched else reserved\n"); }	/*|
		//error on ELSE_RESERVED
		error cmd 	*/;
	 	
commands: 	%empty 																| 
			cmd SEMICOLON_SYMBOL commands 	{ printf("Matched commands\n"); }	| 
			//error on SEMICOLON_SYMBOL
			error commands	; 
		//i created a call named 'aux_RWW' so i could
		//treat the error without making it ambiguos
cmd:	READ_RESERVED LEFT_PARENTHESIS aux_RWW  													{ printf("Matched read\n"); }		|
		WRITE_RESERVED LEFT_PARENTHESIS aux_RWW 													{ printf("Matched write\n"); }		|
		WHILE_RESERVED LEFT_PARENTHESIS aux_RWW  													{ printf("Matched while\n"); }		|
		IF_RESERVED condition THEN_RESERVED cmd falsep											{ printf("Matched if\n"); }			|
		IDENTIFIER ASSIGN_SYMBOL expression	 													{ printf("Matched assignment\n"); }	|
		IDENTIFIER arg_list														    			{ printf("Matched function\n"); }	|
		FOR_RESERVED IDENTIFIER ASSIGN_SYMBOL expression TO_RESERVED expression DO_RESERVED cmd { printf("Matched for\n"); }		| 
		BEGIN_RESERVED commands END_RESERVED 													{ printf("Matched scope\n"); }		/*| 
		//error on READ_RESERVED, WRITE_RESERVED or WHILE_RESERVED
		error LEFT_PARENTHESIS aux_RWW										  				|
		//error on LEFT_PARENTHESIS
		error aux_RWW																		|
		//error on IF_RESERVED
		error condition  THEN_RESERVED cmd falsep 											|
		//error on THEN_RESERVED
		error cmd falsep																	|
		//error on IDENTIFIER
		error ASSIGN_SYMBOL expression 														|
		//error on ASSIGN_SYMBOL
		error expression 																	|
		//error on IDENTIFIER with arg_list
		error arg_list																		|
		//error on FOR_RESERVED
		error IDENTIFIER ASSIGN_SYMBOL expression TO_RESERVED expression DO_RESERVED cmd 	|
		//error on for IDENTIFIER
		error ASSIGN_SYMBOL expression TO_RESERVED expression DO_RESERVED cmd 				|
		//error on for ASSIGN_SYMBOL
		error expression TO_RESERVED expression DO_RESERVED cmd 							|
		//error on for TO_RESERVED
		error expression DO_RESERVED cmd 													|
		//error on for DO_RESERVED
		error cmd 																			*/;

aux_RWW:	variables RIGHT_PARENTHESIS			 	 /*this matches if is read or write*/ |
			condition RIGHT_PARENTHESIS DO_RESERVED cmd		/*this matches if is a while*//*|
			//error on DO_RESERVED
			error cmd 				|
			//error on RIGHT_PARENTHESIS
			error DO_RESERVED cmd 	|
			error					*/;

condition: 	expression relation expression { printf("Matched condition\n"); }	;

relation: 	EQUAL_SYMBOL 		{ printf("Matched equal symbol\n"); }		| 
			DIF_SYMBOL 			{ printf("Matched dif symbol\n"); }			| 
			MAJOR_EQUAL_SYMBOL 	{ printf("Matched major equal sybol\n"); }	| 
			MINOR_EQUAL_SYMBOL 	{ printf("Matched minor equal symbol\n"); }	| 
			MINOR_SYMBOL 		{ printf("Matched minor symbol\n"); }		| 
			MAJOR_SYMBOL 		{ printf("Matched major symbol\n"); } 		/*|
			error 				*/;

expression: term other_terms { printf("Matched expression\n"); }	;

op_un: 	%empty															|
		PLUS_SYMBOL 			{ printf("Matched plus symbol\n"); }	| 
		MINUS_SYMBOL 			{ printf("Matched minus symbol\n"); }	/*| 
		error 				*/;

other_terms: 	%empty				   										|
				op_ad term other_terms { printf("Matched other terms\n"); }	; 
				

op_ad: 	PLUS_SYMBOL 			{ printf("Matched plus symbol\n"); }	| 
		MINUS_SYMBOL 			{ printf("Matched minus symbol\n"); }	/*| 
		error 				*/;

term: 	op_un factor more_factors { printf("Matched a term\n"); }	;

more_factors: 	%empty																|
				op_mul factor more_factors 	{ printf("Matched more factors\n"); }	; 
				

op_mul: MULTIPLICATION_SYMBOL 	{ printf("Matched multiplication symbol\n"); }	| 
		DIVISION_SYMBOL			{ printf("Matched division symbol\n"); }		/*|
		error 				*/;

factor: IDENTIFIER 										{ printf("Matched factor\n"); }	| 
		number 											{ printf("Matched factor\n"); }	|
		LEFT_PARENTHESIS expression RIGHT_PARENTHESIS 	{ printf("Matched factor\n"); }	/*| 
		//error on LEFT_PARENTHESIS
		error expression RIGHT_PARENTHESIS	|
		//error on RIGHT_PARENTHESIS
		error 			 					*/;

number: INTEGER 					{ printf("Matched a integer number\n"); }	| 
		REAL 						{ printf("Matched a real number\n"); }		/*|
		error	*/;

%%

void yyerror(char *string)
{
	fprintf(stderr, "\n%s is close to  %s. Line: %d; Column: %d.\n", string, yytext, line, column);
	
	
}

int main(int argc, char *argv[])
{
	yyparse();
	return 0;
} 	