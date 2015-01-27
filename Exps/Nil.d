import std.stdio;
import Exp, Atom, Env;

class Nil : Atom {
 private:
  static Nil obj;
  this() { }

 public:
  static this() {
    obj = new Nil();
  }

  static Nil gen() {
    return obj;
  }

  override void print() {
    write("nil");
  }
}