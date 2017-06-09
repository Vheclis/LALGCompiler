all:
	bison -d syntactic.y --output="syntactic.yy.c"
	flex --outfile="lexic.yy.c" lexic.l
	gperf reserved_words.txt > reserved_words.h
	gcc -lfl -o lalg syntactic.yy.c lexic.yy.c
run:
	lalg < example1.pas
clean:
	rm syntatic.yy.c
	rm syntatic.yy.h
	rm lexic.yy.c
	rm lexic.yy.h
	rm reserved_words.h
