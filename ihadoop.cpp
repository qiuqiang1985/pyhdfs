/*
 * =====================================================================================
 *
 *       Filename:  ihadoop.cpp
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  09/25/2010 02:33:12 PM CST
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:   (), 
 *        Company:  
 *
 * =====================================================================================
 */

#include "hdfs.h"
#include <iostream>
#include <string>

using namespace std;

int main(int argc,char** argv)
{
	dfsFS fs = hdfsConnectAsUser("hadoop ugi",54310,"username","password");

      hdfsFileInfo *fileList = 0;
      int numEntries = 0;
      if((fileList = hdfsListDirectory(fs, "/user/ns-lsp/logs/", &numEntries)) != NULL) {
           int i = 0;
           for(i=0; i < numEntries; ++i) {
                     printf("Name: %s, ", fileList[i].mName);
           }
           } else {
                if (errno) {
                     totalResult++;
                     printf("waah! hdfsListDirectory - FAILED!\n");
                } else {
                     printf("Empty directory!\n");
                }
           }
      hdfsDisconnect(fs);
}
