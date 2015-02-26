import std.stdio;
import Exp, True, Nil, Env, Closure, SyntaxProc;

class Lambda : SyntaxProc {
 private:
  static Lambda obj;
  this() { }

 public:
  static this() {
    Lambda.obj = new Lambda();
  }

  static Lambda gen() {
    return obj;
  }

  static lambda(Exp exp, Env env)
  {
    if (exp.cdr.cdr != Nil.Nil.gen)
      throw new Exception("error: lambda is over arguments");
   
    return new Closure(exp, env);
  }
}