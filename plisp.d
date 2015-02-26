import std.stdio;
import std.string;
import std.conv;
import std.array;

import Exps, Primitive, Syntax;
import Parser, Scanner;

int main() {
  Env.Env.set_global_env("true", True.True.gen);

  Env.Env.set_global_env("atom", ProcAtom.ProcAtom.gen);
  Env.Env.set_global_env("eq"  , ProcEq.ProcEq.gen);
  Env.Env.set_global_env("cons", ProcCons.ProcCons.gen);
  Env.Env.set_global_env("car" , ProcCar.ProcCar.gen);
  Env.Env.set_global_env("cdr" , ProcCdr.ProcCdr.gen);

  Env.Env.set_global_env("define", Define.Define.gen);
  Env.Env.set_global_env("quote" , Quote.Quote.gen);
  Env.Env.set_global_env("cond"  , Cond.Cond.gen);
  Env.Env.set_global_env("lambda", Lambda.Lambda.gen);

  Env.Env.set_global_env("+", ProcAdd.ProcAdd.gen);
  Env.Env.set_global_env("-", ProcSub.ProcSub.gen);
  Env.Env.set_global_env("*", ProcMul.ProcMul.gen);
  Env.Env.set_global_env("/", ProcDiv.ProcDiv.gen);

  Env env = new Env(Nil.Nil.gen, Nil.Nil.gen);

  Scanner scin = Scanner.Scanner.gen;

  for (;;) {
    try {
      write("disp");
      string input = scin.readln;
      if (input == "")
        continue;

      if (input == "(exit)")
        break;

      string[] inputs = input.replace(")", " ) ").replace("(", " ( ").split;
      if (inputs[0] == "(" && inputs[1] == "load" && inputs[3] == ")") {
        scin.set(inputs[2]);
        continue;
      }
      Parser parser = Parser.Parser.gen;
      Exp exp = parser.analysis(input);

      if (exp is null) {
        writeln("null!!");
        continue;
      }	
      exp.eval(env).print;
      writeln("");
    } 
    catch (Exception ex) {
      writeln(ex.toString);
    }
  }

  return 0;
}