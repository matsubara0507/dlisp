FROM dlanguage/ldc:latest

WORKDIR /root/dlisp
COPY . /root/dlisp
RUN ldc2 -ofplisp *.d ./**/*.d ./**/**/*.d

CMD ["./plisp"]
