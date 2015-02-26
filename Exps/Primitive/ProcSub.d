import Exp, Env, Num, True, Nil, PrimitiveProc;

class ProcSub : PrimitiveProc {
 private:
  static ProcSub obj;
  this() { }

 public:
  static this() {
    ProcSub.obj = new ProcSub();
  }

  static ProcSub gen() {
    return obj;
  }

  override Exp apply(Exp actuals) 
  {
    Exp arg  = actuals.car;
    Exp next = actuals.cdr;

    real sum = arg.value;

    if (next == Nil.Nil.gen)
      return Num.Num.gen(-1 * sum);

    while (next != Nil.Nil.gen) {
      arg  = next.car;
      next = next.cdr;  

      sum -= arg.value;
    }      
    return Num.Num.gen(sum);
  }
}