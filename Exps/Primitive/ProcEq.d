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

  override Exp apply(Exp actuals)
  {
    if (actuals.cdr.cdr != Nil.Nil.gen)
      throw new Exception("error: over arguments");

    if (actuals.car == actuals.cdr.car)
      return True.True.gen;
    return Nil.Nil.gen;
  }
}