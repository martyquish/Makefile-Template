#---------- Configure project settings -----------------


# Used for any operations requiring the name of the project
PROJNAME = maketest

# Name of executable for 'make all' to build
EXEC = $(PROJNAME).exe

# The names of the source files.
SRCS := $(shell find . -regextype sed -regex '.*\.\(cc\?\|cpp\)' | tr '\n' ' ')

# All object files necessary to build the above executable files for the project. They will be placed in the .objs folder to keep the working directory clean
OBJS := $(shell echo $(SRCS) | sed 's/\.\(cc\?\|cpp\)/.o/g' | sed 's/\.\//.\/.objs\//g')

# Specify any intermediary files which should not be automatically cleaned during implicit chaining.
.PRECIOUS =

# Specify any files which 'make clean' should remove.
JUNK = *~

# Specify a location for 'make backup' to backup your files.
BACKUPPATH = ~/backups

# Specify a log file to store any automatically suppressed errors (i.e. rm not finding a certain junk file)
LOG = make.log

# The name of the file to store the most recent execution transcript from a test run using the 'test' target (make test)
TESTFILE=test.out

# -------------------- Configure C/C++ --------------------

#C++ compiler usedsettings:
CXX = g++

#C compiler used
CC = gcc

#C compiler flags
CCFLAGS =

#C++ compiler flags
CXXFLAGS =

#C preprocessor flags
CPPFLAGS = -Wall

#Linker flags
LDFLAGS =

#Configure Lex/F
# Program to interpret .l and .lex files
LEX = /usr/bin/flex
# Lex flags
LFLAGS =         

# --------------- Configure YACC/Bison settings --------------

# Program to interpret .y files
YACC = /usr/bin/bison
# Yacc flags
YFLAGS = -dy            

all: .make .objs $(EXEC)
	@ORPHANS='$(shell .objs/./cleanup.sh)';\
	if [ $$ORPHANS != 'none' ]; then \
		echo "Orphaned object files detected and cleaned: $$ORPHANS";\
		echo "Re-linking executable...";\
		echo "<<---------------------------------------------------------------------------->>\n";\
		echo '$(CXX) -o $(EXEC) $(CPPFLAGS) $(CXXFLAGS) $(LDFLAGS) $(OBJS)';\
		$(CXX) -o $(EXEC) $(CPPFLAGS) $(CXXFLAGS) $(LDFLAGS) $(OBJS);\
		echo "\n<<---------------------------------------------------------------------------->>\n";\
	fi


clean:
	@rm -r $(JUNK) .objs/* $(EXEC) 2> $(LOG) || true

# Run this target to compile and test your program at once. It will also save an execution transcript in the file "test.out"
test: all
	@echo "\n<<------------------------ Begin Output ------------------------>>\n\n";\
	script -q -c./$(EXEC) test.out;\
	exit;\
	echo "\n\n<<------------------------ End Output ------------------------>>\n";\
	echo "Output saved to 'test.out'\n"

# Initialization routine which may be run to configure the Makefile
init:

	@if [ ! -d ./.make ]; then \
		mkdir .make 2>> make.log;\
		echo "Created directory: '.make'";\
	fi
	@if [ ! -d ./.objs ]; then \
		mkdir .objs 2>> make.log;\
		echo "Created directory: '.objs'";\
	fi






.make .objs: init


depend: .depend

.depend: $(SRCS)
	@echo Updating header dependencies...
	@echo "<<---------------------------------------------------------------------------->>\n"
	rm -rf ./.depend
	$(CXX) $(CPPFLAGS) -MM $^ > ./.depend
	@echo "\n<<---------------------------------------------------------------------------->>\n"

include .depend



./.objs/%.o:%.cc
	@echo Compiling $<
	@echo "<<---------------------------------------------------------------------------->>\n"
	$(CXX) -c -o $@ $(CPPFLAGS) $(CXXFLAGS) $<
	@echo "\n<<---------------------------------------------------------------------------->>\n"

./.objs/%.o:%.cpp
	@echo Compiling $<
	@echo "<<---------------------------------------------------------------------------->>\n"
	$(CXX) -c -o $@ $(CPPFLAGS) $(CXXFLAGS) $<
	@echo "\n<<---------------------------------------------------------------------------->>\n"

./.objs/%.o:%.c
	@echo Compiling $<
	@echo "<<---------------------------------------------------------------------------->>\n"
	$(CC) -c -o $@ $(CPPFLAGS) $(CXXFLAGS) $<
	@echo "\n<<---------------------------------------------------------------------------->>\n"

# Links the object files into the specified executable name.
$(EXEC):$(OBJS)
	@echo "\n"
	@echo Linking executable: $(EXEC)
	@echo "<<---------------------------------------------------------------------------->>\n"
	$(CXX) -o $(EXEC) $(CPPFLAGS) $(CXXFLAGS) $(LDFLAGS) $(OBJS)
	@echo "\n<<---------------------------------------------------------------------------->>\n"

