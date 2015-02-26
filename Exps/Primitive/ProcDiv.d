import Exp, Env, Num, True, Nil, PrimitiveProc;

class ProcDiv : PrimitiveProc {
 private:
  static ProcDiv obj;
  this() { }

 public:
  static this() {
    ProcDiv.obj = new ProcDiv();
  }

  static ProcDiv gen() {
    return obj;
  }

  override Exp apply(Exp actuals){
    Exp arg  = actuals.car;
    Exp next = actuals.cdr;

    real dividend = arg.value;

    if (next == Nil.Nil.gen) {
      if (dividend == 0) 
        throw new Exception("divisor is 0");
      return Num.Num.gen(1 / dividend);
    }      

    while (next != Nil.Nil.gen) {
      arg  = next.car;
      next = next.cdr;  

      real divisor = arg.value;
      if (divisor == 0)
        throw new Exception("divisor is 0");

      dividend /= divisor;
    }      
    return Num.Num.gen(dividend);
  }
}