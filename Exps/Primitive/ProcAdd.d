import Exp, Env, Num, True, Nil, PrimitiveProc;

class ProcAdd : PrimitiveProc {
 private:
  static ProcAdd obj;
  this() { }

 public:
  static this() {
    ProcAdd.obj = new ProcAdd();
  }

  static ProcAdd gen() {
    return obj;
  }

  override Exp apply(Exp actuals) 
  {
    Exp arg  = actuals.car;
    Exp next = actuals.cdr;

    real sum = 0;
    for (;;) {
      sum += arg.value;

      if (next == Nil.Nil.gen)
      	break;

      arg  = next.car;
      next = next.cdr;  
    }      
    return Num.Num.gen(sum);
  }
}