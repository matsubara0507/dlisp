import Exp, Env;

abstract class PrimitiveProc : Exp {
 public:
  override Exp eval(Env env){
    throw new Exception("error : function is undefined"); 
  }

  override Exp atom() {
    throw new Exception("error : function is undefined"); 
  }

  override Exp car() { 
    throw new Exception("error : function is undefined"); 
  }

  override Exp cdr() { 
    throw new Exception("error : function is undefined"); 
  }

  override void print() { 
    throw new Exception("error : function is undefined"); 
  }
}