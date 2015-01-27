import std.stdio;
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

  override Exp apply(Exp exp, Env env) 
  {
    Exp arg  = exp.car;
    Exp next = exp.cdr;

    real sum = 0;
    for (;;) {
      sum += arg.eval(env).value;

      if (next == Nil.Nil.gen)
	break;
      
      arg  = next.car;
      next = next.cdr;  
    }      
    return Num.Num.gen(sum);
  }
}