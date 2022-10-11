%{
#include "tokens.hpp"
#include <stdio.h>
int strLen();
void print_error();
void error_1();
void error_2();
%}

%option noyywrap
%option yylineno
whitespace [\n\t\r 	]
whitespaceA [ \t\r\n\f]
letter [a-zA-Z]
digit [0-9]
binop [(\+|\-|\*|\/)]
str [\x00-\x09\x0b-\x0c\x0e-\x21\x23-\x5b\x5d-\x7f]

%x STRING_S
%%

void return VOID;
int return INT;
byte return BYTE;
b return B;
bool return BOOL;
and return AND;
or return OR;
not return NOT;
true return TRUE;
false return FALSE;
switch return SWITCH;
case return CASE;
default return DEFAULT;
return return RETURN;
if return IF;
else return ELSE;
while return WHILE;
break return BREAK;
continue return CONTINUE;
(\;) return SC;
(\,) return COMMA;
(\() return LPAREN;
(\)) return RPAREN;
(\{) return LBRACE;
(\}) return RBRACE;
= return ASSIGN;
(((!|<|>|=)=)|<|>) return RELOP;
{binop} return BINOP;
\/\/.* return COMMENT; 
{letter}({letter}|{digit})* return ID;
([1-9]{digit}*|0) return NUM;
(\") BEGIN(STRING_S);
<STRING_S><<EOF>> print_error();
<STRING_S>({str}|((\\)(\\))|((\\)(\"))|((\\)(n))|((\\)(r))|((\\)(t))|((\\)(0))|((\\)x))*(\") {BEGIN(INITIAL);return STRING;}
<STRING_S>([^(\")])*((\")?) return WRONGSTR;
<STRING_S>. error_1();
({whitespaceA})+  return WHITESPACE;  
. error_2();
%%

int strLen(){
    int len=0;
    while(yytext[len]!=0) len++;
    return len;
}
void print_error() {
    printf("Error unclosed string\n");
    exit(1);
}
void error_1() {
    int len= strLen();
    for (size_t i = 0; i < len; i++) {
            if (yytext[i] == '\"' && i<len-1) {
                printf("Error %c\n", yytext[i]);
                exit(0);
            }
    }
    if(yytext[len-1]!='\"') { printf("Error unclosed string\n");exit(1);}
    exit(2);
}
void error_2() {
     printf("Error %s\n", yytext);
    exit(2);
}