%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include "reserved_words.h"

	enum special_tokens
	{
		IDENTIFIER = 0,
		INTEGER,
		REAL
	};

	enum args
	{
		ARG_EXE = 0,
		ARG_FILE,
		ARG_SIZE
	};

	char* special_names[] =
	{
		"IDENTIFIER",
		"INTEGER_NUMBER",
		"REAL_NUMBER"
	};

	int col_count = 1;
	int lin_count = 1;

	void print_specific(char* str, char* token);
	void print_symbol(char* str);
	void print_lexical(char* str);
	void error(char *);

	FILE* yyin;

%}
%option noyywrap
%% //Rules

\{.*\}							{ col_count =+ strlen(yytext); } /* Commentary LALG */ 
[ \t\r]							{ col_count++; } /* Line Spacing */
\n 								{ lin_count++; col_count = 0 } /* Line Break */

[0-9]+							{ col_count += strlen(yytext); print_specific(yytext, special_names[INTEGER]); } /* Integer Number */
[0-9]+\.[0-9]+					{ col_count += strlen(yytext); print_specific(yytext, special_names[REAL]); } /* Real Number */

[:=><]{2}						{ col_count += strlen(yytext); print_symbol(yytext); } /* Operators and Comparer */
[+\-\*\/\(\)\[\]\.,;:=><]		{ col_count += strlen(yytext); print_symbol(yytext); } /* Operators and Comparer */

[a-zA-Z][a-zA-Z0-9_]*			{ col_count += strlen(yytext); print_lexical(yytext); } /* Identifiers and Reserved Words */

.								{ error(yytext); } /* Error */

%%

/* Print specific lexical, like numbers */
void print_specific(char* str, char* token)
{
	printf("%s - %s\n", str, token); // Print input and lexical
}

/* Print symbol lexical, like operators and comparer */
void print_symbol(char* str)
{
	char alt[2]; // For alternative double 1 character lexical

	// Look for lexical in perfect hash function
	// generated by gperf (see reserved_words.h)
	const WORD* hash_word = in_word_set(str, strlen(str));

	if(hash_word) // Print if in hash-table
		printf("%s - %s\n", hash_word->name, hash_word->token);
	else if (strlen(str) == 2) // If we have double character
	{
		// Try match the first character symbol
		alt[0] = str[0];
		print_symbol(alt);

		// Try match the second character symbol
		alt[1] = str[1];
		print_symbol(alt);
	}
	else // Otherwise it's an error
		error(str);
}

/* Print any other lexical, like keywords and identifiers */
void print_lexical(char* str)
{
	// Look for lexical in perfect hash function
	// generated by gperf (see reserved_words.h)
	const WORD* hash_word = in_word_set(str, strlen(str));

	if(hash_word) // Print if in hash-table
		printf("%s - %s\n", hash_word->name, hash_word->token);
	else // Print identifier otherwise
		print_specific(str, special_names[IDENTIFIER]);
}

/* Print error */
void error(char *str)
{
	printf("%s - ERROR\n", str);
}

/* Main read from file and from input */
int main(int argc, char *argv[])
{
	if(argc == ARG_SIZE) // Read from file if has arguments
	{
		yyin = fopen(argv[ARG_FILE], "r");
		yylex();
		fclose(yyin);
	}
	else // Read from stdin
		yylex();
}
