%{
	#include <stdio.h>
	#include <stdlib.h>
	#include "reserved_words.h"

	enum special_tokens
	{
		IDENTIFIER = 0,
		INTEGER,
		REAL
	}

	char * special_names[]
	{
		"IDENTIFIER",
		"INTEGER_NUMBER",
		"REAL_NUMBER"
	}

	int line_number = 1;

	void printSpecial(char *, char *);
	void printSpecial(char *);
	void error();

%}

%% //Rules

\{.*\}														{ /* Commentary LALG */ }
[ \t\r]														{ /* Line Spacing */ }
\n 																{ /* Line Break */ }

[0-9]+														{ printSpecial(yytext, special_names[INTEGER]) } /* Integer Number */
[0-9]+\.[0-9]+										{ printSpecial(yytext, special_names[REAL]) } /* Real Number */

[:=><]{2}													{ printSymbol(yytex); } /* Operators and Comparer */
[+\-\*\/\(\)\[\]\.,;:=><]					{ printSymbol(yytex); } /* Operators and Comparer */

[a-zA-Z][a-zA-Z0-9_]*							{ printLexical(yytex); } /* Identifiers and Reserved Words */

.																	{ error(); } /* Error */

%%

void printSpecial(char *str, char *token)
{
	printf("%s - %s\n",text, token );
	return;
}

void printSpecial(char *str)
{
}

void printSymbol(char* str)
{

}
