%{
    void yyerror (char *s);
    int yylex();

    #include <iostream>
    #include <stdio.h>     /* C declarations used in actions */
    #include <stdlib.h>
    #include <math.h>
    #include <string.h>
    #include <utility>
    #include <ctype.h>
    #include <sstream>
    #include <unordered_map>

    /* Container to store parse values and results. */
    std::unordered_map<std::string, float> symbol_table;

    extern FILE* yyin;
    float symbolVal(const char* symbol);
    void updateSymbolVal(const char* symbol, float val);
    extern int yyparse();
%}

/* Yacc definitions */

%union {float num; const char* id;}         

%start program

%token print
%token exit_command
%token <num> number
%token <id> identifier
%token _Sin
%token _Cos
%token _Tan
%token _Log
%token _Pow

//%type stmt_list program assignment
%type <num> exp term

%left '+' '-'
%left '*' '/'
%%

/* descriptions of expected inputs  &   corresponding actions */

program : stmt_list
        ;

stmt_list : stmt_list assignment ';' 
          | stmt_list print exp ';'    {printf("%f\n", $3);}
          | stmt_list exit_command ';' {printf("Exitting...\n"); exit(0);}
          | /* Empty */
          ;

assignment : identifier '=' exp  { updateSymbolVal($1, $3); }
           ;

exp : term        { $$ = $1;}
    | '-' exp     { $$ = -$2;}
    | exp '+' exp { $$ = $1 + $3;}
    | exp '-' exp { $$ = $1 - $3;}
    | exp '*' exp { $$ = $1 * $3;}
    | exp '/' exp { $$ = $1 / $3;}
    | _Sin '(' exp ')'  { $$ = sin($3);}
    | _Cos '(' exp ')'  { $$ = cos($3);}
    | _Tan '(' exp ')'  { $$ = tan($3);}
    | _Log '(' exp ')'  { $$ = log($3);}
    | _Pow '(' exp ',' exp ')'  { $$ = pow($3, $5);}
    | '(' exp ')' { $$ = $2; }
    ;

term : number     { $$ = $1; }
     | identifier { $$ = symbolVal($1); } 
     ;

%%     

/* returns the value of a given symbol from symbol table */
float symbolVal(const char* symbol)
{
std::string find(symbol);
    return symbol_table[find];
}

/* updates the value of a given symbol in symbol table */
void updateSymbolVal(const char* symbol, float val)
{
    std::string input(symbol);
    symbol_table[input] = val;
}

int main (int argc, char *argv[]) {
    if(argc > 1){
	yyin = fopen(argv[1], "r");
    }
    return yyparse();
}

void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 

