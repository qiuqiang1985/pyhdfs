# This file was automatically generated by SWIG (http://www.swig.org).
# Version 2.0.9
#
# Do not make changes to this file unless you know what you are doing--modify
# the SWIG interface file instead.



from sys import version_info
if version_info >= (2,6,0):
    def swig_import_helper():
        from os.path import dirname
        import imp
        fp = None
        try:
            fp, pathname, description = imp.find_module('_pyhdfs', [dirname(__file__)])
        except ImportError:
            import _pyhdfs
            return _pyhdfs
        if fp is not None:
            try:
                _mod = imp.load_module('_pyhdfs', fp, pathname, description)
            finally:
                fp.close()
            return _mod
    _pyhdfs = swig_import_helper()
    del swig_import_helper
else:
    import _pyhdfs
del version_info
try:
    _swig_property = property
except NameError:
    pass # Python < 2.2 doesn't have 'property'.
def _swig_setattr_nondynamic(self,class_type,name,value,static=1):
    if (name == "thisown"): return self.this.own(value)
    if (name == "this"):
        if type(value).__name__ == 'SwigPyObject':
            self.__dict__[name] = value
            return
    method = class_type.__swig_setmethods__.get(name,None)
    if method: return method(self,value)
    if (not static):
        self.__dict__[name] = value
    else:
        raise AttributeError("You cannot add attributes to %s" % self)

def _swig_setattr(self,class_type,name,value):
    return _swig_setattr_nondynamic(self,class_type,name,value,0)

def _swig_getattr(self,class_type,name):
    if (name == "thisown"): return self.this.own()
    method = class_type.__swig_getmethods__.get(name,None)
    if method: return method(self)
    raise AttributeError(name)

def _swig_repr(self):
    try: strthis = "proxy of " + self.this.__repr__()
    except: strthis = ""
    return "<%s.%s; %s >" % (self.__class__.__module__, self.__class__.__name__, strthis,)

try:
    _object = object
    _newclass = 1
except AttributeError:
    class _object : pass
    _newclass = 0


O_RDONLY = _pyhdfs.O_RDONLY
O_WRONLY = _pyhdfs.O_WRONLY
EINTERNAL = _pyhdfs.EINTERNAL
kObjectKindFile = _pyhdfs.kObjectKindFile
kObjectKindDirectory = _pyhdfs.kObjectKindDirectory
UNINITIALIZED = _pyhdfs.UNINITIALIZED
INPUT = _pyhdfs.INPUT
OUTPUT = _pyhdfs.OUTPUT
class hdfsFile_internal(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, hdfsFile_internal, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, hdfsFile_internal, name)
    __repr__ = _swig_repr
    __swig_setmethods__["file"] = _pyhdfs.hdfsFile_internal_file_set
    __swig_getmethods__["file"] = _pyhdfs.hdfsFile_internal_file_get
    if _newclass:file = _swig_property(_pyhdfs.hdfsFile_internal_file_get, _pyhdfs.hdfsFile_internal_file_set)
    __swig_setmethods__["type"] = _pyhdfs.hdfsFile_internal_type_set
    __swig_getmethods__["type"] = _pyhdfs.hdfsFile_internal_type_get
    if _newclass:type = _swig_property(_pyhdfs.hdfsFile_internal_type_get, _pyhdfs.hdfsFile_internal_type_set)
    def __init__(self): 
        this = _pyhdfs.new_hdfsFile_internal()
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _pyhdfs.delete_hdfsFile_internal
    __del__ = lambda self : None;
hdfsFile_internal_swigregister = _pyhdfs.hdfsFile_internal_swigregister
hdfsFile_internal_swigregister(hdfsFile_internal)

