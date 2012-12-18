%module pyhdfs
%include <stdint.i>
%include <typemaps.i>

%typemap(in) (char *buffer, size_t bufferSize) {
	//For the working directory
	if (!PyInt_Check($input)) {
		PyErr_SetString(PyExc_ValueError, "Expecting an integer");
		return NULL;
	}
	$2 = PyInt_AsLong($input);

	if ($2 == -1 && PyErr_Occurred()) {
		PyErr_SetString(PyExc_ValueError, "Positive integer expected");
		return NULL;
	}
	
	$1 = (char *) malloc($2*sizeof(char));
}


%typemap(argout) (int *OUTPUT) {

	int length = *$1;
	PyObject *l = PyList_New(length);
	
	//printf("-->%s\n",result[0].mName);
	//Py_XDECREF($result); /* Blow away any previous result */
	int i;
	for(i=0;i<length;i++)
	{
		PyObject *di = PyDict_New();
		PyObject *mName = PyString_FromString(result[i].mName);
		PyDict_SetItemString(di,"mName",mName);
		//int mSize = result[i].mSize;
		PyObject *mSize = PyInt_FromLong(result[i].mSize);
		PyDict_SetItemString(di,"mSize",mSize);
		//int mReplication = result[i].mReplication;
		PyObject *mReplication = PyInt_FromLong(result[i].mReplication);
		PyDict_SetItemString(di,"mReplication",mReplication);
		//int mBlockSize = result[i].mBlockSize;
		PyObject *mBlockSize = PyInt_FromLong(result[i].mBlockSize);
		PyDict_SetItemString(di,"mBlockSize",mBlockSize);
		//char *mOwner = result[i].mOwner;
		PyObject *mOwner = PyString_FromString(result[i].mOwner);
		PyDict_SetItemString(di,"mOwner",mOwner);
		//char *mGroup = result[i].mGroup;
		PyObject *mGroup = PyString_FromString(result[i].mGroup);
		PyDict_SetItemString(di,"mGroup",mGroup);
		//tTime mLastMod = result[i].mLastMod;
		PyObject *mLastMod = PyInt_FromLong(result[i].mLastMod);
		PyDict_SetItemString(di,"mLastMod",mLastMod);
		//tTime mLastAccess = result[i].mLastAccess;
		PyObject *mLastAccess = PyInt_FromLong(result[i].mLastAccess);
		PyDict_SetItemString(di,"mLastAccess",mLastAccess);
		tObjectKind mKind = result[i].mKind;
		if(mKind=='D')
		{
			
			PyDict_SetItemString(di,"mKind",PyString_FromString("Directory"));
		}else if(mKind=='F')
		{
			PyDict_SetItemString(di,"mKind",PyString_FromString("File"));
		}
		//printf("-->%c\n",mKind);
		
		PyList_SetItem(l,i,di);
		//PyList_SetItem(l,i,$1[i]);
	}
	$result = l;
}

/*
%typemap(out) hdfsFileInfo * {
	

	printf("Hello\n");
	
	PyObject *di = PyDict_New();
	PyObject *mName = PyString_FromString($1.mName);
        PyDict_SetItemString(di,"mName",mName);
        //int mSize = $1.mSize;
        PyObject *mSize = PyInt_FromLong($1.mSize);
        PyDict_SetItemString(di,"mSize",mSize);
        //int mReplication = $1.mReplication;
        PyObject *mReplication = PyInt_FromLong($1.mReplication);
        PyDict_SetItemString(di,"mReplication",mReplication);
        //int mBlockSize = $1.mBlockSize;
        PyObject *mBlockSize = PyInt_FromLong($1.mBlockSize);
        PyDict_SetItemString(di,"mBlockSize",mBlockSize);
        //char *mOwner = $1.mOwner;
        PyObject *mOwner = PyString_FromString($1.mOwner);
        PyDict_SetItemString(di,"mOwner",mOwner);
        //char *mGroup = $1.mGroup;
        PyObject *mGroup = PyString_FromString($1.mGroup);
        PyDict_SetItemString(di,"mGroup",mGroup);
        //tTime mLastMod = $1.mLastMod;
        PyObject *mLastMod = PyInt_FromLong($1.mLastMod);
        PyDict_SetItemString(di,"mLastMod",mLastMod);
        //tTime mLastAccess = $1.mLastAccess;
        PyObject *mLastAccess = PyInt_FromLong($1.mLastAccess);
        PyDict_SetItemString(di,"mLastAccess",mLastAccess);
        tObjectKind mKind =$1.mKind;
        if(mKind=='D')
        {
        	
        	PyDict_SetItemString(di,"mKind",PyString_FromString("Directory"));
        }else if(mKind=='F')
        {
        	PyDict_SetItemString(di,"mKind",PyString_FromString("File"));
        }
        //printf("-->%c\n",mKind);
        
	$result = di;
}
*/




