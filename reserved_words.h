/* ANSI-C code produced by gperf version 3.1 */
/* Command-line: gperf reserved_words.txt  */
/* Computed positions: -k'1-2,4' */

#if !((' ' == 32) && ('!' == 33) && ('"' == 34) && ('#' == 35) \
      && ('%' == 37) && ('&' == 38) && ('\'' == 39) && ('(' == 40) \
      && (')' == 41) && ('*' == 42) && ('+' == 43) && (',' == 44) \
      && ('-' == 45) && ('.' == 46) && ('/' == 47) && ('0' == 48) \
      && ('1' == 49) && ('2' == 50) && ('3' == 51) && ('4' == 52) \
      && ('5' == 53) && ('6' == 54) && ('7' == 55) && ('8' == 56) \
      && ('9' == 57) && (':' == 58) && (';' == 59) && ('<' == 60) \
      && ('=' == 61) && ('>' == 62) && ('?' == 63) && ('A' == 65) \
      && ('B' == 66) && ('C' == 67) && ('D' == 68) && ('E' == 69) \
      && ('F' == 70) && ('G' == 71) && ('H' == 72) && ('I' == 73) \
      && ('J' == 74) && ('K' == 75) && ('L' == 76) && ('M' == 77) \
      && ('N' == 78) && ('O' == 79) && ('P' == 80) && ('Q' == 81) \
      && ('R' == 82) && ('S' == 83) && ('T' == 84) && ('U' == 85) \
      && ('V' == 86) && ('W' == 87) && ('X' == 88) && ('Y' == 89) \
      && ('Z' == 90) && ('[' == 91) && ('\\' == 92) && (']' == 93) \
      && ('^' == 94) && ('_' == 95) && ('a' == 97) && ('b' == 98) \
      && ('c' == 99) && ('d' == 100) && ('e' == 101) && ('f' == 102) \
      && ('g' == 103) && ('h' == 104) && ('i' == 105) && ('j' == 106) \
      && ('k' == 107) && ('l' == 108) && ('m' == 109) && ('n' == 110) \
      && ('o' == 111) && ('p' == 112) && ('q' == 113) && ('r' == 114) \
      && ('s' == 115) && ('t' == 116) && ('u' == 117) && ('v' == 118) \
      && ('w' == 119) && ('x' == 120) && ('y' == 121) && ('z' == 122) \
      && ('{' == 123) && ('|' == 124) && ('}' == 125) && ('~' == 126))
/* The character set is not based on ISO-646.  */
#error "gperf generated tables don't work with this execution character set. Please report a bug to <bug-gperf@gnu.org>."
#endif

#line 1 "reserved_words.txt"

	typedef struct Word
	{
		char *word;
		char *symbol;
	} WORD;
#line 10 "reserved_words.txt"
WORD;

#define TOTAL_KEYWORDS 31
#define MIN_WORD_LENGTH 1
#define MAX_WORD_LENGTH 9
#define MIN_HASH_VALUE 1
#define MAX_HASH_VALUE 42
/* maximum key range = 42, duplicates = 0 */

#ifdef __GNUC__
__inline
#else
#ifdef __cplusplus
inline
#endif
#endif
static unsigned int
hash (register const char *str, register size_t len)
{
  static const unsigned char asso_values[] =
    {
      43, 43, 43, 43, 43, 43, 43, 43, 43, 43,
      43, 43, 43, 43, 43, 43, 43, 43, 43, 43,
      43, 43, 43, 43, 43, 43, 43, 43, 43, 43,
      43, 43, 43, 43, 43, 43, 43, 43, 43, 43,
      12, 24,  4,  1, 28, 30, 43, 25, 43, 43,
      43, 43, 43, 43, 43, 43, 43, 43, 20, 15,
      10,  0,  5, 43, 43, 43, 43, 43, 43, 43,
      43, 43, 43, 43, 43, 43, 43, 43, 43, 43,
      43, 43, 43, 43, 43, 43, 43, 43, 43, 43,
      43, 43, 43, 43, 43, 43, 43,  5,  0,  0,
      10,  0, 15, 15, 10, 25, 43, 43,  0, 43,
       0, 15, 10, 43,  5,  0,  0, 43,  0,  0,
      43, 43, 43, 43, 43, 43, 43, 43, 43, 43,
      43, 43, 43, 43, 43, 43, 43, 43, 43, 43,
      43, 43, 43, 43, 43, 43, 43, 43, 43, 43,
      43, 43, 43, 43, 43, 43, 43, 43, 43, 43,
      43, 43, 43, 43, 43, 43, 43, 43, 43, 43,
      43, 43, 43, 43, 43, 43, 43, 43, 43, 43,
      43, 43, 43, 43, 43, 43, 43, 43, 43, 43,
      43, 43, 43, 43, 43, 43, 43, 43, 43, 43,
      43, 43, 43, 43, 43, 43, 43, 43, 43, 43,
      43, 43, 43, 43, 43, 43, 43, 43, 43, 43,
      43, 43, 43, 43, 43, 43, 43, 43, 43, 43,
      43, 43, 43, 43, 43, 43, 43, 43, 43, 43,
      43, 43, 43, 43, 43, 43, 43, 43, 43, 43,
      43, 43, 43, 43, 43, 43
    };
  register unsigned int hval = len;

  switch (hval)
    {
      default:
        hval += asso_values[(unsigned char)str[3]];
      /*FALLTHROUGH*/
      case 3:
      case 2:
        hval += asso_values[(unsigned char)str[1]];
      /*FALLTHROUGH*/
      case 1:
        hval += asso_values[(unsigned char)str[0]];
        break;
    }
  return hval;
}

