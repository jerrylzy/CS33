.PHONY: default seq omp clean check checkmem

SRC = filter.c
SRCS = $(SRC) main.c func.c util.c
CFLAGS =
LIBS = -lm
PROG = filter


ifdef GPROF
CFLAGS += -O2 -pg
else
CFLAGS += -O3
endif

ifdef MTRACE
CFLAGS += -DMTRACE
endif

default: filter

seq: $(SRCS)
	gcc -o $@ $(CFLAGS) $(SRCS) $(LIBS)
omp: $(SRCS)
	gcc -o $@ $(CFLAGS) -fopenmp $(SRCS) $(LIBS)
filter: omp
	cp $< $@
output.txt: filter
	./filter
check: correct.txt output.txt
	diff --brief correct.txt output.txt
checkmem:
	mtrace $(PROG) mtrace.out || true
clean:
	rm -f seq omp filter output.txt mtrace.out gprof.out
