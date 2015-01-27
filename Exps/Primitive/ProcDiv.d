import std.stdio;
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

  override Exp apply(Exp exp, Env env){
    Exp arg  = exp.car;
    Exp next = exp.cdr;

    real dividend = arg.eval(env).value;
    if (next == Nil.Nil.gen) {
      if (dividend == 0) 
	throw new Exception("divisor is 0");
      return Num.Num.gen(1 / dividend);
    }      

    while (next != Nil.Nil.gen) {
      arg  = next.car;
      next = next.cdr;  

      real divisor = arg.eval(env).value;
      if (divisor == 0)
	throw new Exception("divisor is 0");

      dividend /= divisor;
    }      
    return Num.Num.gen(dividend);
  }
}