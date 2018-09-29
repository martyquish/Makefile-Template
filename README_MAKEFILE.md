# Makefile-Template
This is a Makefile template for C/C++ projects. It will automatically find any source files in your working directory and any subdirectories.

# Targets
- **all**: This will compile and link all source files in your project into an executable (the name of the executable can be specified in 
the EXEC variable within the Makefile. The 'all' target can be called by typing either 'make all' or simply 'make'.

- **clean**: This will delete the executable, any existing object files, and anything specified in the JUNK variable within the Makefile.

- **test**: This will compile and run your project. A full execution transcript (generated using the 'script' utility) will be saved to 
a file ('test.out' by default) in your working directory.

- **init**: This is mainly for internal use. It creates the hidden folders '.make' and '.objs' if they do not exist. It is a dependency of all, so these folders will be created automatically if make all is called.



