# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.17

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Disable VCS-based implicit rules.
% : %,v


# Disable VCS-based implicit rules.
% : RCS/%


# Disable VCS-based implicit rules.
% : RCS/%,v


# Disable VCS-based implicit rules.
% : SCCS/s.%


# Disable VCS-based implicit rules.
% : s.%


.SUFFIXES: .hpux_make_needs_suffix_list


# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/local/bin/cmake

# The command to remove a file.
RM = /usr/local/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/yxh/Documents/mars/src

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/yxh/Documents/mars/build

# Include any dependencies generated for this target.
include file_server/CMakeFiles/file_server.dir/depend.make

# Include the progress variables for this target.
include file_server/CMakeFiles/file_server.dir/progress.make

# Include the compile flags for this target's objects.
include file_server/CMakeFiles/file_server.dir/flags.make

file_server/CMakeFiles/file_server.dir/src/file_server.cpp.o: file_server/CMakeFiles/file_server.dir/flags.make
file_server/CMakeFiles/file_server.dir/src/file_server.cpp.o: /home/yxh/Documents/mars/src/file_server/src/file_server.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/yxh/Documents/mars/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object file_server/CMakeFiles/file_server.dir/src/file_server.cpp.o"
	cd /home/yxh/Documents/mars/build/file_server && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/file_server.dir/src/file_server.cpp.o -c /home/yxh/Documents/mars/src/file_server/src/file_server.cpp

file_server/CMakeFiles/file_server.dir/src/file_server.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/file_server.dir/src/file_server.cpp.i"
	cd /home/yxh/Documents/mars/build/file_server && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/yxh/Documents/mars/src/file_server/src/file_server.cpp > CMakeFiles/file_server.dir/src/file_server.cpp.i

file_server/CMakeFiles/file_server.dir/src/file_server.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/file_server.dir/src/file_server.cpp.s"
	cd /home/yxh/Documents/mars/build/file_server && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/yxh/Documents/mars/src/file_server/src/file_server.cpp -o CMakeFiles/file_server.dir/src/file_server.cpp.s

# Object files for target file_server
file_server_OBJECTS = \
"CMakeFiles/file_server.dir/src/file_server.cpp.o"

# External object files for target file_server
file_server_EXTERNAL_OBJECTS =

/home/yxh/Documents/mars/devel/lib/file_server/file_server: file_server/CMakeFiles/file_server.dir/src/file_server.cpp.o
/home/yxh/Documents/mars/devel/lib/file_server/file_server: file_server/CMakeFiles/file_server.dir/build.make
/home/yxh/Documents/mars/devel/lib/file_server/file_server: /opt/ros/melodic/lib/libroscpp.so
/home/yxh/Documents/mars/devel/lib/file_server/file_server: /opt/ros/melodic/lib/librosconsole.so
/home/yxh/Documents/mars/devel/lib/file_server/file_server: /opt/ros/melodic/lib/librosconsole_log4cxx.so
/home/yxh/Documents/mars/devel/lib/file_server/file_server: /opt/ros/melodic/lib/librosconsole_backend_interface.so
/home/yxh/Documents/mars/devel/lib/file_server/file_server: /usr/lib/x86_64-linux-gnu/liblog4cxx.so
/home/yxh/Documents/mars/devel/lib/file_server/file_server: /usr/lib/x86_64-linux-gnu/libboost_regex.so
/home/yxh/Documents/mars/devel/lib/file_server/file_server: /opt/ros/melodic/lib/libxmlrpcpp.so
/home/yxh/Documents/mars/devel/lib/file_server/file_server: /opt/ros/melodic/lib/libroscpp_serialization.so
/home/yxh/Documents/mars/devel/lib/file_server/file_server: /opt/ros/melodic/lib/librostime.so
/home/yxh/Documents/mars/devel/lib/file_server/file_server: /opt/ros/melodic/lib/libcpp_common.so
/home/yxh/Documents/mars/devel/lib/file_server/file_server: /usr/lib/x86_64-linux-gnu/libboost_thread.so
/home/yxh/Documents/mars/devel/lib/file_server/file_server: /usr/lib/x86_64-linux-gnu/libboost_chrono.so
/home/yxh/Documents/mars/devel/lib/file_server/file_server: /usr/lib/x86_64-linux-gnu/libboost_date_time.so
/home/yxh/Documents/mars/devel/lib/file_server/file_server: /usr/lib/x86_64-linux-gnu/libboost_atomic.so
/home/yxh/Documents/mars/devel/lib/file_server/file_server: /usr/lib/x86_64-linux-gnu/libpthread.so
/home/yxh/Documents/mars/devel/lib/file_server/file_server: /usr/lib/x86_64-linux-gnu/libconsole_bridge.so.0.4
/home/yxh/Documents/mars/devel/lib/file_server/file_server: /opt/ros/melodic/lib/libroslib.so
/home/yxh/Documents/mars/devel/lib/file_server/file_server: /opt/ros/melodic/lib/librospack.so
/home/yxh/Documents/mars/devel/lib/file_server/file_server: /usr/lib/x86_64-linux-gnu/libpython2.7.so
/home/yxh/Documents/mars/devel/lib/file_server/file_server: /usr/lib/x86_64-linux-gnu/libboost_filesystem.so
/home/yxh/Documents/mars/devel/lib/file_server/file_server: /usr/lib/x86_64-linux-gnu/libboost_program_options.so
/home/yxh/Documents/mars/devel/lib/file_server/file_server: /usr/lib/x86_64-linux-gnu/libboost_system.so
/home/yxh/Documents/mars/devel/lib/file_server/file_server: /usr/lib/x86_64-linux-gnu/libtinyxml2.so
/home/yxh/Documents/mars/devel/lib/file_server/file_server: file_server/CMakeFiles/file_server.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/yxh/Documents/mars/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable /home/yxh/Documents/mars/devel/lib/file_server/file_server"
	cd /home/yxh/Documents/mars/build/file_server && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/file_server.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
file_server/CMakeFiles/file_server.dir/build: /home/yxh/Documents/mars/devel/lib/file_server/file_server

.PHONY : file_server/CMakeFiles/file_server.dir/build

file_server/CMakeFiles/file_server.dir/clean:
	cd /home/yxh/Documents/mars/build/file_server && $(CMAKE_COMMAND) -P CMakeFiles/file_server.dir/cmake_clean.cmake
.PHONY : file_server/CMakeFiles/file_server.dir/clean

file_server/CMakeFiles/file_server.dir/depend:
	cd /home/yxh/Documents/mars/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/yxh/Documents/mars/src /home/yxh/Documents/mars/src/file_server /home/yxh/Documents/mars/build /home/yxh/Documents/mars/build/file_server /home/yxh/Documents/mars/build/file_server/CMakeFiles/file_server.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : file_server/CMakeFiles/file_server.dir/depend

