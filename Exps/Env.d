import Exp, List, Nil;

class Env : List {
private:
  static Exp[string] global_env;

  Exp assoc(Exp symbol, Exp env) 
  {
    if (env.cdr == Nil.Nil.gen)
      return null;

    if (env.cdr.car == symbol)
      return env.cdr.cdr;
    return assoc(symbol, env.car);
  }

public:
  this(Exp e1, Exp e2) { 
    super(e1, e2);
  }

  static void set_global_env(string k, Exp v) {
    global_env[k] =  v;
  }

  Exp set(Exp symbol, Exp exp) 
  {
    super.exp1 = new Env(this.car, this.cdr);
    super.exp2 = new List(symbol, exp);

    return symbol;
  }

  Exp lookup(Exp symbol) 
  {
    Exp value = assoc(symbol, this);
    if (!(value is null))
      return value;
    if (symbol.name in global_env)
      return global_env[symbol.name];

    throw new Exception("error: " ~ symbol.name ~ " is not match");
  }

  Env pairlist(Exp symbols, Exp values) 
  {
    if (symbols == Nil.Nil.gen) {
      if (values != Nil.Nil.gen)
        throw new Exception("error: over arguments");
      return this;
    }

    if (symbols.car == Nil.Nil.gen) {
      if (values != Nil.Nil.gen)
        throw new Exception("error: over arguments");
      return this;
    }

    return new Env(this.pairlist(symbols.cdr, values.cdr), 
                   new List(symbols.car, values.car));
  }
}