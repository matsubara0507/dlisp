module Scanner;
import std.stdio;
import std.string;

class Scanner {
private:
  static Scanner obj;
  File file;
  this () { }
public:
  static this() {
    obj = new Scanner;
  }

  static Scanner gen() {
    return obj;
  }

  void set(string fileName) {
    file = File(fileName, "r");
  }

  string readln() {
    write(">> ");
    if (!file.isOpen)
      return chomp(stdin.readln);
    string input = chomp(file.readln);
    writeln(input);
    if(file.eof)
      file.close;
    return input;
  }

}