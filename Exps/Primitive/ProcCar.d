import Exp, True, Nil, Env, PrimitiveProc;

class ProcCar : PrimitiveProc {
 private:
  static ProcCar obj;
  this() { }

 public:
  static this() {
    ProcCar.obj = new ProcCar();
  }

  static ProcCar gen() {
    return obj;
  }

  override Exp apply(Exp actuals)
  {
    if (actuals.cdr != Nil.Nil.gen)
      throw new Exception("error: over arguments");

    return actuals.car.car;
  }
}