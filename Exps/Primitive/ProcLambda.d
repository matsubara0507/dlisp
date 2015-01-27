import std.stdio;
import Exp, True, Nil, Env, Proc, PrimitiveProc;

class ProcLambda : PrimitiveProc {
 private:
  static ProcLambda obj;
  this() { }

 public:
  static this() {
    ProcLambda.obj = new ProcLambda();
  }

  static ProcLambda gen() {
    return obj;
  }

  override Exp apply(Exp exp, Env env)
  {
    if (exp.cdr.cdr != Nil.Nil.gen)
      throw new Exception("error: lambda is over arguments");
   
    Exp car = exp.car;
    Exp cdr = exp.cdr.car;

    return new Proc(car, cdr);
  }
}