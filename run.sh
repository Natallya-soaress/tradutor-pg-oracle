reset
if flex scanner.l; then
    if yacc -d parser.y; then
        if gcc lex.yy.c y.tab.c -o lexical_analysis -lfl; then
            ./lexical_analysis < input.txt 
            cat result.sql
        fi
    fi
fi
rm lex.yy.c lexical_analysis y.tab.c y.tab.h 

