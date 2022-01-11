/*
Alberto Ventafridda 866135

laboratorio 4

testato con
- jflex-1.8.2
- byaccj-1.15
- jdk-17.0.1
*/

%{
  import java.io.*;
%}
      
%start program
%token NL          /* newline  */
%token OPEN
%token CLOSE
%token COL
%token SEMICOL
%token <sval> STR

%%


program: STR COL OPEN NL
            details
         CLOSE SEMICOL opt_nl
         {System.out.print("\n[" + $1 + "]");}
| NL


details: STR COL STR NL
         {System.out.print($1 + "=" + $3 + "\n");}
| NL

opt_nl : /*empty */
| NL

%%

  private Yylex lexer;


  private int yylex () {
    int yyl_return = -1;
    try {
      yylval = new ParserVal(0);
      yyl_return = lexer.yylex();
    }
    catch (IOException e) {
      System.err.println("IO error :"+e);
    }
    return yyl_return;
  }


  public void yyerror (String error) {
    System.err.println ("Error: " + error);
  }


  public Parser(Reader r) {
    lexer = new Yylex(r, this);
  }


  static boolean interactive;

  public static void main(String args[]) throws IOException {
    System.out.println("pseudo-json to pseudo-toml converter");
    System.out.println("converter output:");

    Parser yyparser;
    if ( args.length > 0 ) {
      // parse a file
      yyparser = new Parser(new FileReader(args[0]));
    }
    else {
      // interactive mode
      System.out.println("[Quit with CTRL-D]");
      System.out.print("enter a configuration: ");
      interactive = true;
	    yyparser = new Parser(new InputStreamReader(System.in));
    }

    yyparser.yyparse();
    
    if (interactive) {
      /* System.out.println();
      System.out.println("Have a nice day"); */
    }
  }
