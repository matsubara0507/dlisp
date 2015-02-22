import std.stdio;
import std.string;
import std.conv;

import Exps, Primitive;
import Parser, Scanner;

int main() {
  Env.Env.set_reserved("true", True.True.gen);

  Env.Env.set_reserved("atom", ProcAtom.ProcAtom.gen);
  Env.Env.set_reserved("eq"  , ProcEq.ProcEq.gen);
  Env.Env.set_reserved("cons", ProcCons.ProcCons.gen);
  Env.Env.set_reserved("car" , ProcCar.ProcCar.gen);
  Env.Env.set_reserved("cdr" , ProcCdr.ProcCdr.gen);

  Env.Env.set_reserved("define", ProcDefine.ProcDefine.gen);
  Env.Env.set_reserved("quote" , ProcQuote.ProcQuote.gen);
  Env.Env.set_reserved("cond"  , ProcCond.ProcCond.gen);
  Env.Env.set_reserved("lambda", ProcLambda.ProcLambda.gen);

  Env.Env.set_reserved("+", ProcAdd.ProcAdd.gen);
  Env.Env.set_reserved("-", ProcSub.ProcSub.gen);
  Env.Env.set_reserved("*", ProcMul.ProcMul.gen);
  Env.Env.set_reserved("/", ProcDiv.ProcDiv.gen);

  Env global_env = new Env();

  Exp[string] atom_list;
  
  Scanner scin = Scanner.Scanner.gen;

  for (;;) {
    write("disp");
    string input = scin.readln;

    if (input == "(exit)")
      break;

    try {
      Parser parser = Parser.Parser.gen;
      Exp exp = parser.analysis(input);

      if (exp is null) {
        writeln("null!!");
        continue;
      }	
      exp.eval(global_env).print;
      writeln("");
    }
    catch (Exception ex) {
      writeln(ex.toString);
    }
  }

  return 0;
}