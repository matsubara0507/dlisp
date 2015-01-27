import std.stdio;
import Exp, Atom, Env;

class True : Atom {
 private:
  static True obj;
  this() { }

 public:
  static this() {
    True.obj = new True();
  }

  static True gen() {
    return obj;
  }

  override void print() {
    write("True");
  }
}