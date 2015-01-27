import std.stdio;
import Exp, Nil, True, Env;

class List : Exp {
 protected:
  Exp exp1;
  Exp exp2;

 public:
  this (Exp e1, Exp e2) {
    exp1 = e1;
    exp2 = e2;
  }
  
  override Exp eval(Env env) { 
    return exp1.eval(env).apply(exp2, env);
  }

  override Exp apply(Exp exp, Env env) {
    throw new Exception("error: apply is undefined");
  }

  override void print()
  {
    write("(");
    exp1.print;
    write(" ");
    exp2.print;
    write(")");
  }

  override Exp atom() {
    return Nil.Nil.gen;
  }

  override Exp eq(Exp exp) 
  {
    if (exp.atom == True.True.gen)
      return Nil.Nil.gen;

    if (exp1.eq(exp.car) == True.True.gen)
      return exp.eq(exp.cdr);
    else
      return Nil.Nil.gen;
  }
  
  override Exp cons(Exp exp) {
    return new List(this, exp);
  }

  override Exp car() {
    return exp1;
  }

  override Exp cdr() {
    return exp2;
  }
}