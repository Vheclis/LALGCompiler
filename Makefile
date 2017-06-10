all:
	bison -d syntactic.y --output="syntactic.yy.c"
	flex --outfile="lexic.yy.c" lexic.l
	gperf reserved_words.txt > reserved_words.h
	gcc -o lalg syntactic.yy.c lexic.yy.c
run:
	lalg < example1.pas
clean:
	-rm -f syntactic.yy.c syntactic.yy.h lexic.yy.c lexic.yy.h reserved_words.h lalg
