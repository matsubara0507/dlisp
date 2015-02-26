import std.stdio;
import Exp, True, Nil, Env, SyntaxProc;

class Quote : SyntaxProc {
 private:
  static Quote obj;
  this() { }

 public:
  static this() {
    Quote.obj = new Quote();
  }

  static Quote gen() {
    return obj;
  }

  static Exp quote(Exp exp, Env env)
  {
    if (exp.cdr != Nil.Nil.gen)
      throw new Exception("error: quote is over arguments");

    return exp.car;
  }
}