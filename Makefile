#
# Copyright 2005 The Apache Software Foundation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#
# Note: This makefile depends on 4 environment variables to funtion correctly:
# a) JAVA_HOME
# b) OS_NAME
# c) OS_ARCH
# d) LIBHDFS_BUILD_DIR
# All these are passed by build.xml.
#

#SG: I made some modifications



CC = gcc
LD = gcc
##
###BEFORE running make, be sure to run
#/villa/bin/swig -Wall  -DSWIGWORDLENGTH64  -python pyhdfs.swig
#SG: The following flags have been changed from original.
#Note this has to be added to your .bashrc:
#export CLASSPATH=/home/sguha/villa/jdk1.6/lib:/home/sguha/hadoop-0.1/hadoop-0.14.2-core.jar:/home/sguha/hadoop-0.1/hadoop-0.14.2-examples.jar:/home/sguha/hadoop-0.1/hadoop-0.14.2-test.jar:/home/sguha/hadoop-0.1/lib/commons-logging-1.0.4.jar:/home/sguha/hadoop-0.1/lib/commons-logging-api-1.0.4.jar:/home/sguha/hadoop-0.1/lib/log4j-1.2.13.jar:
#export LD_LIBRARY_PATH=$HOME/$PLACE/lib:$HOME/$PLACE/usr/lib:$HOME/$PLACE/jre/lib/amd64/server/:$LD_LIBRARY_PATH
#export LD_RUN_PATH=$HOME/$PLACE/lib:$HOME/$PLACE/usr/lib:$HOME/$PLACE/jre/lib/amd64/server/:$LD_RUN_PATH:~/hadoop-0.1/src/c++/libhdfs/build
#PYTHONPATH=$PYTHONPATH:.:~/hadoop-0.1/src/c++/libhdfs/build
#Basically, the OS needs to know where the libs (invoked pyhdfs) are kept.
#Python needs to know where to find modules, so provide custom paths here.


#Placed my copy of LIBHDFS_BUILD_DIR since i am not building this as part of the tree.
#I added locations of the java libjvm.so and jni.h in LDFLAGS and CPPFLAGS
#Also note the rpath for libhdfs and for the libjvm,compiling on OSX is soo much nicer
#-m64 should be -m32 for 32 bit machines
#i've include python libs required in pyhdfs_wrap.c
LIBHDFS_BUILD_DIR=../hadoop-client/libhdfs/build
CFLAGS =  -g -Wall -O2 -fPIC
LDFLAGS = -L$(JAVA_HOME)/jre/lib/$(OS_ARCH)/server  -L$(JAVA_HOME)/jre/lib/amd64/server -ljvm -shared -m64 -Wl,-x -Wl,--rpath -Wl,$(LIBHDFS_BUILD_DIR)\
	-Wl,--rpath -Wl,$(JAVA_HOME)/jre/lib/amd64/server 
PLATFORM = $(shell echo $$OS_NAME | tr [A-Z] [a-z])
CPPFLAGS = -m64 -I$(JAVA_HOME)/include -I$(JAVA_HOME)/include/$(PLATFORM) -I$(JAVA_HOME)/include/linux -I/home/work/opdir/software/python2.6/include/python2.5 -I/home/work/opdir/software/python2.6/lib/python2.5
#SG: I added this variable
SHLIB_VERSION = 1

###Some issues on functions
###This is not the right place
###hdfsConnect("Default",0) does not read fs.default.name... instead writing to local filesytem.If provided with ip and host (from the logs) it works

LIB_NAME = hdfs
SO_NAME = lib$(LIB_NAME).so
SO_TARGET = $(LIBHDFS_BUILD_DIR)/$(SO_NAME).$(SHLIB_VERSION)
SO = $(LIBHDFS_BUILD_DIR)/$(SO_NAME)


LIB_NAME = hdfs
SO_TARGET = $(LIBHDFS_BUILD_DIR)/lib$(LIB_NAME).so.$(SHLIB_VERSION)
SO = $(LIBHDFS_BUILD_DIR)/lib$(LIB_NAME).so
ECH = echo

RM = rm -rf
LINK = ln -sf
DOXYGEN = doxygen


####
# Add the pyhdfs_wrap.c file only when read 
# Note, once this file has been added, hdfs_read/write/test will not compile
#### pyhdfs_wrap.c 
CSRC = hdfs.c hdfsJniHelper.c  pyhdfs_wrap.c
# pyhdfs_wrap.c


COBJS = $(addprefix $(LIBHDFS_BUILD_DIR)/,$(patsubst %,%.o,$(basename $(CSRC))))

HDFS_TEST = $(LIBHDFS_BUILD_DIR)/hdfs_test
HDFS_READ_TEST = $(LIBHDFS_BUILD_DIR)/hdfs_read
HDFS_WRITE_TEST = $(LIBHDFS_BUILD_DIR)/hdfs_write

all: $(SO_TARGET)  $(HDFS_TEST) $(HDFS_READ_TEST) $(HDFS_WRITE_TEST)

$(SO_TARGET): $(COBJS)
	$(LD) $(LDFLAGS) -o $(SO_TARGET) -Wl,-soname,$(SO_TARGET) $(COBJS) \
	&& $(LINK) $(SO_TARGET) $(SO)	\
	&& ln -s $(SO_TARGET) $(LIBHDFS_BUILD_DIR)/_pyhdfs.so

$(LIBHDFS_BUILD_DIR)/%.o: %.c
	$(CC) $(CFLAGS) $(CPPFLAGS) -c $< -o $@

$(HDFS_TEST): hdfs_test.c
	$(CC) $(CPPFLAGS) $< -L$(LIBHDFS_BUILD_DIR) -l$(LIB_NAME) -o $@

$(HDFS_READ_TEST): hdfs_read.c
	$(CC) $(CPPFLAGS) $< -Wl,-rpath,. -L$(LIBHDFS_BUILD_DIR) -l$(LIB_NAME) -o $@ 

$(HDFS_WRITE_TEST): hdfs_write.c
	$(CC) $(CPPFLAGS) $< -Wl,-rpath,. -L$(LIBHDFS_BUILD_DIR) -l$(LIB_NAME) -o $@

clean:
	$(RM) $(LIBHDFS_BUILD_DIR)/* 

doc:
	$(DOXYGEN) docs/Doxyfile

test: $(HDFS_TEST)
	./tests/test-libhdfs.sh	

# vim: sw=4: ts=4: noet
