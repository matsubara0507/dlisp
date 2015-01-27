import std.array;
import std.string;
import std.algorithm;
import std.stdio;
import std.ascii;

enum Kind {
  NUMBER, LETTER, LPAR, RPAR, EOT
}

class Token {
private:
  Kind token_kind;
  string token_value;

public:
  this (Kind k, string v) {
    token_kind  = k;
    token_value = v;
  }

  Kind kind() {
    return token_kind;
  }

  string value() {
    return token_value;
  }  
}

class Lexer {
private:
  static Lexer obj;
  
  this () { }
  
public:
  static this() {
    obj  = new Lexer();
  }
  
  static Lexer gen() {
    return obj;
  }

  Token[] analysis(string input) 
  {
    Token[] token_list;
    int length = input.length;

    for (int head = 0; head < length;) {
      int tail1 = std.string.indexOf(input[head..length], "(") + head;
      if (tail1 == head) {
	token_list ~= new Token(Kind.LPAR, null);
	head++;
	continue;
      }
      if (tail1 < head)
	tail1 = length;

      int tail2 = std.string.indexOf(input[head..length], ")") + head;
      if (tail2 == head) {
	token_list ~= new Token(Kind.RPAR, null);
	head++;
	continue;
      }
      if (tail2 < head)
	tail2 = length;

      int tail  = std.string.indexOf(input[head..length], " ") + head;
      if (tail == head) {
	head++;
	continue;
      }
      if (tail < head)
	tail = length;

      tail = min(tail1, tail2, tail);

      string sub = input[head..tail];
            
      if (isDigit(sub[0]))
	token_list ~= new Token(Kind.NUMBER, sub);
      else 
	token_list ~= new Token(Kind.LETTER, sub);
      head = tail;
    }
    
    token_list ~= new Token(Kind.EOT, null);
    return token_list;
  }

  unittest {
    string  testi = "(atom (cons 1 (cons a nil)))";
    Lexer   lexer = Lexer.gen();
    
    Token[] testo = lexer.analysis(testi);

    assert(testo[0].kind == Kind.LPAR);
    assert(testo[1].kind == Kind.LETTER);
    assert(testo[2].kind == Kind.LPAR);
    assert(testo[3].kind == Kind.LETTER);
    assert(testo[4].kind == Kind.NUMBER);
    assert(testo[5].kind == Kind.LPAR);
    assert(testo[6].kind == Kind.LETTER);
    assert(testo[7].kind == Kind.LETTER);
    assert(testo[8].kind == Kind.LETTER);
    assert(testo[9].kind == Kind.RPAR);
    assert(testo[10].kind == Kind.RPAR);
    assert(testo[11].kind == Kind.RPAR);
    assert(testo[12].kind == Kind.EOT);
  }
}
