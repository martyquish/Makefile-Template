#---------- Configure project settings -----------------


# Used for any operations requiring the name of the project
PROJNAME = maketest

# Name of executable for 'make all' to build
EXEC = $(PROJNAME).exe

# The names of the source files.
SRCS := $(shell find . -regextype sed -regex '.*\.\(cc\?\|cpp\)' | tr '\n' ' ')

# All object files necessary to build the above executablee files for the project
OBJS := $(shell echo $(SRCS) | sed 's/\.\(cc\?\|cpp\)/.o/g')

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
	@rm -r $(JUNK) $(OBJS) $(EXEC) 2> $(LOG) || true

# Run this target to compile and test your program at once. It will also save an execution transcript in the file "test.out"
test:
	@echo "Compiling..."
	@make
	@echo "\n<<------------------------ Begin Output ------------------------>>\n\n"
	@script -q -c ./$(EXEC) test.out
	@exit
	@echo "\n\n<<------------------------ End Output ------------------------>>\n"
	@echo "Output saved to 'test.out'\n"


list:
	@echo "--- SOURCE LIST ---"
	@echo $(SRCS)
	@echo "--- OBJECT LIST ---"
	@echo $(OBJS)



depend: .depend

.depend: $(SRCS)
	@echo Updating header dependencies...
	@rm -rf ./.depend
	@$(CXX) $(CPPFLAGS) -MM $^ > ./.depend

include .depend



# Links the object files into the specified executable name.
$(EXEC):$(OBJS)
	@echo Linking executable: $(EXEC)
	$(CXX) -o $(EXEC) $(CPPFLAGS) $(CXXFLAGS) $(LDFLAGS) $(OBJS)

