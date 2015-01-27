import std.conv;
import std.array;
import std.stdio;

import Lexer;
import Exps;

class Parser {
private:
  static Parser obj;
  Token[] token_list;
  this() { }

  Exp make_exp() 
  {
    Token head = token_list.front;
    Exp exp;

    switch (head.kind) {
    case Kind.LPAR:
      token_list.popFront;
      exp = make_list;
      token_list.popFront;
      break;
    case Kind.RPAR:
      return Nil.Nil.gen;
    default:
      exp = make_atom;
    }
    return exp;
  }

  Exp make_list() 
  {
    if (token_list.front.kind == Kind.EOT)
      throw new Exception("parse error: ) not found");
      
    Exp car = make_exp;

    if (token_list.front.kind != Kind.RPAR)
      return  new List(car, make_list());

    return new List(car, Nil.Nil.gen);
  }

  Exp make_atom() 
  {
    Token head = token_list.front;
    
    Exp exp;
    switch (head.kind) {
    case Kind.NUMBER:
	exp = Num.Num.gen(to!real(head.value));
      break;
    case Kind.LETTER:
	exp = Symbol.Symbol.gen(head.value);
      break;
    default:
      throw new Exception("token is not mache");
    }
    token_list.popFront;

    return exp;
  }


public:
  static this() {
    obj  = new Parser();
  }

  static Parser gen() {
    return obj;
  }

  Exp analysis(Token[] tlist)
  {
    token_list = tlist;

    Exp temp = make_exp;
    
    if (token_list.front.kind == Kind.EOT)
      return temp;
    else
      throw new Exception("parse error: EOT not found");
  }

  unittest {
    Lexer   lexer  = Lexer.Lexer.gen();
    Parser  parser = Parser.gen();
    
    Token[] testi = lexer.analysis("(");

    assert(testi[0].kind == Kind.LPAR);
    assert(testi[1].kind == Kind.EOT);

    parser.analysis(testi);
  }
}