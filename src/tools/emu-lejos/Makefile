
EMU_NAME=emu-lejos
EMU_BIN=$(BIN_TARGET)/${EMU_NAME}

CC=$(shell $(LEJOS_HOME)/release/cctest.sh)

CCOPT=-I../vmsrc -m32 -Wall -Wno-unused -g3 -DTRACE=1 -DWRITE_ORDER=\"LE\" -DLOADER_TOOL=\"emu-lejosrun\" -DLINKER_TOOL=\"emu-lejos\"
# -O2 

default: programs

programs: ${EMU_NAME}

%.o: %.c
	${CC} ${CCOPT} -c $*.c


${EMU_NAME}: javaexec.c util.o
	${CC} ${CCOPT} $(TRACE) -c javaexec.c
	${CC} -m32 javaexec.o util.o -o ${EMU_BIN}

clean:
	rm -rf *.o *~ 
