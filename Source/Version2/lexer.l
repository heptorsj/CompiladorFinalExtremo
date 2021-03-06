/* Escaner Para Proyecto Final

                              __
                            .d$$b
                          .' TO$;\
                         /  : TP._;
                        / _.;  :Tb|
                       /   /   ;j$j
                   _.-"       d$$$$
                 .' ..       d$$$$;
                /  /P'      d$$$$P. |\
               /   "      .d$$$P' |\^"l
             .'           `T$P^"""""  :
         ._.'      _.'                ;
      `-.-".-'-' ._.       _.-"    .-"
    `.-" _____  ._              .-"
   -(.g$$$$$$$b.              .'
     ""^^T$$$P^)            .(:
       _/  -"  /.'         /:/;
    ._.'-'`-'  ")/         /;/;
 `-.-"..--""   " /         /  ;
.-" ..--""        -'          :
..--""--.-"         (\      .-(\
  ..--""              `-\(\/;`
    _.                      :
                            ;`-
                           :\
                           ;
EQUIPO :
1.- Santiago Lopez Ricardo
2.- Jacales Rojas Héctor Daniel
3.- Moreloz Alquezada Mario David
4.- Pina Lopez Christian
*/
%{
 #include <stdio.h>
 #include <string.h>
 #include "gramatica.tab.h"
%}
%option yylineno
%option noyywrap

%s COMM
%s COMMII
digito [0-9]
id_valido  [a-zA-Z_\-]
%%
<INITIAL>{

	"/*" {
		BEGIN COMM;
	}

	"*/" {
		printf("\nerrorLexico::linea:%d -> %s [NO SE INDICA EL INICIO DEL COMENTARIO]\n\n",yylineno,yytext);
	}

	"//" {
		BEGIN COMMII;
	}
"int" {
    yylval.line = yylineno;
    return INT;}
"float" {
    yylval.line = yylineno;
    return FLOAT;}
"double" {return DOUBLE;}
"char" {return CHAR;}
"void" {return VOID;}
"struct" {return STRUCT;}
"func" {return FUNC;}
"if"   {return IF;}
"else" {return ELSE;}
"do" {return DO;}
"while" {return WHILE;}
"for" {return FOR;}
"swich" {return SWICH;}
"case" {return CASE;}
"break" {return BREAK;}
"default" {return DEFAULT;}
"return" {return RETURN;}
"(" {
    yylval.line = yylineno;
    return LPAR;}
")" {
    yylval.line = yylineno;
    return RPAR;}
"{" {return LKEY;}
"}" {return RKEY;}
"[" {return LCOR;}
"]" {return RCOR;}
"," {return COMA;}
";" {return PYC;}
"true" {return TRUE;}
"false" {return FALSE;}
"!" {return NEG;}
"&&" {return AND;}
"||" {return OR;}
"+" {return MAS;}
"-" {return MENOS;}
"/" {return DIV;}
"*" {return MUL;}
"=" {return ASIG;}
"==" {
			strcpy(yylval.relacionalop.operador, yytext);
      return IGUAL;}
"!=" {
      strcpy(yylval.relacionalop.operador, yytext);
      return DISTINTO;}
"<=" {
      strcpy(yylval.relacionalop.operador, yytext);
      return GE;}
">=" {
      strcpy(yylval.relacionalop.operador, yytext);
      return LE;}
"<" {
      strcpy(yylval.relacionalop.operador, yytext);
      return LT;}
">" {
      strcpy(yylval.relacionalop.operador, yytext);
      return GT;}
[\%] {return MOD;}
{id_valido}+{id_valido}* {
			yylval.id = (char*)malloc(strlen(yytext)*sizeof(char));
			strcpy(yylval.id, yytext);
  return ID;}
{digito}+ {
       yylval.numero.type = 0;
       yylval.numero.numero = (char*)malloc(strlen(yytext)*sizeof(char));
       strcpy(yylval.numero.numero,yytext);
      return NUMERO;}
{digito}+.{digito}+"f" {
      yylval.numero.type = 1;
      yylval.numero.numero = (char*)malloc(strlen(yytext)*sizeof(char));
      strcpy(yylval.numero.numero,yytext);
      return NUMERO;}
"'"{id_valido}"'" {return CARACTER;}
[\""]{id_valido}*[\""] {return CADENA;}
[ \n\t] {}
<<EOF>> 	 { yyterminate(); }

	. {
		printf("Error Lexico: %d -> %s token invalido.\n\n",yylineno,yytext);
	}
}

<COMM>{

	"*/" {
		// printf("FIN COMENTARIO");
		BEGIN INITIAL;
	}

	[^"*""/"] {
		// Cualquier cosa que no sea * ó /
		// ejemplo: hola como estas 341241 11 1
	}

	"*" {}

	"/" {}
}

<COMMII>{
	[^\n] {}

	"\n" {
		BEGIN INITIAL;
	}
}

%% /* Codigo C*/
