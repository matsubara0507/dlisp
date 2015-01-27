import std.stdio;

import Exp, True, Nil, List, Env;

abstract class Atom : Exp{
  protected static Atom[string] list;
  
 public:
  override Exp eval(Env env) {
    return this;
  }
  
  override Exp apply(Exp exp, Env env) {
    throw new Exception("error: undefined apply");
  }

  override Exp atom() {
    return True.True.gen;
  }

  override Exp eq(Exp exp) {
    if (this == exp)
      return True.True.gen;
    else
      return Nil.Nil.gen;
  }

  override Exp cons(Exp exp) {
    return new List(this, exp);
  }

  override Exp car() {
    throw new Exception("error: undefined car");
  }

  override Exp cdr() {
    throw new Exception("error: undefined cdr");
  }
}