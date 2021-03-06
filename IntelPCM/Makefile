#
# Copyright (c) 2009-2012 Intel Corporation
# written by Roman Dementiev
#

include ../config.mk

all: pcm-power.x pcm.x pcm-sensor.x pcm-msr.x pcm-memory.x

#CC=g++ -Wall
#OPT= -g -O3 
OPT= -O3

# uncomment if you want to rely on Linux perf support (user needs CAP_SYS_ADMIN privileges)
ifneq ($(wildcard /usr/include/linux/perf_event.h),)
#OPT+= -DPCM_USE_PERF 
endif

UNAME:=$(shell uname)

ifeq ($(UNAME), Linux)
LIB= -lpthread -lrt
endif
ifeq ($(UNAME), Darwin)
LIB= -lpthread -lPcmMsr
endif
ifeq ($(UNAME), FreeBSD)
LIB= -lpthread
endif


msr.o: msr.h msr.cpp 
	$(CCP) $(OPT) -c msr.cpp

pci.o: pci.h pci.cpp
	$(CCP) $(OPT) -c pci.cpp

client_bw.o: client_bw.h pci.h client_bw.cpp
	$(CCP) $(OPT) -c client_bw.cpp

pcm-msr.o: msr.h msr.cpp pcm-msr.cpp
	$(CCP) $(OPT) -c pcm-msr.cpp

pcm-memory.o: pcm-memory.cpp msr.h pci.h cpucounters.h types.h width_extender.h
	$(CCP) $(OPT) -c pcm-memory.cpp

cpucounters.o: msr.h msr.cpp cpucounters.h cpucounters.cpp types.h width_extender.h 
	$(CCP) $(OPT) -c cpucounters.cpp

msrtest.x: msrtest.cpp msr.o cpucounters.o cpucounters.h  msr.h  types.h
	$(CCP) $(OPT) msrtest.cpp -o msrtest.x msr.o cpucounters.o pci.o $(LIB)

cpucounterstest.o: cpucounterstest.cpp cpucounters.h pci.h msr.h  types.h
	$(CCP) $(OPT) -c cpucounterstest.cpp

pcm-power.o: pcm-power.cpp msr.h types.h pci.h cpucounters.h
	$(CCP) $(OPT) -c pcm-power.cpp

realtime.o: realtime.cpp cpucounters.h  msr.h  types.h
	$(CCP) $(OPT) -c realtime.cpp

test.o: test.cpp cpucounters.h  msr.h  types.h
	$(CCP) $(OPT) -c test.cpp

pcm.x: msr.o cpucounters.o cpucounterstest.o pci.o client_bw.o
	$(CCP) $(OPT) msr.o pci.o client_bw.o cpucounters.o cpucounterstest.o -o pcm.x $(LIB)

pcm-power.x: msr.o cpucounters.o pci.o pcm-power.o client_bw.o
	$(CCP) $(OPT) msr.o client_bw.o cpucounters.o pci.o pcm-power.o -o pcm-power.x $(LIB)

pcm-msr.x: msr.o pcm-msr.o
	$(CCP) $(OPT) msr.o pcm-msr.o -o pcm-msr.x $(LIB)

realtime.x: msr.o cpucounters.o realtime.o pci.o client_bw.o
	$(CCP) $(OPT) pci.o msr.o client_bw.o cpucounters.o realtime.o -o realtime.x $(LIB)

test.x: msr.o cpucounters.o test.o pci.o client_bw.o loops.h
	$(CCP) $(OPT) pci.o msr.o client_bw.o cpucounters.o test.o -o test.x $(LIB)

pcm-memory.x: msr.o pcm-memory.o pci.o cpucounters.o client_bw.o
	$(CCP) $(OPT) msr.o pci.o cpucounters.o client_bw.o pcm-memory.o -o pcm-memory.x $(LIB)

pcm-sensor.o: pcm-sensor.cpp cpucounters.h cpuasynchcounter.h msr.h  types.h
	$(CCP) $(OPT) -c pcm-sensor.cpp

pcm-sensor.x: msr.o cpucounters.o pcm-sensor.o pci.o client_bw.o
	$(CCP) $(OPT) msr.o pci.o client_bw.o cpucounters.o pcm-sensor.o -o pcm-sensor.x $(LIB)

nice:
	uncrustify --replace -c ~/uncrustify.cfg *.cpp *.h WinMSRDriver/Win7/*.h WinMSRDriver/Win7/*.c WinMSRDriver/WinXP/*.h WinMSRDriver/WinXP/*.c  PCM_Win/*.h PCM_Win/*.cpp  

clean:
	rm -rf *.x *.o *~
