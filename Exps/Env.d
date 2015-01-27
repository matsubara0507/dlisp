import std.stdio;
import Exp, List, Nil;

class Env {
private:
  static Exp[string] reserved;
  Exp env_list;
  
public:
  this() { 
    env_list = new List(Nil.Nil.gen, Nil.Nil.gen);
  }
  
  static void set_reserved(string k, Exp v) {
    reserved[k] =  v;
  }

  void add_frame(Exp args, Exp exp) {
    Exp frame = Nil.Nil.gen;
    Exp arg  = args.car;
    Exp next = args;

    if (arg != Nil.Nil.gen) {
      do {
	arg  = next.car;
	next = next.cdr;
	if (arg.name in reserved)
	  throw new Exception("error: " ~ arg.name ~ " is reserved word");   

	frame = frame.cons(arg.cons(exp.car));
	exp = exp.cdr;
      } while (next != Nil.Nil.gen);
    }
    
    if (exp != Nil.Nil.gen) 
      throw new Exception("error: over arguments");
    env_list = env_list.cons(frame);
  }
   
  void pop() {
    env_list = env_list.car;
  }

  void set(Exp symbol, Exp exp) 
  {
    if (symbol.name in reserved)
      throw new Exception("error: " ~ symbol.name ~ " is reserved word");   
    env_list = env_list.car.cons(env_list.cdr.cons(symbol.cons(exp))); 
  }

  Exp get(Exp symbol) {
    if (symbol.name in reserved)
      return reserved[symbol.name];
    Exp next  = env_list;
    do {
      Exp frame = next.cdr;
      next = next.car;
      while (frame != Nil.Nil.gen) {
	if (frame.cdr.car == symbol) 
	  return frame.cdr.cdr;
	frame = frame.car;
      }
    } while (next != Nil.Nil.gen);
   
    return null;
  }
}