## D Lisp

Pure Lisp on D Language.

Implemented based on OOP.

Implement the closure to use lazy evaluation.

## Run

Sorry, maybe...

```
$  dmd -ofplisp *.d ./**/*.d ./**/**/*.d
$ ./plisp
dlisp>> (+ 1 1)
2
dlisp>> (load test.txt)
...
```

## Docker

```
$ docker pull matsubara0507/dlisp
$ docker run -it --rm dlang plisp
```
