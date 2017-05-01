import Exp, True, Nil, Env, List, PrimitiveProc;

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

  override Exp apply(Exp actuals)
  {
    if (actuals.cdr.cdr != Nil.Nil.gen)
      throw new Exception("error: over arguments");

    return new List(actuals.car, actuals.cdr.car);
  }
}