class hdfsFileInfo(_object):
    __swig_setmethods__ = {}
    __setattr__ = lambda self, name, value: _swig_setattr(self, hdfsFileInfo, name, value)
    __swig_getmethods__ = {}
    __getattr__ = lambda self, name: _swig_getattr(self, hdfsFileInfo, name)
    __repr__ = _swig_repr
    __swig_setmethods__["mKind"] = _pyhdfs.hdfsFileInfo_mKind_set
    __swig_getmethods__["mKind"] = _pyhdfs.hdfsFileInfo_mKind_get
    if _newclass:mKind = _swig_property(_pyhdfs.hdfsFileInfo_mKind_get, _pyhdfs.hdfsFileInfo_mKind_set)
    __swig_setmethods__["mName"] = _pyhdfs.hdfsFileInfo_mName_set
    __swig_getmethods__["mName"] = _pyhdfs.hdfsFileInfo_mName_get
    if _newclass:mName = _swig_property(_pyhdfs.hdfsFileInfo_mName_get, _pyhdfs.hdfsFileInfo_mName_set)
    __swig_setmethods__["mLastMod"] = _pyhdfs.hdfsFileInfo_mLastMod_set
    __swig_getmethods__["mLastMod"] = _pyhdfs.hdfsFileInfo_mLastMod_get
    if _newclass:mLastMod = _swig_property(_pyhdfs.hdfsFileInfo_mLastMod_get, _pyhdfs.hdfsFileInfo_mLastMod_set)
    __swig_setmethods__["mSize"] = _pyhdfs.hdfsFileInfo_mSize_set
    __swig_getmethods__["mSize"] = _pyhdfs.hdfsFileInfo_mSize_get
    if _newclass:mSize = _swig_property(_pyhdfs.hdfsFileInfo_mSize_get, _pyhdfs.hdfsFileInfo_mSize_set)
    __swig_setmethods__["mReplication"] = _pyhdfs.hdfsFileInfo_mReplication_set
    __swig_getmethods__["mReplication"] = _pyhdfs.hdfsFileInfo_mReplication_get
    if _newclass:mReplication = _swig_property(_pyhdfs.hdfsFileInfo_mReplication_get, _pyhdfs.hdfsFileInfo_mReplication_set)
    __swig_setmethods__["mBlockSize"] = _pyhdfs.hdfsFileInfo_mBlockSize_set
    __swig_getmethods__["mBlockSize"] = _pyhdfs.hdfsFileInfo_mBlockSize_get
    if _newclass:mBlockSize = _swig_property(_pyhdfs.hdfsFileInfo_mBlockSize_get, _pyhdfs.hdfsFileInfo_mBlockSize_set)
    __swig_setmethods__["mOwner"] = _pyhdfs.hdfsFileInfo_mOwner_set
    __swig_getmethods__["mOwner"] = _pyhdfs.hdfsFileInfo_mOwner_get
    if _newclass:mOwner = _swig_property(_pyhdfs.hdfsFileInfo_mOwner_get, _pyhdfs.hdfsFileInfo_mOwner_set)
    __swig_setmethods__["mGroup"] = _pyhdfs.hdfsFileInfo_mGroup_set
    __swig_getmethods__["mGroup"] = _pyhdfs.hdfsFileInfo_mGroup_get
    if _newclass:mGroup = _swig_property(_pyhdfs.hdfsFileInfo_mGroup_get, _pyhdfs.hdfsFileInfo_mGroup_set)
    __swig_setmethods__["mPermissions"] = _pyhdfs.hdfsFileInfo_mPermissions_set
    __swig_getmethods__["mPermissions"] = _pyhdfs.hdfsFileInfo_mPermissions_get
    if _newclass:mPermissions = _swig_property(_pyhdfs.hdfsFileInfo_mPermissions_get, _pyhdfs.hdfsFileInfo_mPermissions_set)
    __swig_setmethods__["mLastAccess"] = _pyhdfs.hdfsFileInfo_mLastAccess_set
    __swig_getmethods__["mLastAccess"] = _pyhdfs.hdfsFileInfo_mLastAccess_get
    if _newclass:mLastAccess = _swig_property(_pyhdfs.hdfsFileInfo_mLastAccess_get, _pyhdfs.hdfsFileInfo_mLastAccess_set)
    def __init__(self): 
        this = _pyhdfs.new_hdfsFileInfo()
        try: self.this.append(this)
        except: self.this = this
    __swig_destroy__ = _pyhdfs.delete_hdfsFileInfo
    __del__ = lambda self : None;
hdfsFileInfo_swigregister = _pyhdfs.hdfsFileInfo_swigregister
hdfsFileInfo_swigregister(hdfsFileInfo)


def hdfsConnectAsUser(*args):
  return _pyhdfs.hdfsConnectAsUser(*args)
hdfsConnectAsUser = _pyhdfs.hdfsConnectAsUser

def hdfsDisconnect(*args):
  return _pyhdfs.hdfsDisconnect(*args)
