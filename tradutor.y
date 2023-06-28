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

%token SELECT FROM WHERE OR AND ASTERISC SEMICOLON COMMA PONTO LP RP AC FC IGUAL MAIOR MAIOR_IGUAL MENOR MENOR_IGUAL DIFERENTE BETWEEN
%token MAIS MENOS DIVISAO MODULO COMMENT INSERT INTO VALUES UPDATE SET DELETE LIKE LIMIT OFFSET NOT NULLL PRIMARY KEY UNIQUE FK CHECK
%token CREATE ALTER TABLE CROSS INNER LEFT RIGHT FULL OUTER JOIN ON AS ADD DROP COLUMN MODIFY CONSTRAINT DATABASE GROUP ORDER BY SMALLINT 
%token INTEGER BIGINT SERIAL BIGSERIAL REAL DOUBLE PRECISION NUMERIC CHAR VARCHAR TEXT DATE TIME TIMESTAMP INTERVAL BOOLEAN BYTEA 
%token INET CIDR POINT LINE LSEG BOX PATH POLYGON CIRCLE RECORD 

%%

expressao: exp_select 
| exp_create
;

inicio: SELECT { ptg_write("SELECT ");}
| CREATE { ptg_write("CREATE ");} 
;

exp_select: inicio atributos from literal semicolon
| inicio atributos from literal where condicoes semicolon
;

opcoes_create: TABLE { ptg_write("TABLE ");} 
| DATABASE { ptg_write("DATABASE ");} 
;

exp_create: inicio opcoes_create literal semicolon

operadores_comparativos: IGUAL { ptg_write(" = ");}
| MENOR_IGUAL { ptg_write(" <= ");}
| MENOR { ptg_write(" < ");}
| MAIOR_IGUAL { ptg_write(" >= ");}
| MAIOR { ptg_write(" > ");}
;

operadores_logicos: AND { ptg_write(" AND ");}
| OR { ptg_write(" OR ");}
| NOT { ptg_write(" NOT ");}
;

literais : LITERAL { ptg_write($1);}
| literais COMMA LITERAL { ptg_write(", "); ptg_write($3);}
;

parenteses: LP {ptg_write("\( ") ;}
| RP {ptg_write(" \)");}
;

where: WHERE { ptg_write(" WHERE ");}

condicoes: literal operadores_comparativos literal
| condicoes operadores_logicos condicoes
| funcoes_where
;

funcoes_where: literal BETWEEN { ptg_write(" BETWEEN ");} literal AND { ptg_write(" AND ");} literal
| literal LIKE { ptg_write(" LIKE ");} literal
| literal NOT { ptg_write(" NOT");} LIKE { ptg_write(" LIKE ");} literal
;

atributos: ASTERISC { ptg_write("*");}
| literais 
;

literal: LITERAL { ptg_write($1);}
;



semicolon: SEMICOLON { ptg_write(";");}
|
;

from: FROM { ptg_write(" FROM ");} 

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