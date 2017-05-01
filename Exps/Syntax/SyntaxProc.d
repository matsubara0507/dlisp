import Exp, Env;

class SyntaxProc : Exp {
public: 
  override Exp eval(Env env) {
    throw new Exception("error : eval is undefined"); 
  }

  override Exp apply(Exp actual){
    throw new Exception("error : apply is undefined"); 
  }

  override void print() { 
    throw new Exception("error : print is undefined"); 
  }

  override Exp atom() {
    throw new Exception("error : atom is undefined"); 
  }

  override Exp car() { 
    throw new Exception("error : car is undefined"); 
  }

  override Exp cdr() { 
    throw new Exception("error : cdr is undefined"); 
  }
}