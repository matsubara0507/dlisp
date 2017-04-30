FROM dlanguage/dmd:latest

WORKDIR /root/dlisp
COPY . /root/dlisp
RUN dmd -ofplisp *.d ./**/*.d ./**/**/*.d

CMD ["./plisp"]
