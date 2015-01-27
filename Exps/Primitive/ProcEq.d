import std.stdio;
import Exp, Env, True, Nil, PrimitiveProc;

class ProcEq : PrimitiveProc {
 private:
  static ProcEq obj;
  this() { }

 public:
  static this() {
    ProcEq.obj = new ProcEq();
  }

  static ProcEq gen() {
    return obj;
  }

  override Exp apply(Exp exp, Env env)
  {
    if (exp.cdr.cdr != Nil.Nil.gen)
      throw new Exception("error: over arguments");
    
    Exp car = exp.car.eval(env);
    Exp cdr = exp.cdr.car.eval(env);
    
    return car.eq(cdr);
  }
}