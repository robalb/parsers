%{
  import java.io.*;
%}

%token OPEN_PAREN;
%token CLOSE_PAREN;
%token OPEN_PAREN_SQUARE;
%token CLOSE_PAREN_SQUARE;
%token <sval> SKIP;

%start s

%%

parens  : OPEN_PAREN s CLOSE_PAREN
        | OPEN_PAREN CLOSE_PAREN

parens_square : OPEN_PAREN_SQUARE s CLOSE_PAREN_SQUARE
	      | OPEN_PAREN_SQUARE CLOSE_PAREN_SQUARE

exp     : parens
	| parens_square

exps    : exp SKIP { System.out.println("S: "+$2); }
        | exp

s       : SKIP { System.out.println("txt: "+$1); }
        | exps
        | s exps

%%

void yyerror(String s)
{
 System.out.println("err:"+s);
 System.out.println("   :"+yylval.sval);
}

static Yylex lexer;
int yylex()
{
 try {
  return lexer.yylex();
 }
 catch (IOException e) {
  System.err.println("IO error :"+e);
  return -1;
 }
}

public static void main(String args[])
{
 System.out.println("[Quit with CTRL-D]");
 Parser par = new Parser();
 lexer = new Yylex(new InputStreamReader(System.in), par);
 par.yyparse();
}
