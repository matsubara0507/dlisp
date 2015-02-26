import std.stdio;
import Exp, Atom, Env;

class Symbol : Atom {
 private:
  string key_name;
  
  this(string kn) {
    key_name = kn;
    list[key_name] = this;
  }
  
 public:
  static Exp gen(string key) {
    if (key in list)
      return list[key];
    return new Symbol(key);
  }

  override string name() {
    return key_name;
  }

  override Exp eval(Env env) 
  {
    Exp exp = env.lookup(this);
    if (exp is null)
      throw new Exception("error: " ~ key_name ~ " is undefined");
    return exp;
  }

  override void print() { 
    write(key_name);
  }
}