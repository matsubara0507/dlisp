import std.stdio;
import Exp, True, Nil, Env, PrimitiveProc;

class ProcQuote : PrimitiveProc {
 private:
  static ProcQuote obj;
  this() { }

 public:
  static this() {
    ProcQuote.obj = new ProcQuote();
  }

  static ProcQuote gen() {
    return obj;
  }

  override Exp apply(Exp exp, Env env)
  {
    if (exp.cdr != Nil.Nil.gen)
      throw new Exception("error: quote is over arguments");

    return exp.car;
  }
}