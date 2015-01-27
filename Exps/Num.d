import std.stdio;
import std.conv;
import Exp, Atom, Env;

class Num : Atom {
 private:
  real val;

  this(real v) { 
    val = v;
    list[to!string(val)] = this;
  }
  
 public:
  static Exp gen(real v) {
    string key = to!string(v); 
    if (key in list)
      return list[key];
    return new Num(v);
  }

  override real value() {
    return val;
  }

  override void print() { 
    write(val);
  }
}