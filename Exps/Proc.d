import std.stdio;
import Exp, True, List, Nil, True, Env;

class Proc : List {
 private:
  Exp make_evlist(Exp exp, Env env) {
    if (exp == Nil.Nil.gen)
      return exp;
    else
      return exp.car.eval(env).cons(make_evlist(exp.cdr, env));
  }

 public:
  this (Exp args, Exp body_exp) {
    super(args, body_exp);
  }
  
  override Exp eval(Env env) {
    throw new Exception("error: this is proc");
  }

  override Exp apply(Exp exp, Env env)
  {
    Exp args = Nil.Nil.gen;
    if (exp != Nil.Nil.gen)
      args = make_evlist(exp, env);

    env = env.pairlis(super.exp1, args);
    Exp temp = super.exp2.eval(env);
    return temp;
  }

  override void print(){
    write("<");
    super.exp2.print;
    write(">");
  }

  override Exp eq(Exp exp) 
  {
    if (this == exp)
      return True.True.gen;
    else
      return Nil.Nil.gen;
  }
}