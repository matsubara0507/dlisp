import std.stdio;
import std.conv;
import Exp, List, Nil;

class Env : List {
private:
  static Exp[string] reserved;

public:
  this(Exp e1, Exp e2) { 
    super(e1, e2);
  }

  static void set_reserved(string k, Exp v) {
    reserved[k] =  v;
  }

  Exp set(Exp symbol, Exp exp) 
  {
    if (symbol.name in reserved)
      throw new Exception("error: " ~ symbol.name ~ " is reserved word");
    super.exp1 = new Env(this.car, this.cdr);
    super.exp2 = symbol.cons(exp);

    return symbol;
  }

  Exp assoc(Exp symbol) 
  {
    if (symbol.name in reserved)
      return reserved[symbol.name];

    if (this.cdr == Nil.Nil.gen)
      throw new Exception("error: " ~ symbol.name ~ " is not match");

    if (this.cdr.car == symbol)
      return this.cdr.cdr;
    
    return this.car.assoc(symbol);
  }

  Env pairlis(Exp symbols, Exp values) 
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

    return new Env(this.pairlis(symbols.cdr, values.cdr), 
                   new List(symbols.car, values.car));
  }
}