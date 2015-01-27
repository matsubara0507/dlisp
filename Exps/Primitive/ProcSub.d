import std.stdio;
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

  override Exp apply(Exp exp, Env env) {
    Exp arg  = exp.car;
    Exp next = exp.cdr;

    real sum = arg.eval(env).value;

    if (next == Nil.Nil.gen)
      return Num.Num.gen(-1 * sum);

    while (next != Nil.Nil.gen) {
      arg  = next.car;
      next = next.cdr;  

      sum -= arg.eval(env).value;
    }      
    return Num.Num.gen(sum);
  }
}