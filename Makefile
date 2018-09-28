#---------- Configure project settings -----------------


# Mainly used when exporting/backing up
PROJNAME = maketest
# Name of executable for 'make all' to build
EXEC = go
# The names of the source files.
SRCS = maketester.cc	
# All object files necessary to build the above executablee files for the project
OBJS = maketester.o
# Specify any intermediary files which should not be automatically cleaned during implicit chaining.
.PRECIOUS =
# Specify any files which 'make clean' should remove.
JUNK = *.o *~
# Specify a location for 'make backup' to backup your files.
BACKUPPATH = ~/backups
# Specify a log file to store any automatically suppressed errors (i.e. rm not finding a certain junk file)
LOG = make.log


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
# Program to interpret .l and .lex fileslex settings:
LEX = /bin/flex
# Lex flags
LFLAGS =         

# --------------- Configure YACC/Bison settings --------------

# Program to interpret .y files
YACC = /bin/bison
# Yacc flags
YFLAGS = -dy            

all: $(EXEC)


clean:
	@rm $(JUNK) $(EXEC) 2> $(LOG) || true

# Run this target to compile and test your program at once. It will also save an execution transcript in the file "test.out"
test:
	@echo "Compiling..."
	@make
	@echo "\n<<------------------------ Begin Output ------------------------>>\n\n"
	@script -q -c ./$(EXEC) test.out
	@exit
	@echo "\n\n<<------------------------ End Output ------------------------>>\n"
	@echo "Output saved to 'test.out'\n"

depend: .depend

.depend: $(SRCS)
	rm -rf ./.depend
	$(CXX) $(CPPFLAGS) -MM $^ > ./.depend

include .depend


$(EXEC):$(OBJS)
	$(CXX) -o $(EXEC) $(CPPFLAGS) $(CXXFLAGS) $(LDFLAGS) $(OBJS)

