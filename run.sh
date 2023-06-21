reset
if flex tradutor.l; then
    if gcc lex.yy.c -o lexical_analysis; then
        ./lexical_analysis < input.txt
    fi
fi
rm lex.yy.c lexical_analysis