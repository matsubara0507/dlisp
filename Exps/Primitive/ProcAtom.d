import std.stdio;
import Exp, Nil, Env, PrimitiveProc;

class ProcAtom : PrimitiveProc {
 private:
  static ProcAtom obj;
  this() { }

 public:
  static this() {
    ProcAtom.obj = new ProcAtom();
  }

  static ProcAtom gen() {
    return obj;
  }

  override Exp apply(Exp exp, Env env) {
    if (exp.cdr != Nil.Nil.gen)
      throw new Exception("error: over arguments");

    return exp.car.eval(env).atom;
  }
}