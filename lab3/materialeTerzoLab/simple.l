/*
Alberto Ventafridda 866135

laboratorio 3

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

DIGIT=[0-9]
ID=R[0-9]

%%

":=" { return(Parser.ASSGNOP); }
DUAL { return(Parser.DUAL); }
{DIGIT}+ { yyparser.yylval = new ParserVal(Integer.parseInt(yytext()));return(Parser.NUMBER); }
true { yyparser.yylval = new ParserVal(1);return(Parser.BOOL); }
false { yyparser.yylval = new ParserVal(0);return(Parser.BOOL); }
and { return(Parser.AND); }
do { return(Parser.DO); }
else { return(Parser.ELSE); }
END { return(Parser.END); }
done { return(Parser.DONE); }
fi { return(Parser.FI); }
if { return(Parser.IF); }
BEGIN { return(Parser.BEGIN); }
read { return(Parser.READ); }
skip { return(Parser.SKIP); }
then { return(Parser.THEN); }
while { return(Parser.WHILE); }
write { return(Parser.WRITE); }
{ID} { yyparser.yylval = new ParserVal(Integer.parseInt(yytext().substring(1)));return(Parser.IDENTIFIER); }
[ \r\t\n]+ { }
"//".* { }
[^] { return yytext().charAt(0); }
