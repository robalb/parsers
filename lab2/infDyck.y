/*
Alberto Ventafridda 866135

laboratorio 2
https://elearning.unimib.it/pluginfile.php/1129108/mod_resource/content/6/Laboratorio2.pdf

testato con
- jflex-1.8.2
- byaccj-1.15
- jdk-17.0.1
*/

%{
  import java.io.*;
%}

%token OPEN_PAREN;
%token CLOSE_PAREN;
%token OPEN_PAREN_SQUARE;
%token CLOSE_PAREN_SQUARE;
%token <sval> SKIP_BODY;
%token <sval> SKIP_HEAD_UPPERCASE;
%token SKIP_HEAD_COLUMN_EVEN;
%token SKIP_HEAD_COLUMN_ODD;

%start s

%%

parens  : OPEN_PAREN s CLOSE_PAREN
        | OPEN_PAREN CLOSE_PAREN

parens_square : OPEN_PAREN_SQUARE s CLOSE_PAREN_SQUARE
	      | OPEN_PAREN_SQUARE CLOSE_PAREN_SQUARE

exp     : parens
	| parens_square

exps    : exp { System.out.print("S: "); } skip
        | exp

s       : { System.out.print("txt: "); } skip
        | exps
        | s exps

skip    : skip_head SKIP_BODY { System.out.println($2); }

skip_head    : /* EMPTY */
             | SKIP_HEAD_COLUMN_EVEN
             | SKIP_HEAD_COLUMN_ODD { System.out.print(":"); }
             | SKIP_HEAD_UPPERCASE { mustBeEqual(); }
%%

void mustBeEqual()
{
 String t = yylval.sval;
 if(t.charAt(0) != t.charAt(1))
  System.out.print("Err: ");
}

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
