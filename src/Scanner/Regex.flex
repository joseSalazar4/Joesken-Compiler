package Scanner;

import java.util.*;
import Scanner.DataStructure.*;
import Scanner.Constants.*;

%%
%public
%class Scanner
%standalone
%line
%column


/*
 Code Blocks
*/

%{
private Structure data = new Structure();
private Structure errors = new Structure();

Structure getData() {
    return this.data;
}

Structure getErrors() {
    return this.errors;
}

%}

// End of file
%eof{
    System.out.println(data.toString());
    System.out.println(errors.toString());
%eof}

/*
    MACROS
*/


Digit = \d
Octal = 0{number}
Letter = [a-zA-Z]
Space = \s|\t
New_Line = \n

Identifier = {Letter}({Letter}|{Digit})*

// Literals
Character = \'.\'
String = \".*\"


// Errors
Identifier_Error = {Digit}+{Identifier}

// Comments
Single_Line_Comment = \/\/.*\n
Multi_Line_Comment = \/\*([^])*\*\/
Comments = {Single_Line_Comment}|{Multi_Line_Comment}

// Elements to ignore
Ignored_Elements = {Comments} | {Space} | {New_Line}

// Errors
Errors = {Identifier_Error}
%%

// Reserved words

    "union"|
    "const"|
    "switch"|
    "extern"|
    "return"|
    "sizeof"|
    "struct"|
    "typedef"|
    "_Packed"|
    "default"|
    "register" { data.addData(yytext(), Types.RESERVED_WORDS, yyline); }

    "enum" { data.addData(yytext(), Types.RESERVED_ENUM, yyline); }

    // Conditional and jumps
    "if"|
    "auto"|
    "else"|
    "case"|
    "goto" { data.addData(yytext(), Types.RESERVED_CONDITION, yyline); }

    // Loops
    "do"|
    "while"|
    "for"|
    "continue"|
    "break" { data.addData(yytext(), Types.RESERVED_LOOP, yyline); }

    // Data types
    "int"|
    "void"|
    "long"|
    "char"|
    "float"|
    "short"|
    "double" { data.addData(yytext(), Types.RESERVED_DATA_TYPE, yyline); }

    // Data type modifiers
    "static"|
    "volatile"|
    "signed"|
    "unsigned" { data.addData(yytext(), Types.RESERVED_MODIFIER, yyline); }

// OPERATORS

    // Separators
    "," { data.addData(yytext(), Types.OPERATOR_SEPARATE, yyline); }
    ";" { data.addData(yytext(), Types.OPERATOR_END_LINE, yyline); }

    // Math
    "+" { data.addData(yytext(), Types.OPERATOR_ADD, yyline); }
    "-" { data.addData(yytext(), Types.OPERATOR_SUBTRACT, yyline); }
    "*" { data.addData(yytext(), Types.OPERATOR_MULTIPLY, yyline); }
    "/" { data.addData(yytext(), Types.OPERATOR_DIVIDE, yyline); }
    "%" { data.addData(yytext(), Types.OPERATOR_REMAINDER, yyline); }
    "++" { data.addData(yytext(), Types.OPERATOR_INC, yyline); }
    "--" { data.addData(yytext(), Types.OPERATOR_DEC, yyline); }

    // Comparatives
    "=="|
    ">="|
    ">"|
    "<="|
    "<"|
    "!="|
    "||"|
    "&&"|
    "!"|
    "?"|
    ":" { data.addData(yytext(), Types.OPERATOR_BOOLEAN, yyline); }

    // Assignment
    "="|
    "+="|
    "-="|
    "*="|
    "/="|
    "<<="|
    ">>="|
    "&="|
    "^="|
    "|=" { data.addData(yytext(), Types.OPERATOR_ASSIGNMENT, yyline); }

    // Code Blocks
    "("|
    ")" { data.addData(yytext(), Types.OPERATOR_PARENTHESIS, yyline); }

    "["|
    "]" {data.addData(yytext(), Types.OPERATOR_SQ_BRACKET, yyline); }

    "{"|
    "}" {data.addData(yytext(), Types.OPERATOR_BRACKET, yyline); }

    // Binary Operators
    "&"|
    "|"|
    "^"|
    "~"|
    "<<"|
    ">>" {data.addData(yytext(), Types.OPERATOR_BINARY, yyline); }

    // Memory Operators
    "->" {data.addData(yytext(), Types.OPERATOR_MEMORY, yyline); }

// Identifiers
    {Identifier} {data.addData(yytext(), Types.IDENTIFIER, yyline);}

// Literals
    {String} {data.addData(yytext(), Types.LITERAL_STRING, yyline);}
    {Character} {data.addData(yytext(), Types.LITERAL_CHARACTER, yyline);}

// Elements to ignore
    {Ignored_Elements} {/* DO NOTHING */}

// Error
    {Errors} |. { data.addData(yytext(), Types.ERROR, yyline); }