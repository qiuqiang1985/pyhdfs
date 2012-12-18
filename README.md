pyhdfs是什么?
------------------------------------

pyhdfs是对libhdfs的python封装库. 它提供了一些常用方法来处理HDFS上的文件和目录, 比如读写文件, 枚举目录文件, 显示HDFS可用空间, 显示文件的复制块数等

pyhdfs和libhdfs的关系
-----------------------------------

libhdfs 是HDFS的底层C函数库, 由hadoop官方提供, pyhdfs使用swig技术, 对libhdfs提供的绝大多数函数进行了封装, 目的是提供更简单的调用方式.


为什么需要pyhdfs?
------------------------------------------

hadoop 集群提供我们计算和存储, 计算基于map/reduce模式, 存储基于HDFS, 所有的文件都存储在HDFS中, 虽然有HDFS Shell可以简单访问HDFS的文件,其灵活性不如访问本地文件系统. 比如过滤一些具有日期格式的文件名,并把他们归类压缩打包, 在HDFS上的某文件中更改某行内容等等, 光靠HDFS Shell就显得不方便了. 本文将介绍另外一种方法, 不需要挂载VFS, 通过脚本调用HDFS底层接口, 直接访问HDFS上的文件. 这就是pyhdfs的功能.

如何获取安装?
------------------------

* git clone https://github.com/vbarter/pyhdfs.git

* 先编译安装swig, 最新版本是2.0.9

* 可不安装pcre（perl的正则表达库）
```
./configure --prefix=/home/work/opdir/software/swig --without-pcre
```

* 修改pyhdfs下的Makefile
```
50行，LIBHDFS_BUILD_DIR 修改为发布地址
55行，python依赖修改
```

* 执行compile.sh

pyhdfs和libhdfs的使用区别
-----------------------------------------

为了说明pyhdfs和libhdfs的难易区别, 下面请看一个列子,两种方法实现读取一个目录下所有的文件名信息.

libhdfs:

```
    #include "hdfs.h"
     
    int main(int argc, char **argv) {
          dfsFS fs = hdfsConnectAsUser("hadoop ugi",64310,"username","password");

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
```

pyhdfs:

```

     import hadoop

     if __name__ == '__main__':
         fs = hadoop.HadoopDFS("username","password","hadoop ugi",64310)
         ds = fs.listDirectory("/user/ns-lsp/logs")
         for i in ds:
             print i.mName
         fs.disconnect()
```

从上看出, pyhdfs比起libhdfs使用更加简单,  也许有人会说, 利用hadoop fs -ls /user/ns-lsp/logs 同样可以显示出所有的文件,不是更加简单么? 但是如果我要在某些特定文件比如20090630的文件中写入"finish"字符串, 就比较麻烦了.


pyhdfs的使用说明
-----------------------------

下面,对pyhdfs中提供的所有方法进行示例说明, pyhdfs模块主要包含了两个类,.
一个是HadoopDFS, 提供了对HDFS的访问处理函数, 包括:

* connect(): 连接函数
* disconnect(): 断开连接
* getCapacity(): 取得文件系统的容量
* getUsed(): 取得当前文件系统的文件总大小
* getWorkingDirectory(): 获得当前工作目录
* setWorkingDirectory(): 设置当前工作目录
* createDirectory(): 创建一个目录
* copy(): 拷贝一个文件/目录
* move(): 移动一个文件/目录
* delete(): 删除一个文件/目录
* rename(): 重命名一个文件/目录
* listDirectory(): 显示目录下的所有文件/目录
* pathExists(): 判断目录是否存在
* getDefaultBlockSize(): 获得默认文件块大小.
* chmod(): 改变文件/目录权限
* chown(): 设置文件/目录属主
* getHosts(): 获得当前块所在的具体服务器名
* getPathInfo(): 获得文件/路径信息
* setReplication(): 设置文件/路径的复制数


另一个是HadoopFile, 提供了对HDFS中文件的访问处理函数. 包括：

* __init__(): 初始化一个文件，并打开
* close(): 关闭一个文件
* read(): 从文件中读取数据
* readPos(): 从文件的指定位置读取len长度数据
* write(): 写数据到文件
* flush(): 输出数据
* seek(): 偏移到文件的指定位置
* tell(): 获得当前偏移位置
* available(): 获取当前文件可读字节数

下面分别介绍:

###如何连接hadoop集群？###


```
    fs = hadoop.HadoopDFS("username","password","ugi",64310)
    fs.disconnect()
```

###如何获取当前工作目录?###


```
    fs = hadoop.HadoopDFS("username","password","ugi",64310)
    print fs.getWorkingDirectory()
    fs.disconnect()
```

###如何更改当前工作目录？###


```
    fs = hadoop.HadoopDFS("username","password","ugi",64310)
    print fs.setWorkingDirectory("/user/ns-lsp/logs")
    fs.disconnect()
```

如果目录不存在setWorkingDirectory()返回-1,如果执行成功，返回0

