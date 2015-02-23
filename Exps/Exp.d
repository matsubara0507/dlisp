import Env;

abstract class Exp {
  Exp eval(Env env);
  Exp apply(Exp exp, Env env);
  void print();

  Exp atom();
  Exp eq(Exp exp);
  Exp cons(Exp exp);
  Exp car();
  Exp cdr();

  real value() {
    throw new Exception("error: this exp is not number"); 
  }

  string name() {
    throw new Exception("error: this exp is not symbol"); 
  }

  Exp assoc(Exp symbol) {
    throw new Exception("error: this exp is not environment");
  }
}