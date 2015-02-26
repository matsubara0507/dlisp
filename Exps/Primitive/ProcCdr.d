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

  override Exp apply(Exp actuals){
    if (actuals.cdr != Nil.Nil.gen)
      throw new Exception("error: over arguments");

    return actuals.car.cdr;
  }
}