import Env;

abstract class Exp {
  Exp eval(Env env);
  Exp apply(Exp actuals);
  void print();

  Exp atom();
  Exp car();
  Exp cdr();

  real value() {
    throw new Exception("error: this exp is not number"); 
  }

  string name() {
    throw new Exception("error: this exp is not symbol"); 
  }
}