import std.stdio;
import Exp, True, Nil, Env, PrimitiveProc;

class ProcCons : PrimitiveProc {
 private:
  static ProcCons obj;
  this() { }

 public:
  static this() {
    ProcCons.obj = new ProcCons();
  }

  static ProcCons gen() {
    return obj;
  }

  override Exp apply(Exp exp, Env env)
  {
    if (exp.cdr.cdr != Nil.Nil.gen)
      throw new Exception("error: over arguments");
   
    Exp car = exp.car.eval(env);
    Exp cdr = exp.cdr.car.eval(env);
    
    return car.cons(cdr);
  }
}