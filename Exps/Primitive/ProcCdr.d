import std.stdio;
import Exp, True, Nil, Env, PrimitiveProc;

class ProcCdr : PrimitiveProc {
 private:
  static ProcCdr obj;
  this() { }

 public:
  static this() {
    ProcCdr.obj = new ProcCdr();
  }

  static ProcCdr gen() {
    return obj;
  }

  override Exp apply(Exp exp, Env env){
    if (exp.cdr != Nil.Nil.gen)
      throw new Exception("error: over arguments");
    return exp.car.eval(env).cdr;
  }
}