#!/bin/sh


/usr/bin/swig -Wall  -DSWIGWORDLENGTH64  -python pyhdfs.swig
make clean
make
cp demo.py hadoop.py pyhdfs.py build/
