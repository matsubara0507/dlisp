import std.stdio;
import Exp, True, Nil, Env, SyntaxProc;

class Cond : SyntaxProc {
 private:
  static Cond obj;
  this() { }

public:
  static this() {
    Cond.obj = new Cond();
  }

  static Cond gen() {
    return obj;
  }

  static Exp cond(Exp exp, Env env)
  {
    if (exp == Nil.Nil.gen)
      throw new Exception("error: cond error");

    Exp clauses = exp.car;
    Exp next    = exp.cdr;

    if (clauses.car.eval(env) == True.True.gen)
      return clauses.cdr.car.eval(env);
    return cond(next, env);
  }
}