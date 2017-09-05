grammar Cmake;

compilationUnit : block*;

block
    : addSubdirectory
    | set
    | invoke
    ;
addSubdirectory : AddSubdirectory OpenParen directory=expression? expression* CloseParen;
set : Set OpenParen variable=expression? value=expression? expression* CloseParen;
invoke : functionName '(' expression* ')' ;
functionName : Identifier;
reference : Dollar OpenCurly variable=expression CloseCurly ;
quotedLiteral : DoubleQuote quotedElement* DoubleQuote ;
unquotedLiteral
    : ~('$')+
    | reference
    ;
quotedElement
    :  ~('"' | '$')
    | reference
    ;
expression
    : Identifier
    | reference
    | quotedLiteral
    | unquotedLiteral
    | Number
    | AddSubdirectory
    | Set
    ;

Set : 'set';
AddSubdirectory : 'add_subdirectory';
Identifier : ('A'..'Z' | 'a'..'z' | '_') ('A'..'Z' | 'a'..'z' | '0'..'9' | '_')*;
OpenParen : '(';
CloseParen : ')';
Dollar : '$';
OpenCurly : '{';
CloseCurly : '}';
DoubleQuote : '"';
//At : '@';
//Slash : '/';
//Dot : '.';
//Minus : '-';
//OpenBracket : '[';
//CloseBracket : ']';
//Caret : '^';
//Colon : ':';
//Star : '*';
//Backslash : '\\';
//Pipe : '|';
//Equals : '=';
//Question : '?';
//LessThan : '<';
//GreaterThan : '>';
//Tick : '\'';
//Plus : '+';
//Comma : ',';
//Semicolon : ';';
//Bang : '!';
Number
    :  ('+' | '-')? ('0' .. '9')+ ('.' ('0' .. '9')*)?
    |  ('+' | '-')? ('0' .. '9')* ('.' ('0' .. '9')*);
LineEnd : '\r'? ('\n'|'\r'|EOF) -> skip;
Whitespace : [ \t]+ -> skip;
LineComment : '#' ~[\n\r]* LineEnd -> skip;
