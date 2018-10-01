# Makefile-Template
This is a Makefile template for C/C++ projects. It will automatically find any source files in your working directory and any subdirectories.

# Targets
- **all**: This will compile and link all source files in your project into an executable (the name of the executable can be specified in 
the EXEC variable within the Makefile. The 'all' target can be called by typing either 'make all' or simply 'make'.

- **clean**: This will delete the executable, any existing object files, and anything specified in the JUNK variable within the Makefile.

- **test**: This will compile and run your project. A full execution transcript (generated using the 'script' utility) will be saved to 
a file ('test.out' by default) in your working directory.

- **init**: This is mainly for internal use. It creates the hidden folders '.make' '.versions', and '.objs' if they do not exist. These directories are dependencies of 'all', so they will be made upon first build.

- **update**: This will pull down the latest updates from the master branch of the GitHub source repository

- **snapshot**: This creates a Gzipped tarball of the entire project (includes all subdirectories) and stores the tarball in the .versions folder.


