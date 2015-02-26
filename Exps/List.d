import std.stdio;
import Exp, Nil, True, Env, Syntax;

class List : Exp {
protected:
  Exp exp1;
  Exp exp2;

private:
  Exp make_evlist(Exp exp, Env env) 
  {
    if (exp == Nil.Nil.gen)
      return exp;
    else
      return new List(exp.car.eval(env), make_evlist(exp.cdr, env));
  }

public:
  this (Exp e1, Exp e2) {
    exp1 = e1;
    exp2 = e2;
  }

  override Exp eval(Env env) 
  {
    Exp procedure = exp1.eval(env);

    if (procedure == Cond.Cond.gen)
      return Cond.Cond.cond(exp2, env);

    if (procedure == Define.Define.gen)
      return Define.Define.define(exp2, env);

    if (procedure == Lambda.Lambda.gen)
      return Lambda.Lambda.lambda(exp2, env);

    if (procedure == Quote.Quote.gen)
      return Quote.Quote.quote(exp2, env);

    return procedure.apply(make_evlist(exp2, env));
  }

  override Exp apply(Exp actuals) {
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

  override Exp car() {
    return exp1;
  }

  override Exp cdr() {
    return exp2;
  }
}