import Exp, True, Nil, List, Env;

abstract class Atom : Exp{
  protected static Atom[string] list;
  
 public:
  override Exp eval(Env env) {
    return this;
  }
  
  override Exp apply(Exp actuals) {
    throw new Exception("error: undefined apply");
  }

  override Exp atom() {
    return True.True.gen;
  }

  override Exp car() {
    throw new Exception("error: undefined car");
  }

  override Exp cdr() {
    throw new Exception("error: undefined cdr");
  }
}