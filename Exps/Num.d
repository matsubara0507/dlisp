import std.stdio;
import std.conv;
import Exp, Atom, Env;

class Num : Atom {
 private:
  static Num[real] list;
  real val;

  this(real val) { 
    this.val = val;
    list[val] = this;
  }
  
 public:
  static Exp gen(real key) {
    if (key in list)
      return list[key];
    return new Num(key);
  }

  override real value() {
    return val;
  }

  override void print() { 
    writef("%.15f", val);
  }
}