import std.conv;
import std.array;
import std.stdio;

import std.string;
import std.ascii;
import std.variant;

import Exps;

class Parser {
private:
  static Parser obj;
  string[] tokens;
  this() { }

  Exp read_from_tokens() 
  {
    if (tokens.length == 0)
      throw new Exception("error: unexpected EOF while reading");

    switch (tokens.front) {
      case "(":
        tokens.popFront;
			  Exp exp = make_list;
			  tokens.popFront;
			  return exp;
		  case ")":
			  return Nil.Nil.gen;
		  default:
			  return make_atom;
	  }
  }

  Exp make_list() 
  {
	  auto car = read_from_tokens;

    if (tokens.length == 0)
      throw new Exception("error: unexpected EOF while reading");

	  if (tokens.front != ")")   
		  return new List(car, make_list);

	  return new List(car, Nil.Nil.gen);
  }

  Exp make_atom() 
  {
	  string head = tokens.front;
	  tokens.popFront;
	
    if (isDigit(head[0])) 
		  return Num.Num.gen(to!real(head));

	  return Symbol.Symbol.gen(head);
  }

public:
  static this() {
    obj  = new Parser();
  }

  static Parser gen() {
    return obj;
  }

  Exp analysis(string program)
  {
    tokens = program.replace(")", " ) ").replace("(", " ( ").split;
    Exp exp = read_from_tokens;

    if (tokens.length != 0)
      throw new Exception("error: unexpected )");

    return exp;
  }
}