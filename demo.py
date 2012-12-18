#! /usr/bin/env python
#  -*- coding: utf-8 -*-
#  Author : vbarter
#  Mail   : yzcaijunjie@gmail.com


"""

"""

import hadoop
import gc

__revision__ = '0.1'


if __name__ == "__main__" :

    
    fs = hadoop.HadoopDFS("username","password","hadoop ugi",54310)
    print fs.getWorkingDirectory()
    #print fs.setWorkingDirectory("/user/log")
    #print server.getWorkingDirectory()
    #server.setWorkingDirectory("/user/ns-lsp/logs/cjj")
    #print fs.listDirectory("/user/ns-lsp/logs")
    #file = fs.getPathInfo("/user/qa")
    #print file.mLastMod,type(file.mLastMod)
    ##server.setReplication("/user/ns-lsp/logs/cjj/a",3)
    #file = server.getPathInfo("/user/ns-lsp/logs/cjj/a")
    #print file.mReplication
    #server.copy("/user/ns-lsp/logs/cjj","/user/ns-lsp/logs/cjj_new")
    #server.move("/user/ns-lsp/logs/cjj","/user/ns-lsp/logs/log06/")
    #server.delete("/user/ns-lsp/logs/cjj_new")
    #server.rename("/user/ns-lsp/logs/cjj","/user/ns-lsp/logs/cjj1111")
    #open file
    #data = "hello world"
    #a = hadoop.HadoopFile(fs,'/user/ns-lsp/logs/cjj/a',True)
    ##a.write(data)
    #print a.read().strip()
    #a.seek(2)
    #print a.read().strip()
    #print a.tell()
    #print a.available()
    #print a.getDefaultBlockSize()
    #print server.getHosts("/user/ns-lsp/logs/cjj/a",0,1)
   # data1 = "Hello\n"
   # data2 = "baidu\n"
   # fs = hadoop.HadoopDFS("username","password","hadoop ugi",54310)
   # fh = hadoop.HadoopFile(fs,'/user/ns-lsp/logs/cjj/a',False)
   # ret = fh.write(data1)
   # fh.close()
   # fh = hadoop.HadoopFile(fs,'/user/ns-lsp/logs/cjj/a',True)  
   # print "start... : ", fh.read()
   # fh.close()
   # fh = hadoop.HadoopFile(fs,'/user/ns-lsp/logs/cjj/a',False)
   # size = fh.tell()
   # fh.seek(size)
   # fh.write(data2)
   # fh.close()
   # fh = hadoop.HadoopFile(fs,'/user/ns-lsp/logs/cjj/a',True)
   # print "end... : ",fh.read()
    #fh.close()
    fs.disconnect()

    gc.collect()












    
    
