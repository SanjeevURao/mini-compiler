%{
  #include <stdio.h>
  #include<stdlib.h>
  int yyerror();
%}
%token DIGIT PRINT ID IF

%left '+' '-'
%left '*'

%%

start:	ID '(' ')' '{' stmt '}' {
									printf("Compiled successfully\n");
									exit(0);
								}
		|stmt	{
					printf("Compiled successfully\n");
					exit(0);
				}
	;


stmt:/*empty*/
		|PRINT '(' expr ')' stmt
		|PRINT '(' ID ')'
    |IF '(' COND ')' '{' stmt '}' stmt
		|assignment stmt
	;

COND: DIGIT
      | var '<' var
      | var '>' var
      | var '<''=' var
      | var '>''=' var
      | assignment ;

var : DIGIT | ID ;

expr: expr '+' expr
	| expr '-' expr
	| expr '*' expr
	| '(' expr ')'
	| DIGIT
	;

assignment:ID '=' DIGIT
	;
%%

int yyerror()
{
	printf("Syntax Error\n");
	return 0;
}

int main()
{
  yyparse();
  return 1;
}
