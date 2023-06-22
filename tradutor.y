%{
#include <stdio.h>    
#include <stdlib.h>

FILE *result;
int yyerror();
int yylex();

void ptg_write(char *text){ 
    int total_length = sizeof(text);
    char *file_content = malloc(total_length);
    sprintf(file_content,"%s", text);
    fprintf(result, "%s", file_content);
    free(file_content);
}

%}

%union {
  char *p_string;
  int   yint;
}

%token <p_string> LITERAL

%token SELECT FROM WHERE OR AND ASTERISC SEMICOLON COMMA PONTO LP RP AC FC IGUAL MAIOR MAIOR_IGUAL MENOR MENOR_IGUAL DIFERENTE 
%token MAIS MENOS DIVISAO MODULO COMMENT INSERT INTO VALUES UPDATE SET DELETE LIKE LIMIT OFFSET NOT NULLL PRIMARY KEY UNIQUE fk CHECK
%token CREATE ALTER TABLE CROSS INNER LEFT RIGHT FULL OUTER JOIN ON AS ADD DROP COLUMN MODIFY CONSTRAINT DATABASE GROUP ORDER BY SMALLINT 
%token INTEGER BIGINT SERIAL BIGSERIAL REAL DOUBLE PRECISION NUMERIC CHAR VARCHAR TEXT DATE TIME TIMESTAMP INTERVAL BOOLEAN BYTEA 
%token INET CIDR POINT LINE LSEG BOX PATH POLYGON CIRCLE RECORD 

%%

expressao: exp_select { ptg_write("exp"); } { exit(1); }
;

operadores: IGUAL 
| MENOR_IGUAL 
| MENOR 
| MAIOR_IGUAL 
| MAIOR_IGUAL
;

literais : LITERAL 
| literais COMMA LITERAL
;

exp_select: SELECT { ptg_write("SELECT"); } ASTERISC FROM LITERAL SEMICOLON
;

%%

int yyerror(){
  printf("Error \n");
  return 1;
}

int main(){
  result = fopen ("result.sql", "w");
  yyparse();
  return 1;
}