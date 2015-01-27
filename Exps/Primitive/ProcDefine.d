import std.stdio;
import Exp, True, Nil, Env, PrimitiveProc;

class ProcDefine : PrimitiveProc {
 private:
  static ProcDefine obj;
  this() { }

 public:
  static this() {
    ProcDefine.obj = new ProcDefine();
  }

  static ProcDefine gen() {
    return obj;
  }

  override Exp apply(Exp exp, Env env)
  {
    if (exp.cdr.cdr != Nil.Nil.gen)
      throw new Exception("error: define is over arguments");
   
    Exp symbol  = exp.car;
    Exp def_exp = exp.cdr.car.eval(env);
    
    env.set(symbol, def_exp);
    return symbol;
  }
}