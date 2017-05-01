import std.stdio;
import Exp, List, Env, True, Nil;

class Closure : List {
private:
  // Bind variables
  Env add_binding(Exp vars, Exp vals, Env env) 
  {
    if (vars == Nil.Nil.gen)
      return env;
    if (vars.atom == True.True.gen)
      return new Env(new List(vars, vals), env);

    if (vars.car == Nil.Nil.gen)
      return env;

    return new Env(add_binding(vars.cdr, vals.cdr, env),
                   new List(vars.car, vals.car));
  }

public:
  this(Exp exp, Env env) {
    super(exp, env);
  }

  override Exp eval(Env env){
    throw new Exception("error : eval is undefined"); 
  }

  override Exp apply(Exp actuals)
  {
    Exp exp = super.exp1;
    Env env = new Env(super.exp2.car, super.exp2.cdr);
    return exp.cdr.car.eval(add_binding(exp.car, actuals, env));
  }

  override void print() 
  {
    write("[");
    exp1.print;
    write("](");
    exp2.print;
    write(")");
  }
}