###如何判断某个文件/目录是否存在？###

```
    fs = hadoop.HadoopDFS("username","password","ugi",64310)
    print fs.pathExists("/user/ns-lsp/logs")
    fs.disconnect()
```

文件/目录存在，返回0，如果不存在，返回-1


###如何创建一个目录?###

```
    fs = hadoop.HadoopDFS("username","password","ugi",64310)
    print fs.createDirectory("/user/ns-lsp/logs/cjj")
    fs.disconnect()
```

如果目录已经存在，则返回-1，如果目录创建成功，返回0


###如何获得当前默认块大小？###

```
    fs = hadoop.HadoopDFS("username","password","ugi",64310)
    print fs.getDefaultBlockSize()
    fs.disconnect()
```

###如何获得当期目录下的文件/目录？###

```
    fs = hadoop.HadoopDFS("username","password","ugi",64310)
    print fs.listDirectory("/user/ns-lsp/logs")
    fs.disconnect()
```

```
   $ python listdir.py
   [{'mName': 'hdfs://ugi:64310/user/ns-lsp/logs/aaaaa', 'mGroup': 'ns-lsp', 
    'mSize': 0, 'mOwner': 'ns-lsp', 'mReplication': 1, 'mBlockSize': 0, 'mKind': 'Directory', 'mLastAccess': 0, 
    'mLastMod': 1245998859}, {'mName': 'hdfs://jx-spi-test9.jx.baidu.com:64310/user/ns-lsp/logs/baike', 
    'mGroup': 'ns-lsp', 'mSize': 0, 'mOwner': 'ns-lsp', 'mReplication': 1, 'mBlockSize': 0, 'mKind': 'Directory', 
    'mLastAccess': 0, 'mLastMod': 1246010093}, {'mName': 'hdfs://jx-spi-test9.jx.baidu.com:64310/user/ns-lsp/logs/cjj', 
    'mGroup': 'ns-lsp', 'mSize': 0, 'mOwner': 'ns-lsp', 'mReplication': 1, 'mBlockSize': 0, 'mKind': 'Directory', 
    'mLastAccess': 0, 'mLastMod': 1246335743}, {'mName': 'hdfs://jx-spi-test9.jx.baidu.com:64310/user/ns-lsp/logs/cjj1', 
    'mGroup': 'ns-lsp', 'mSize': 0, 'mOwner': 'ns-lsp', 'mReplication': 1, 'mBlockSize': 0, 'mKind': 'Directory', 
    'mLastAccess': 0, 'mLastMod': 1246335136}, {'mName': 'hdfs://jx-spi-test9.jx.baidu.com:64310/user/ns-lsp/logs/image', 
    'mGroup': 'ns-lsp', 'mSize': 0, 'mOwner': 'ns-lsp', 'mReplication': 1, 'mBlockSize': 0, 'mKind': 'Directory', 
    'mLastAccess': 0, 'mLastMod': 1245999023}, {'mName': 'hdfs://jx-spi-test9.jx.baidu.com:64310/user/ns-lsp/logs/maochang', 
    'mGroup': 'ns-lsp', 'mSize': 0, 'mOwner': 'ns-lsp', 'mReplication': 1, 'mBlockSize': 0, 'mKind': 'Directory', 
    'mLastAccess': 0, 'mLastMod': 1246276821}]
```

listDirectory返回的是一个含有字典元素的列表，每个字典包含如见键：

* mName: 文件/目录名
* mGroup: 组名
* mSize: 若是目录，大小为0，若为文件，大小是实际大小。
* mOwner: 所用者
* mReplication: 复制份数
* mBlockSize: 块大小，若是目录，大小为0
* mKind: 类型，Directory代表目录，File代表文件
* mLastAccess: 最近访问时间，若是目录，显示0
* mLastMod: 最近修改时间

###如何获得当前HDFS的总容量?###

```
    fs = hadoop.HadoopDFS("username","password","ugi",64310)
    print fs.getCapacity()
    fs.disconnect()
```

```
   $ python getcapacity.py
   11685016256512
```

返回的是字节单位，即总10T空间。

###如何获得当前文件的总大小?###


```
    fs = hadoop.HadoopDFS("username","password","ugi",64310)
    print fs.getUsed()
    fs.disconnect()
```

###如何拷贝一个文件/目录?###

同一HDFS内拷贝文件：

```
    fs = hadoop.HadoopDFS("username","password","ugi",64310)
    print fs.copy("/user/ns-lsp/logs/cjj","/user/ns-lsp/logs/cjj_new")
    fs.disconnect()
```

不同HDFS之间拷贝文件：

```
    target_fs = hadoop.HadoopDFS("username","password","ugi",64310)
    fs = hadoop.HadoopDFS("ns-lsp","lsptest","jx-spi-test9.jx.baidu.com",64310)
    print fs.copy("/user/ns-lsp/logs/cjj","/user/ns-lsp/logs/cjj_new",target_fs)
    fs.disconnect()
```