hdfsDisconnect = _pyhdfs.hdfsDisconnect

def hdfsGetCapacity(*args):
  return _pyhdfs.hdfsGetCapacity(*args)
hdfsGetCapacity = _pyhdfs.hdfsGetCapacity

def hdfsGetUsed(*args):
  return _pyhdfs.hdfsGetUsed(*args)
hdfsGetUsed = _pyhdfs.hdfsGetUsed

def hdfsCopy(*args):
  return _pyhdfs.hdfsCopy(*args)
hdfsCopy = _pyhdfs.hdfsCopy

def hdfsMove(*args):
  return _pyhdfs.hdfsMove(*args)
hdfsMove = _pyhdfs.hdfsMove

def hdfsDelete(*args):
  return _pyhdfs.hdfsDelete(*args)
hdfsDelete = _pyhdfs.hdfsDelete

def hdfsRename(*args):
  return _pyhdfs.hdfsRename(*args)
hdfsRename = _pyhdfs.hdfsRename

def hdfsGetWorkingDirectory(*args):
  return _pyhdfs.hdfsGetWorkingDirectory(*args)
hdfsGetWorkingDirectory = _pyhdfs.hdfsGetWorkingDirectory

def hdfsSetWorkingDirectory(*args):
  return _pyhdfs.hdfsSetWorkingDirectory(*args)
hdfsSetWorkingDirectory = _pyhdfs.hdfsSetWorkingDirectory

def hdfsCreateDirectory(*args):
  return _pyhdfs.hdfsCreateDirectory(*args)
hdfsCreateDirectory = _pyhdfs.hdfsCreateDirectory

def hdfsListDirectory(*args):
  return _pyhdfs.hdfsListDirectory(*args)
hdfsListDirectory = _pyhdfs.hdfsListDirectory

def hdfsGetPathInfo(*args):
  return _pyhdfs.hdfsGetPathInfo(*args)
hdfsGetPathInfo = _pyhdfs.hdfsGetPathInfo

def hdfsGetDefaultBlockSize(*args):
  return _pyhdfs.hdfsGetDefaultBlockSize(*args)
hdfsGetDefaultBlockSize = _pyhdfs.hdfsGetDefaultBlockSize

def hdfsExists(*args):
  return _pyhdfs.hdfsExists(*args)
hdfsExists = _pyhdfs.hdfsExists

def hdfsChmod(*args):
  return _pyhdfs.hdfsChmod(*args)
hdfsChmod = _pyhdfs.hdfsChmod

def hdfsChown(*args):
  return _pyhdfs.hdfsChown(*args)
hdfsChown = _pyhdfs.hdfsChown

def hdfsSetReplication(*args):
  return _pyhdfs.hdfsSetReplication(*args)
hdfsSetReplication = _pyhdfs.hdfsSetReplication

def hdfsOpenFile(*args):
  return _pyhdfs.hdfsOpenFile(*args)
hdfsOpenFile = _pyhdfs.hdfsOpenFile

def hdfsCloseFile(*args):
  return _pyhdfs.hdfsCloseFile(*args)
hdfsCloseFile = _pyhdfs.hdfsCloseFile

def hdfsRead(*args):
  return _pyhdfs.hdfsRead(*args)
hdfsRead = _pyhdfs.hdfsRead

def hdfsPread(*args):
  return _pyhdfs.hdfsPread(*args)
hdfsPread = _pyhdfs.hdfsPread

def hdfsWrite(*args):
  return _pyhdfs.hdfsWrite(*args)
hdfsWrite = _pyhdfs.hdfsWrite

def hdfsFlush(*args):
  return _pyhdfs.hdfsFlush(*args)
hdfsFlush = _pyhdfs.hdfsFlush

def hdfsAvailable(*args):
  return _pyhdfs.hdfsAvailable(*args)
hdfsAvailable = _pyhdfs.hdfsAvailable

def hdfsSeek(*args):
  return _pyhdfs.hdfsSeek(*args)
hdfsSeek = _pyhdfs.hdfsSeek

def hdfsTell(*args):
  return _pyhdfs.hdfsTell(*args)
hdfsTell = _pyhdfs.hdfsTell

def hdfsGetHosts(*args):
  return _pyhdfs.hdfsGetHosts(*args)
hdfsGetHosts = _pyhdfs.hdfsGetHosts
# This file is compatible with both classic and new-style classes.


