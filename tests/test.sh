#!/bin/bash

ACCOUNT=`whoami`


# Notice:     set it first
HADOOP_HOME=/home/${ACCOUNT}/hadoop-v2/hadoop


export JAVA_HOME=${HADOOP_HOME}/../java6

CLASSPATH=${HADOOP_HOME}/conf
CLASSPATH=${CLASSPATH}:${JAVA_HOME}/lib/tools.jar
CLASSPATH=${CLASSPATH}:${HADOOP_HOME}
CLASSPATH=${CLASSPATH}:${HADOOP_HOME}/hadoop-2-core.jar
CLASSPATH=${CLASSPATH}:${HADOOP_HOME}/lib/commons-cli-2.0-SNAPSHOT.jar
CLASSPATH=${CLASSPATH}:${HADOOP_HOME}/lib/commons-codec-1.3.jar
CLASSPATH=${CLASSPATH}:${HADOOP_HOME}/lib/commons-httpclient-3.0.1.jar
CLASSPATH=${CLASSPATH}:${HADOOP_HOME}/lib/commons-logging-1.0.4.jar
CLASSPATH=${CLASSPATH}:${HADOOP_HOME}/lib/commons-logging-api-1.0.4.jar
CLASSPATH=${CLASSPATH}:${HADOOP_HOME}/lib/commons-net-1.4.1.jar
CLASSPATH=${CLASSPATH}:${HADOOP_HOME}/lib/hadoop-2-fairscheduler.jar
CLASSPATH=${CLASSPATH}:${HADOOP_HOME}/lib/hsqldb-1.8.0.10.jar
CLASSPATH=${CLASSPATH}:${HADOOP_HOME}/lib/jets3t-0.6.1.jar
CLASSPATH=${CLASSPATH}:${HADOOP_HOME}/lib/jetty-5.1.4.jar
CLASSPATH=${CLASSPATH}:${HADOOP_HOME}/lib/junit-3.8.1.jar
CLASSPATH=${CLASSPATH}:${HADOOP_HOME}/lib/kfs-0.2.2.jar
CLASSPATH=${CLASSPATH}:${HADOOP_HOME}/lib/log4j-1.2.15.jar
CLASSPATH=${CLASSPATH}:${HADOOP_HOME}/lib/oro-2.0.8.jar
CLASSPATH=${CLASSPATH}:${HADOOP_HOME}/lib/servlet-api.jar
CLASSPATH=${CLASSPATH}:${HADOOP_HOME}/lib/slf4j-api-1.4.3.jar
CLASSPATH=${CLASSPATH}:${HADOOP_HOME}/lib/slf4j-log4j12-1.4.3.jar
CLASSPATH=${CLASSPATH}:${HADOOP_HOME}/lib/xmlenc-0.52.jar
CLASSPATH=${CLASSPATH}:${HADOOP_HOME}/lib/jetty-ext/commons-el.jar
CLASSPATH=${CLASSPATH}:${HADOOP_HOME}/lib/jetty-ext/jasper-compiler.jar
CLASSPATH=${CLASSPATH}:${HADOOP_HOME}/lib/jetty-ext/jasper-runtime.jar
export CLASSPATH=${CLASSPATH}:${HADOOP_HOME}/lib/jetty-ext/jsp-api.jar

export LD_PRELOAD=./libhdfs.so
#export LD_PRELOAD=./libmapred.so

export HADOOP_LIB_DIR=$HADOOP_HOME/lib

export LD_LIBRARY_PATH=${JAVA_HOME}/jre/lib/amd64:${JAVA_HOME}/jre/lib/amd64/native_threads:${JAVA_HOME}/jre/lib/amd64/server

#./hdfs_write ./test 100 1000
#./hdfs_test
./mapred_test
