%{
#include <stdio.h>    
#include <stdlib.h>

FILE *result;
extern int yylineno;

void ptg_write(char *text){ 
    int total_length = sizeof(text);
    char *file_content = malloc(total_length);
    sprintf(file_content,"%s", text);
    fprintf(result, "%s", file_content);
    free(file_content);
}

%}

%define parse.error verbose

%union {
  char *p_string;
  int   yint;
}

%token <p_string> LITERAL

%token SELECT FROM WHERE OR AND ASTERISC SEMICOLON COMMA PONTO LP RP AC FC IGUAL MAIOR MAIOR_IGUAL MENOR MENOR_IGUAL DIFERENTE BETWEEN
%token MAIS MENOS DIVISAO MODULO COMMENT INSERT INTO VALUES UPDATE SET DELETE LIKE LIMIT OFFSET NOT NULLL PRIMARY KEY UNIQUE FK CHECK
%token CREATE ALTER TABLE CROSS INNER LEFT RIGHT FULL OUTER JOIN ON AS ADD DROP COLUMN MODIFY FOREIGN CONSTRAINT DATABASE GROUP ORDER BY SMALLINT 
%token INTEGER BIGINT SERIALL BIGSERIAL REAL DOUBLE PRECISION NUMERIC CHAR VARCHAR TEXT DATE TIME TIMESTAMP INTERVAL BOOLEAN BYTEA 
%token BYTEAA REFERENCES SERIAL

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

exp_create: exp_create_table
| exp_create_database
;

exp_create_table: inicio TABLE { ptg_write("TABLE ");} literal colunas_create semicolon

exp_create_database: inicio DATABASE { ptg_write("DATABASE ");} literal semicolon

tipo_dados: CHAR { ptg_write(" CHAR");} lp literal rp
| VARCHAR { ptg_write(" VARCHAR2");} lp literal rp
| TEXT { ptg_write(" CLOB");}
| SMALLINT { ptg_write(" NUMBER(5)");}
| INTEGER { ptg_write(" NUMBER(10)");}
| BIGINT { ptg_write(" NUMBER(19)");}
| SERIAL { ptg_write(" NUMBER(10)");}
| BIGSERIAL { ptg_write(" NUMBER(19)");}
| REAL { ptg_write(" FLOAT");}
| DOUBLE { ptg_write(" FLOAT");}
| NUMERIC { ptg_write(" NUMBER");}
| DATE { ptg_write(" DATE");}
| TIME { ptg_write(" DATE");}
| TIMESTAMP
| INTERVAL { ptg_write(" INTERVAL");}
| BOOLEAN
| BYTEAA { ptg_write(" BLOB");}
;

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

restricoes: NOT { ptg_write(" NOT");} NULLL { ptg_write(" NULL");} 
| NULLL { ptg_write(" NULL ");} 
| primary_key
| foreigh_key 
| unique
| check
| restricoes comma restricoes
|
;

check: CHECK { ptg_write(" CHECK ");} lp condicoes rp
| constraint literal CHECK { ptg_write(" CHECK ");} lp condicoes rp
;

foreigh_key: constraint literal FOREIGN KEY { ptg_write(" FOREIGN KEY ");} lp literal rp REFERENCES {ptg_write(" REFERENCES ") ;} literal lp literal rp
;

primary_key: PRIMARY KEY LP LITERAL RP { ptg_write("CONSTRAINT unq_");} { ptg_write($4);} { ptg_write(" PRIMARY KEY (");} { ptg_write($4);} { ptg_write(")");}
| PRIMARY KEY { ptg_write(" PRIMARY KEY");}
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

colunas: literal tipo_dados restricoes
| literal tipo_dados restricoes comma colunas
| PRIMARY KEY { ptg_write("PRIMARY KEY ");} lp literais rp comma colunas
| check comma colunas
;

colunas_create: lp colunas rp
;

atributos: ASTERISC { ptg_write("*");}
| literais 
;

unique: UNIQUE { ptg_write(" UNIQUE");} 
| UNIQUE LP LITERAL RP { ptg_write("CONSTRAINT unq_");} { ptg_write($3);} { ptg_write(" UNIQUE (");} { ptg_write($3);} { ptg_write(")");}
;

literal: LITERAL { ptg_write($1);}
;

semicolon: SEMICOLON { ptg_write(";");}
|
;

comma: COMMA { ptg_write(", ");}
;

from: FROM { ptg_write(" FROM ");} 

constraint: CONSTRAINT { ptg_write(" CONSTRAINT ");} 
;

rp: RP {ptg_write(")") ;}

lp: LP {ptg_write("(") ;}


%%

yyerror (char *s){
    printf("\033[0;31m%s na linha \033[0;37m%d\033[0;37m\n", s, yylineno);
}

int main(){
  result = fopen ("result.sql", "w");
  yyparse();
  return 1;
}