const WORD *
in_word_set (register const char *str, register size_t len)
{
  static const WORD wordlist[] =
    {
      {""},
#line 17 "reserved_words.txt"
      {"=", "EQUAL_SYMBOL"},
#line 39 "reserved_words.txt"
      {"+", "PLUS_SYMBOL"},
#line 15 "reserved_words.txt"
      {"end", "END_RESERVED"},
#line 26 "reserved_words.txt"
      {"else", "ELSE_RESERVED"},
#line 41 "reserved_words.txt"
      {"*", "MULTIPLICATION_SYMBOL"},
#line 37 "reserved_words.txt"
      {">", "MAJOR_SYMBOL"},
#line 35 "reserved_words.txt"
      {">=", "MAJOR_EQUAL_SYMBOL"},
#line 18 "reserved_words.txt"
      {"var", "VAR_RESERVED"},
#line 20 "reserved_words.txt"
      {"real", "REAL_RESERVED"},
#line 28 "reserved_words.txt"
      {"write", "WRITE_RESERVED"},
#line 38 "reserved_words.txt"
      {"<", "MINOR_SYMBOL"},
#line 36 "reserved_words.txt"
      {"<=", "MINOR_EQUAL_SYMBOL"},
#line 24 "reserved_words.txt"
      {"(", "LEFT_PARENTHESIS"},
#line 32 "reserved_words.txt"
      {"then", "THEN_RESERVED"},
#line 29 "reserved_words.txt"
      {"while", "WHILE_RESERVED"},
#line 13 "reserved_words.txt"
      {";", "SEMICOLON_SYMBOL"},
#line 34 "reserved_words.txt"
      {"<>", "DIF_SYMBOL"},
      {""},
#line 27 "reserved_words.txt"
      {"read", "READ_RESERVED"},
#line 16 "reserved_words.txt"
      {"const", "CONST_RESERVED"},
#line 19 "reserved_words.txt"
      {":", "COLON_SYMBOL"},
#line 33 "reserved_words.txt"
      {":=", "ASSIGN_SYMBOL"},
      {""},
#line 23 "reserved_words.txt"
      {"procedure", "PROCEDURE_RESERVED"},
#line 25 "reserved_words.txt"
      {")", "RIGHT_PARENTHESIS"},
#line 42 "reserved_words.txt"
      {"/", "DIVISION_SYMBOL"},
#line 30 "reserved_words.txt"
      {"do", "DO_RESERVED"},
      {""},
#line 22 "reserved_words.txt"
      {",", "COMMA_SYMBOL"},
#line 14 "reserved_words.txt"
      {"begin", "BEGIN_RESERVED"},
#line 40 "reserved_words.txt"
      {"-", "MINUS_SYMBOL"},
#line 21 "reserved_words.txt"
      {"integer", "INTEGER_RESERVED"},
      {""}, {""}, {""}, {""},
#line 12 "reserved_words.txt"
      {"program", "PROGRAM_RESERVED"},
      {""}, {""}, {""}, {""},
#line 31 "reserved_words.txt"
      {"if", "IF_RESERVED"}
    };

  if (len <= MAX_WORD_LENGTH && len >= MIN_WORD_LENGTH)
    {
      register unsigned int key = hash (str, len);

      if (key <= MAX_HASH_VALUE)
        {
          register const char *s = wordlist[key].name;

          if (*str == *s && !strcmp (str + 1, s + 1))
            return &wordlist[key];
        }
    }
  return 0;
}