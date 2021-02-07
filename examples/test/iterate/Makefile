LEJOSHOME = ../../..

LEJOSC     = $(LEJOSHOME)/bin/lejosjc
LEJOSLINK = $(LEJOSHOME)/bin/lejoslink
LEJOSDL    = $(LEJOSHOME)/bin/lejosdl

EMULEJOS = $(LEJOSHOME)/bin/emu-lejos
EMULEJOSRUN = $(LEJOSHOME)/bin/emu-lejosrun
LEJOSFIRMDL = $(LEJOSHOME)/bin/firmdl

LEJOSCP = $(LEJOSHOME)/lib/*:$(LEJOSHOME)/3rdparty/lib/*

CLASSPATH = $(LEJOSHOME)/lib/classes.jar:.
CLASSLIB = $(LEJOSHOME)/lib/classes.jar

SOURCES = Iterate.java
OBJECTS = Iterate.class
PROGRAMS = Iterate
BINARY = Iterate.bin
EMUBINARY = Iterate.emu
SIGNATURE = Iterate.sig

.EXPORT_ALL_VARIABLES :

.PHONY : run

default : run

run : $(BINARY)
	$(LEJOSDL) $(BINARY)

emulate : $(EMUBINARY)
	$(EMULEJOSRUN) $(EMUBINARY)

firmdl :
	$(LEJOSFIRMDL)

$(BINARY) : $(OBJECTS)
	$(LEJOSLINK) $(PROGRAMS) -o $(BINARY) > $(SIGNATURE)

$(EMUBINARY) : $(OBJECTS)
	$(EMULEJOS) $(PROGRAMS) -o $(EMUBINARY)

$(OBJECTS) : $(SOURCES) $(CLASSLIB)
	$(LEJOSC) $(SOURCES)

clean :
	rm -f $(BINARY) $(SIGNATURE) *.class *~ core