###如何移动一个文件/目录?###


同一HDFS内移动文件：

```
    fs = hadoop.HadoopDFS("username","password","ugi",64310)
    print fs.move("/user/ns-lsp/logs/cjj","/user/ns-lsp/logs/cjj_new")
    fs.disconnect()
```

不同HDFS之间移动文件：

```
    target_fs = hadoop.HadoopDFS("username","password","ugi",64310)
    fs = hadoop.HadoopDFS("username","password","ugi",64310)
    print fs.move("/user/ns-lsp/logs/cjj","/user/ns-lsp/logs/cjj_new",target_fs)
    fs.disconnect()
```

###如何删除一个文件/目录?###

```
    fs = hadoop.HadoopDFS("username","password","ugi",64310)
    print fs.delete("/user/ns-lsp/logs/cjj_new")
    fs.disconnect()
```

###如何重命名一个文件/目录?###


```
    fs = hadoop.HadoopDFS("username","password","ugi",64310)
    print fs.rename("/user/ns-lsp/logs/cjj","/user/ns-lsp/logs/cjj1")
    fs.disconnect()
```

###如何修改一个文件/目录的权限?###


```
    fs = hadoop.HadoopDFS("username","password","ugi",64310)
    print fs.chmod("/user/ns-lsp/logs/cjj",7)
    fs.disconnect()
```

###如何文件块所在的服务器名?###


有时我们需要查找某些文件块所在的服务器名是什么，可以如下使用:


```
    fs = hadoop.HadoopDFS("username","password","ugi",64310)
    print fs.getHosts("/user/ns-lsp/logs/cjj/a",0,1)
    fs.disconnect()
```

返回包含服务器名的列表.

```
   $ python gethosts.py
   ['jx-spi-test3.jx.baidu.com']
```

###如何获取一个文件/目录的信息?###


```
    fs = hadoop.HadoopDFS("username","password","ugi",64310)
    pathinfo = fs.getPathInfo("/user/ns-lsp/logs/cjj")
    fs.disconnect()
```

getPathInfo()返回一个hdfsFileInfo类。

###如何指定文件的备份数?###


```
    fs = hadoop.HadoopDFS("username","password","ugi",64310)
    print fs.setReplication("/user/ns-lsp/logs/cjj/a",3)
    fs.disconnect()
```

###如何打开一个文件，并读取数据?###


要操作文件，需要创建一个HadoopFile对象，并利用read()方法读取数据.

```
    fs = hadoop.HadoopDFS("username","password","ugi",64310)
    fh = hadoop.HadoopFile(fs,'/user/ns-lsp/logs/cjj/a')
    print fh.read()
    fh.close()
    fs.disconnect()
```

默认read()不带参数的话，读取32KB的数据，如果需要读1MB的数据，可以read(1024*1024), 如果需要从指定位置读取len长度的数据，可以如下：

```
    fs = hadoop.HadoopDFS("username","password","ugi",64310)
    fh = hadoop.HadoopFile(fs,'/user/ns-lsp/logs/cjj/a')
    print fh.readPos(3,1024*1024)
    fh.close()
    fs.disconnect()
```

###如何向文件中写入数据?###


使用write()方法。

```
    data = "Hello World\n"
    fs = hadoop.HadoopDFS("username","password","ugi",64310)
    fh = hadoop.HadoopFile(fs,'/user/ns-lsp/logs/cjj/a',False)
    print fh.write(data)
    fh.close()
    fs.disconnect()
```

* 注意
```
    write()方法使用前，确保HadoopFile的初始化方法的第二个参数是False, 代表文件打开模式，支持写.
```

###如何获得当前文件的字节数?###


```
    fs = hadoop.HadoopDFS("username","password","ugi",64310)
    fh = hadoop.HadoopFile(fs,'/user/ns-lsp/logs/cjj/a',False)
    print fh.available()
    fh.close()
    fs.disconnect()
```

```
   $ python getavailable.py
   2144090985
```

###如何在文件中偏移地址?###


接下来，我们看一个简单例子，在一个空文件中输入"hello World"，打印输出"World"，


```
    data = "Hello World\n"
    fs = hadoop.HadoopDFS("username","password","ugi",64310)
    fh = hadoop.HadoopFile(fs,'/user/ns-lsp/logs/cjj/a',False)
    ret = fh.write(data)
    fh.close()
    fh = hadoop.HadoopFile(fs,'/user/ns-lsp/logs/cjj/a',True)
    fh.seek(6)  
    print fh.read()
    fh.close()
    fs.disconnect()
```

```
   $ python wrexample.py
   World
```

由于HDFS上读写文件需要使用不同的参数模式，所以需要分两步进行。HadoopFile第二各参数是False时可以写操作，为True是可以进行读操作,更多信息请参考函数文档。


如何反馈问题?
-------------------

如果您遇到任何使用问题，或者是任何改进建议，可以发邮件给 yzcaijunjie@gmail.com
