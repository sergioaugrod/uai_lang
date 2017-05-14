class UaiLang::Parser::Generator

# Tokens
token IF
token DEF
token CLASS
token NEWLINE
token NUMBER
token STRING
token TRUE FALSE NIL
token IDENTIFIER
token CONSTANT
token BLOCK_INIT BLOCK_END

# Operator Precedence Table based: http://en.cppreference.com/w/cpp/language/operator_precedence
prechigh
  left '.'
  right '!'
  left '*' '/'
  left '+' '-'
  left '>' '>=' '<' '<='
  left '==' '!='
  left '&&'
  left '||'
  right '='
  left ','
preclow

# Rules
rule
  Program:
          /* nothing */                       { result = Parser::Nodes.new([]) }
        | Expressions                       { result = val[0] }
        ;

  Expressions:
          Expression                        { result = Parser::Nodes.new(val) }
        | Expressions Terminator Expression { result = val[0] << val[2] }
        | Expressions Terminator            { result = val[0] }
        | Terminator                        { result = Parser::Nodes.new([]) }
        ;

  Expression:
          Literal
        | Call
        | Operator
        | GetConstant
        | SetConstant
        | GetLocal
        | SetLocal
        | Def
        | Class
        | If
        | '(' Expression ')'                { result = val[1] }
        ;

  Terminator:
          NEWLINE
        | ';'
        ;

  Literal:
          NUMBER                            { result = Parser::Node.new(:number, { value: val[0] }) }
        | STRING                            { result = Parser::Node.new(:string, { value: val[0] }) }
        | TRUE                              { result = Parser::Node.new(:true, { value: true }) }
        | FALSE                             { result = Parser::Node.new(:false, { value: false }) }
        | NIL                               { result = Parser::Node.new(:nil, { value: nil }) }
        ;

  Call:
          IDENTIFIER Arguments              { result = Parser::Node.new(:call_node, { receiver: nil, method: val[0], arguments: val[1] }) }
        | Expression '.' IDENTIFIER
            Arguments                       { result = Parser::Node.new(:call_node, { receiver: val[0], method: val[2], arguments: val[3] }) }
        | Expression '.' IDENTIFIER         { result = Parser::Node.new(:call_node, { receiver: val[0], method: val[2], arguments: val[] }) }
        ;

  Arguments:
          '(' ')'                           { result = [] }
        | '(' ArgList ')'                   { result = val[1] }
        ;

  ArgList:
          Expression                        { result = val }
        | ArgList ',' Expression            { result = val[0] << val[2] }
        ;

  Operator:
          Expression '||' Expression        { result = Parser::Node.new(:call_node, { receiver: val[0], method: val[1], arguments: val[2] }) }
        | Expression '&&' Expression        { result = Parser::Node.new(:call_node, { receiver: val[0], method: val[1], arguments: val[2] }) }
        | Expression '==' Expression        { result = Parser::Node.new(:call_node, { receiver: val[0], method: val[1], arguments: val[2] }) }
        | Expression '!=' Expression        { result = Parser::Node.new(:call_node, { receiver: val[0], method: val[1], arguments: val[2] }) }
        | Expression '>' Expression         { result = Parser::Node.new(:call_node, { receiver: val[0], method: val[1], arguments: val[2] }) }
        | Expression '>=' Expression        { result = Parser::Node.new(:call_node, { receiver: val[0], method: val[1], arguments: val[2] }) }
        | Expression '<' Expression         { result = Parser::Node.new(:call_node, { receiver: val[0], method: val[1], arguments: val[2] }) }
        | Expression '<=' Expression        { result = Parser::Node.new(:call_node, { receiver: val[0], method: val[1], arguments: val[2] }) }
        | Expression '+' Expression         { result = Parser::Node.new(:call_node, { receiver: val[0], method: val[1], arguments: val[2] }) }
        | Expression '-' Expression         { result = Parser::Node.new(:call_node, { receiver: val[0], method: val[1], arguments: val[2] }) }
        | Expression '*' Expression         { result = Parser::Node.new(:call_node, { receiver: val[0], method: val[1], arguments: val[2] }) }
        | Expression '/' Expression         { result = Parser::Node.new(:call_node, { receiver: val[0], method: val[1], arguments: val[2] }) }
        ;

  GetConstant:
          CONSTANT                          { result = Parser::Node.new(:get_constant, { name: val[0] }) }
        ;

  SetConstant:
          CONSTANT '=' Expression           { result = Parser::Node.new(:set_constant, { name: val[0], value: val[2] }) }
        ;

  GetLocal:
          IDENTIFIER                        { result = Parser::Node.new(:get_local, { name: val[0] }) }
        ;

  SetLocal:
          IDENTIFIER '=' Expression         { result = Parser::Node.new(:set_local, { name: val[0], value: val[2] }) }
        ;

  Block:
          BLOCK_INIT Expressions BLOCK_END  { result = val[1] }
        ;

  Def:
          DEF IDENTIFIER Block              { result = Parser::Node.new(:def, { name: val[1], params: [], body: val[2] }) }
        | DEF IDENTIFIER
            '(' ParamList ')' Block         { result = Parser::Node.new(:def, { name: val[1], params: val[3], body: val[5] }) }
        ;

  ParamList:
          /* nothing */                     { result = [] }
        | IDENTIFIER                        { result = val }
        | ParamList ',' IDENTIFIER          { result = val[0] << val[2] }
        ;

  Class:
          CLASS CONSTANT Block              { result = Parser::Node.new(:class, { name: val[1], body: val[2] }) }
        ;

  If:
          IF Expression Block               { result = Parser::Node.new(:if, { condition: val[1], body: val[2] }) }
        ;

---- inner
  def parse(code)
    @tokens = UaiLang::Lexer.new(code).tokenize
    do_parse
  end

  def next_token
    @tokens.shift
  end
