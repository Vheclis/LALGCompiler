%{
	#include <stdio.h>
	#include <stdlib.h>

	enum special_tokens
	{
		IDENTIFIER = 0,
		INTEGER,
		REAL
	}

	char * special_names[]
	{
		"IDENTIFIER_RESERVED",
		"INTEGER_RESERVED",
		"REAL_RESERVED"
	}

	int column_counter = 1;
	int line_counter = 1;
	
%}

%% //Rules

[0-9]+						{ column_counter += strlen(yytext); printReservedWord(yytext, special_names[INTEGER]) }
[0-9]+\.[0-9]+				{ column_counter += strlen(yytext); printReservedWord(yytext, special_names[REAL]) }
[ \t\r]						{ column_counter++; }
\n 							{ column_counter = 0; line_counter++ }
\{.*\}						{ column_counter += strlen(yytext); }

%%

void printReservedWord(char *inputText, char *special_token)
{
	printf("< %s - %s >\n",inputText, special_token );
	return ;
}