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

  override Exp apply(Exp actuals) 
  {
    if (actuals.cdr != Nil.Nil.gen)
      throw new Exception("error: over arguments");

    return actuals.car.atom;
  }
}