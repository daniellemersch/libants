# Written by Alessandro Crespi
CPP = g++
AR = ar
RANLIB = ranlib
CPPFLAGS = -Wall -O3

# Name of the output library (e.g., libtest.a to link with -ltest when compiling)
LIBNAME = libants.a

# Prefix for install of library
PREFIX = /usr/local

# Include prefix (i.e., #include <libants/file.h> in source code)
INCLUDEPREFIX = libants

# List of all the object files that have to be included in the library
OBJFILES = datfile.o exception.o histogram.o plume.o statistics.o tags3.o utils.o

# Default target
all: $(LIBNAME)

# Rules to compile from C++ sources (.cpp & .cc) to object files
%.o: %.cc
	@echo "  [cc]" $<
	@$(CPP) $(CPPFLAGS) -o $@ -c $<

%.o: %.cpp
	@echo "  [cc]" $<
	@$(CPP) $(CPPFLAGS) -o $@ -c $<

# Rule to make a .a file (static library)
%.a:
	@echo " [lib]" $@
	@$(AR) rc $@ $^
	@$(RANLIB) $@


rebuild: clean all

clean:
	@/bin/echo -n "Cleaning... "
	@-rm -f *.o
	@-rm -f *.a
	@echo done.

install: $(LIBNAME)
	install -c -d -m 755 $(PREFIX)/include/$(INCLUDEPREFIX)
	install -c -m 644 *.h $(PREFIX)/include/$(INCLUDEPREFIX)
	install -c -m 644 $(LIBNAME) $(PREFIX)/lib
	
uninstall:
	-rm -f $(PREFIX)/lib/$(LIBNAME)
	-rm -f $(PREFIX)/include/$(INCLUDEPREFIX)/*.h
	-rmdir $(PREFIX)/include/$(INCLUDEPREFIX)
	
# Object files to compile into the library
$(LIBNAME): $(OBJFILES)

# List of non-file targets
.PHONY: all rebuild clean install uninstall
