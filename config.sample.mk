CFLAGS	=	-D_REENTRANT -O
LFLAGS	=	-lpthread -lrt -lm -L/opt/apps/papi/5.3.0/x86_64/lib -lpapi #-ltcmalloc
MKL_LFLAGS =	-L $(MKLROOT)/lib/intel64 -lmkl_intel_lp64 -lmkl_sequential -lmkl_core
IFLAGS  =       -I../src -I../IntelPCM -I$(MKLROOT)/include -I/opt/apps/papi/5.3.0/x86_64/include -pthread
LIBVER	=       decentrallibthrpool.a
AR	=	ar rc
RANLIB	=	ranlib
GCCDIR 	= 	/usr
CILK_INCLUDE=	$(GCCDIR)/include/cilk/
CILK_LIB= 	$(GCCDIR)/lib/
#CILK_FLAGS=	-lcilkrts -fcilkplus

COUNTERDIR = ../IntelPCM
COUNTEROBJECTS = $(COUNTERDIR)/msr.o $(COUNTERDIR)/pci.o $(COUNTERDIR)/cpucounters.o $(COUNTERDIR)/client_bw.o

CC	=	$(GCCDIR)/bin/gcc-5
CCP	=	$(GCCDIR)/bin/g++-5
#CC	= 	/opt/apps/intel/15/composer_xe_2015.2.164/bin/intel64/icpc
#CCP	=	/opt/apps/intel/15/composer_xe_2015.2.164/bin/intel64/icpc

#CFLAGS	=	-D_REENTRANT -ggdb
#CFLAGS	=	-D_REENTRANT -DNBEBUG -ggdb -O2 -funroll-loops  -finline-functions
#CFLAGS	=	-D_REENTRANT -DNDEBUG -O2 -funroll-loops -finline-functions
CFLAGS	=	-D_REENTRANT -DNDEBUG -O3 -funroll-loops -finline-functions -fno-omit-frame-pointer -fp-model precise

HOSTNAME = stampede
