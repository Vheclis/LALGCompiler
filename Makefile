all:
	flex --outfile="lexic.yy.c" lexic.lex
	gperf reserved_words.txt > reserved_words.h
	gcc -o lexic lexic.yy.c
