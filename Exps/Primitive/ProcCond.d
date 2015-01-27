import std.stdio;
import Exp, True, Nil, Env, PrimitiveProc;

class ProcCond : PrimitiveProc {
 private:
  static ProcCond obj;
  this() { }

 public:
  static this() {
    ProcCond.obj = new ProcCond();
  }

  static ProcCond gen() {
    return obj;
  }

  override Exp apply(Exp exp, Env env){
    Exp clauses = exp.car;
    Exp next    = exp.cdr;

    for (;;) {
      if (clauses.cdr.cdr != Nil.Nil.gen)
	throw new Exception("error: clauses is over arguments");
      Exp p = clauses.car;
      Exp e = clauses.cdr.car;

      if (p.eval(env) == True.True.gen)
	return e.eval(env);
      
      if (next == Nil.Nil.gen)
	break;
      
      clauses = next.car;
      next    = next.cdr;  
    }      
    return Nil.Nil.gen;
  }
}