%typemap(out) char *** {
	//int size = sizeof($1);
	if($1)
	{
		int size = sizeof($1),i=0;
                Py_XDECREF($result);
                PyObject *l = PyList_New(0);
                //printf("-->%s\n",$1[1][0]);
                while($1[i]) {
                	int j = 0;
                	while($1[i][j]) {
                		PyObject *name = PyString_FromString($1[i][j]);
                		PyList_Append(l,name);
                		//printf("-->%s\n",$1[i][j]);
                		++j;
                	}
                	++i;
                }
                $result = l;
	} else {
		PyErr_SetString(PyExc_ValueError, "waah! hdfsGetHosts - FAILED!");
		return NULL;
	}
}


%typemap(in) (void *buffer, tSize length) { 
	//for reads
	if (!PyInt_Check($input)) { 
		PyErr_SetString(PyExc_ValueError, "Expecting an integer"); 
		return NULL; 
	} 
	
	$2 = PyInt_AsLong($input); 

	if ($2 < 0) {  
		PyErr_SetString(PyExc_ValueError, "Positive integer expected"); 	
		return NULL; 
	} 
			
	//$1 = (char *) malloc($2*sizeof(char)); 
	$1 = (void *) malloc($2); 
} 


%typemap(argout) (void *buffer,tSize length)  {
	//$result and result are two different variables. result is the real C datatype that was returned
	//by the function. $result is the scripting language object being returned to the interpreter.
	
	Py_XDECREF($result); /* Blow away any previous result */
	if (result < 0) {      /* Check for I/O error */
		free($1);
		PyErr_SetFromErrno(PyExc_IOError);
		return NULL;
	}
	$result = PyString_FromStringAndSize($1,result);
	free($1);
}

%typemap(in) (const void *wbuffer, tSize length) { 
	//for writes
	if (!PyString_Check($input)) { 
		PyErr_SetString(PyExc_ValueError, "Expecting a string"); 
		return NULL; 	
	} 
	$1 = (void *) PyString_AsString($input); 
	$2 = PyString_Size($input); 
	//printf("-->%s:%d\n",$1,$2);
} 

%typemap(in) (short mode) {
	$1 = (short) PyInt_AsLong($input);
}

%{

	#define O_RDONLY 0
	#define O_WRONLY 1
	#define EINTERNAL 255

	
	typedef int32_t   tSize;
	typedef time_t    tTime;
	typedef int64_t   tOffset;
	typedef uint16_t  tPort;
	typedef enum tObjectKind {
		kObjectKindFile = 'F',
		kObjectKindDirectory = 'D',
	} tObjectKind;
	
	/**
	* The C reflection of org.apache.org.hadoop.FileSystem .
	*/
	typedef void* hdfsFS; 

	/**
	* The C equivalent of org.apache.org.hadoop.FSData(Input|Output)Stream . 
	*/
	enum hdfsStreamType
	{
		UNINITIALIZED = 0,
		INPUT = 1,
		OUTPUT = 2,
	};

	/**
	* The 'file-handle' to a file in hdfs.
	*/
	struct hdfsFile_internal {
		void* file;
		enum hdfsStreamType type;
	};
	typedef struct hdfsFile_internal* hdfsFile;

	/**
	* hdfsFileInfo - Information about a file/directory.
	*/
	typedef struct  {
		tObjectKind mKind;   /* file or directory */
		char *mName;         /* the name of the file */
		tTime mLastMod;      /* the last modification time for the file in seconds */
		tOffset mSize;       /* the size of the file in bytes */
		short mReplication;    /* the count of replicas */
		tOffset mBlockSize;  /* the block size for the file */
		char *mOwner;        /* the owner of the file */
		char *mGroup;        /* the group associated with the file */
		short mPermissions;  /* the permissions associated with the file */
		tTime mLastAccess;    /* the last access time for the file in seconds */
	} hdfsFileInfo;
		
	/************************************************  
	*************************************************/
	hdfsFS hdfsConnectAsUser(const char* host, tPort port, const char *user , const char *password);
	int hdfsDisconnect(hdfsFS fs);
	
	tOffset hdfsGetCapacity(hdfsFS fs);
	tOffset hdfsGetUsed(hdfsFS fs);

	int hdfsCopy(hdfsFS srcFS, const char* src, hdfsFS dstFS, const char* dst);
	int hdfsMove(hdfsFS srcFS, const char* src, hdfsFS dstFS, const char* dst);
	int hdfsDelete(hdfsFS fs, const char* path);
	int hdfsRename(hdfsFS fs, const char* oldPath, const char* newPath);
	char* hdfsGetWorkingDirectory(hdfsFS fs, char *buffer, size_t bufferSize);
	int hdfsSetWorkingDirectory(hdfsFS fs, const char* path);
	int hdfsCreateDirectory(hdfsFS fs, const char* path);
	hdfsFileInfo *hdfsListDirectory(hdfsFS fs, const char* path,int *OUTPUT);
	//hdfsFileInfo *hdfsListDirectory(hdfsFS fs, const char* path,int *numEntries);
	hdfsFileInfo *hdfsGetPathInfo(hdfsFS fs, const char* path);
	tOffset hdfsGetDefaultBlockSize(hdfsFS fs);
	int hdfsExists(hdfsFS fs, const char *path);
	int hdfsChmod(hdfsFS fs, const char* path, short mode);
	int hdfsChown(hdfsFS fs, const char* path, const char *owner, const char *group);
	char*** hdfsGetHosts(hdfsFS fs, const char* path,tOffset start, tOffset length);
	int hdfsSetReplication(hdfsFS fs, const char* path, int16_t replication);

	hdfsFile hdfsOpenFile(hdfsFS fs, const char* path, int flags,int bufferSize, short replication, tSize blocksize);
	int hdfsCloseFile(hdfsFS fs, hdfsFile file);
	tSize hdfsRead(hdfsFS fs, hdfsFile file, void* buffer, tSize length);
	tSize hdfsPread(hdfsFS fs, hdfsFile file, tOffset position,void* buffer, tSize length);
	tSize hdfsWrite(hdfsFS fs, hdfsFile file, const void* wbuffer,tSize length);
	int hdfsFlush(hdfsFS fs, hdfsFile file);
	int hdfsAvailable(hdfsFS fs, hdfsFile file);
	int hdfsSeek(hdfsFS fs, hdfsFile file, tOffset desiredPos);
	tOffset hdfsTell(hdfsFS fs, hdfsFile file);
%}

