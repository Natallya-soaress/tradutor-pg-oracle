%{
    
#include <stdio.h>
#include "y.tab.h"

%}

%option noyywrap
%option yylineno

LITERAl [a-zA-Z_0-9".%]+

%% 

"SELECT"                { return SELECT; }
"FROM"                  { return FROM; }
"WHERE"                 { return WHERE; }
"OR"                    { return OR; }
"AND"                   { return AND; }
"*"                     { return ASTERISC; }
";"                     { return SEMICOLON; }
","                     { return COMMA; }
"."                     { return PONTO; }
"("                     { return LP; }
")"                     { return RP; }
"["                     { return AC; }
"]"                     { return FC; }
"="                     { return IGUAL; }
">"                     { return MAIOR; }
">="                    { return MAIOR_IGUAL; }
"<"                     { return MENOR; }
"<="                    { return MENOR_IGUAL; }
"!="                    { return DIFERENTE; }
"+"                     { return MAIS; }
"-"                     { return MENOS; }
"/"                     { return DIVISAO; }
"%"                     { return MODULO; }
"--"                    { return COMMENT; }
"INSERT"                { return INSERT; }
"INTO"                  { return INTO; }
"VALUES"                { return VALUES; }
"UPDATE"                { return UPDATE; }
"SET"                   { return SET; }
"DELETE"                { return DELETE; }
"LIKE"                  { return LIKE; }
"LIMIT"                 { return LIMIT; }
"OFFSET"                { return OFFSET; }
"BETWEEN"               { return BETWEEN; }
"NOT"                   { return NOT; }
"NULL"                  { return NULLL; }
"PRIMARY"               { return PRIMARY; }
"KEY"                   { return KEY; }
"UNIQUE"                { return UNIQUE; }
"FOREIGN"               { return FOREIGN; }
"REFERENCES"            { return REFERENCES; }
"CHECK"                 { return CHECK; }
"CREATE"                { return CREATE; }
"ALTER"                 { return ALTER; }
"TABLE"                 { return TABLE; }
"CROSS"                 { return CROSS; }
"INNER"                 { return INNER; }
"LEFT"                  { return LEFT; }
"RIGHT"                 { return RIGHT; }
"FULL"                  { return FULL; }
"OUTER"                 { return OUTER; }
"JOIN"                  { return JOIN; }
"ON"                    { return ON; }
"AS"                    { return AS; }
"ADD"                   { return ADD; }
"DROP"                  { return DROP; }
"COLUMN"                { return COLUMN; }
"MODIFY"                { return MODIFY; }
"CONSTRAINT"            { return CONSTRAINT; }
"DATABASE"              { return DATABASE; }
"GROUP"                 { return GROUP; }
"ORDER"                 { return ORDER; }
"BY"                    { return BY; }
"SMALLINT"              { return SMALLINT; }
"INTEGER"               { return INTEGER; }
"BIGINT"                { return BIGINT; }
"SERIAL"                { return SERIAL; }
"BIGSERIAL"             { return BIGSERIAL; }
"REAL"                  { return REAL; }
"DOUBLE"                { return DOUBLE; }
"NUMERIC"               { return NUMERIC; }
"CHAR"                  { return CHAR; }
"VARCHAR"               { return VARCHAR; }
"TEXT"                  { return TEXT; }
"DATE"                  { return DATE; }
"TIME"                  { return TIME; }
"TIMESTAMP"             { return TIMESTAMP; }
"INTERVAL"              { return INTERVAL; }
"BOOLEAN"               { return BOOLEAN; }
"BYTEA"                 { return BYTEAA; }
"SERIAL"                { return SERIALL; }
{LITERAl}               { yylval.p_string = malloc(yyleng); sprintf(yylval.p_string, "%s", yytext); return LITERAL; }
. {}

%% 