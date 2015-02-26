import Exp, Env, Num, True, Nil, PrimitiveProc;

class ProcMul : PrimitiveProc {
 private:
  static ProcMul obj;
  this() { }

 public:
  static this() {
    ProcMul.obj = new ProcMul();
  }

  static ProcMul gen() {
    return obj;
  }

  override Exp apply(Exp actuals)
  {
    Exp arg  = actuals.car;
    Exp next = actuals.cdr;

    real product = 1;
    for (;;) {
      product *= arg.value;

      if (next == Nil.Nil.gen)
        break;

      arg  = next.car;
      next = next.cdr;  
    }      
    return Num.Num.gen(product);
  }
}