#define O_RDONLY 0
#define O_WRONLY 1
#define EINTERNAL 255
	
typedef int32_t   tSize;
typedef time_t    tTime;
typedef int64_t   tOffset;
typedef uint16_t  tPort;
typedef enum tObjectKind {
	kObjectKindFile = 'F',
	kObjectKindDirectory = 'D',
} tObjectKind;
typedef void* hdfsFS; 
enum hdfsStreamType
{
	UNINITIALIZED = 0,
	INPUT = 1,
	OUTPUT = 2,
};
struct hdfsFile_internal {
	void* file;
	enum hdfsStreamType type;
};
typedef struct hdfsFile_internal* hdfsFile;
typedef struct  {
	tObjectKind mKind;   /* file or directory */
	char *mName;         /* the name of the file */
	tTime mLastMod;      /* the last modification time for the file in seconds */
	tOffset mSize;       /* the size of the file in bytes */
	short mReplication;    /* the count of replicas */
	tOffset mBlockSize;  /* the block size for the file */
	char *mOwner;        /* the owner of the file */
	char *mGroup;        /* the group associated with the file */
	short mPermissions;  /* the permissions associated with the file */
	tTime mLastAccess;    /* the last access time for the file in seconds */
} hdfsFileInfo;

hdfsFS hdfsConnectAsUser(const char* host, tPort port, const char *user , const char *password);
int hdfsDisconnect(hdfsFS fs);

tOffset hdfsGetCapacity(hdfsFS fs);
tOffset hdfsGetUsed(hdfsFS fs);

int hdfsCopy(hdfsFS srcFS, const char* src, hdfsFS dstFS, const char* dst);
int hdfsMove(hdfsFS srcFS, const char* src, hdfsFS dstFS, const char* dst);
int hdfsDelete(hdfsFS fs, const char* path);
int hdfsRename(hdfsFS fs, const char* oldPath, const char* newPath);
char* hdfsGetWorkingDirectory(hdfsFS fs, char *buffer, size_t bufferSize);
int hdfsSetWorkingDirectory(hdfsFS fs, const char* path);
int hdfsCreateDirectory(hdfsFS fs, const char* path);
hdfsFileInfo *hdfsListDirectory(hdfsFS fs, const char* path,int *OUTPUT);
//hdfsFileInfo *hdfsListDirectory(hdfsFS fs, const char* path,int *numEntries);
hdfsFileInfo *hdfsGetPathInfo(hdfsFS fs, const char* path);
tOffset hdfsGetDefaultBlockSize(hdfsFS fs);
int hdfsExists(hdfsFS fs, const char *path);
int hdfsChmod(hdfsFS fs, const char* path, short mode);
int hdfsChown(hdfsFS fs, const char* path, const char *owner, const char *group);
int hdfsSetReplication(hdfsFS fs, const char* path, int16_t replication);

hdfsFile hdfsOpenFile(hdfsFS fs, const char* path, int flags,int bufferSize, short replication, tSize blocksize);
int hdfsCloseFile(hdfsFS fs, hdfsFile file);
tSize hdfsRead(hdfsFS fs, hdfsFile file, void* buffer, tSize length);
tSize hdfsPread(hdfsFS fs, hdfsFile file, tOffset position,void* buffer, tSize length);
tSize hdfsWrite(hdfsFS fs, hdfsFile file, const void* wbuffer,tSize length);
int hdfsFlush(hdfsFS fs, hdfsFile file);
int hdfsAvailable(hdfsFS fs, hdfsFile file);
int hdfsSeek(hdfsFS fs, hdfsFile file, tOffset desiredPos);
tOffset hdfsTell(hdfsFS fs, hdfsFile file);
char*** hdfsGetHosts(hdfsFS fs, const char* path,tOffset start, tOffset length);
