/*
Alberto Ventafridda 866135

laboratorio 2
https://elearning.unimib.it/pluginfile.php/1129108/mod_resource/content/6/Laboratorio2.pdf

testato con
- jflex-1.8.2
- byaccj-1.15
- jdk-17.0.1
*/

%%

%byaccj

%{
  /* store a reference to the parser object */
  private Parser yyparser;

  /* constructor taking an additional parser object */
  public Yylex(java.io.Reader r, Parser yyparser) {
    this(r);
    this.yyparser = yyparser;
  }
%}

%%

"("                   { yyparser.yylval = new ParserVal(""+yycharat(0));
                        return Parser.OPEN_PAREN; }
")"                   { yyparser.yylval = new ParserVal(""+yycharat(0));
                        return Parser.CLOSE_PAREN; }
"["                   { yyparser.yylval = new ParserVal(""+yycharat(0));
                        return Parser.OPEN_PAREN_SQUARE; }
"]"                   { yyparser.yylval = new ParserVal(""+yycharat(0));
                        return Parser.CLOSE_PAREN_SQUARE; }
[a-z]+            { yyparser.yylval = new ParserVal(yytext());
                        return Parser.SKIP_BODY; }

[A-Z]{2}            { yyparser.yylval = new ParserVal(yytext());
                        return Parser.SKIP_HEAD_UPPERCASE; }

:{2}+           { yyparser.yylval = new ParserVal(yytext());
                        return Parser.SKIP_HEAD_COLUMN_EVEN; }

:+           { yyparser.yylval = new ParserVal(yytext());
                        return Parser.SKIP_HEAD_COLUMN_ODD; }

[^] {} /*butta il resto*/
