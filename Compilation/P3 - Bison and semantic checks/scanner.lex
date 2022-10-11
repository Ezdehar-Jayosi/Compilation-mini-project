%{

/* Declarations section */
#include "tokens.hpp"
#include "output.hpp"
#include "parser.tab.hpp"


%}

%option yylineno
%option noyywrap

digit   		  ([0-9])
letter  		  ([a-zA-Z])
whitespace		([\r\t\n ])

%%
"void"                                      return VOID;
"int"                                       {
                                               yylval = new Type("INT");
	                                           return INT;
											}
"byte"                                      {
	                                           yylval = new Type("BYTE");
	                                           return BYTE;
                                            }
"b"                                         return B;
"bool"                                      {
	                                           yylval = new Type("BOOL");
                                               return BOOL;
											}
"and"                                       return AND;
"or"                                        return OR;
"not"                                       return NOT;
"true"                                      return TRUE;
"false"                                     return FALSE;
"return"                                    return RETURN;
"if"                                        return IF;
"else"                                      return ELSE;
"while"                                     return WHILE;
"break"                                     return BREAK;
"continue"                                  return CONTINUE;
"switch"                                    return SWITCH;
"case"                                      return CASE;
"default"                                   return DEFAULT;
";"                                         return SC;
":"                                         return COLON;
","                                         return COMMA;
"("                                         return LPAREN;
")"                                         return RPAREN;
"{"                                         return LBRACE;
"}"                                         return RBRACE;
"["                                         return LBRACKET;
"]"                                         return RBRACKET;
"="                                         return ASSIGN;
"<"|">"|"<="|">="                           return RELOPL;
"=="|"!="                                   return RELOPR;
\+|\-                                       return ADDSUB;
\*|\/							            return MULDIV;
\.\.                                        return DOTS;
{letter}({letter}|{digit})*                 {
	                                           yylval =  new Identifier(yytext);
	                                           return ID;
                                            }
0|[1-9]{digit}*|[1-9]{digit}                {
                                               yylval = new Num(yytext);
                                               return NUM;
                                            }

\"([^\n\r\"\\]|\\[rnt"\\])+\"               return STRING;
{whitespace}                                /* ignore */;
"//"[^\r\n]*[\r\n|\n|\r]?                  /* ignore */;



.                                           {
	                                            output::errorLex(yylineno); exit(0);
											}

%%
