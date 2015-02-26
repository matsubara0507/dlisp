import std.stdio;
import Exp, True, Nil, Env, SyntaxProc;

class Define : SyntaxProc {
 private:
  static Define obj;
  this() { }

 public:
  static this() {
    Define.obj = new Define();
  }

  static Define gen() {
    return obj;
  }

  static Exp define(Exp exp, Env env)
  {
    if (exp.atom == True.True.gen)
      throw new Exception("error: define is few argumets");
    if (exp.cdr.cdr != Nil.Nil.gen)
      throw new Exception("error: define is over arguments");

    Exp symbol  = exp.car;
    Exp def_exp = exp.cdr.car.eval(env);

    Env.Env.set_global_env(symbol.name, def_exp);
    return symbol;
  }
}