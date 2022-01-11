/*
Alberto Ventafridda 866135

laboratorio 4

testato con
- jflex-1.8.2
- byaccj-1.15
- jdk-17.0.1
*/

%%

%byaccj

%{
  private Parser yyparser;

  public Yylex(java.io.Reader r, Parser yyparser) {
    this(r);
    this.yyparser = yyparser;
  }
%}

NL  = \n | \r | \r\n
STR = [0-9a-zA-Z]+ (" " [0-9a-zA-Z]+ )*

%%

/* graphs */
"{" { return Parser.OPEN; }
"}" { return Parser.CLOSE; }

/* column */
":" { return Parser.COL; }
";" { return Parser.SEMICOL; }

/* newline */
{NL}   { return Parser.NL; }

/* string values */
{STR}  { yyparser.yylval = new ParserVal(yytext()); return Parser.STR; }

/* whitespace */
[ \t]+ { }

\b     { System.err.println("Sorry, backspace doesn't work"); }

/* error fallback */
[^]    { System.err.println("Error: unexpected character '"+yytext()+"'"); return -1; }