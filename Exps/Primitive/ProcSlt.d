import Exp, Env, True, Nil, PrimitiveProc;

class ProcSlt : PrimitiveProc {
private:
  static ProcSlt obj;
  this() { }

public:
  static this() {
    ProcSlt.obj = new ProcSlt();
  }

  static ProcSlt gen() {
    return obj;
  }

  override Exp apply(Exp actuals)
  {
    if (actuals.cdr.cdr != Nil.Nil.gen)
      throw new Exception("error: over arguments");

    if (actuals.car.value < actuals.cdr.car.value)
      return True.True.gen;
    return Nil.Nil.gen;
  }
}