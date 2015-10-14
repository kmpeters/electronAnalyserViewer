TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#========================================

# The following is needed on win32-x86-debug because the Prosilica library 
# wants to use LIBCMT, and that conflicts with LIBCMTD
#ifeq ($(T_A), win32-x86)
#USR_LDFLAGS += /NODEFAULTLIB:LIBCMT
#endif

# -------------------------------
# Build an Diamond Support Module
# -------------------------------

#define the library name
LIBRARY_IOC_Linux += electronAnalyserViewerSupport

# The following are compiled and added to the support library
electronAnalyserViewerSupport_SRCS += drvElectronAnalyserViewerRegistrar.c
electronAnalyserViewerSupport_SRCS += electronAnalyserViewer.cpp
electronAnalyserViewerSupport_SRCS += dgframe.pb.cc
electronAnalyserViewerSupport_LIBS += zmq
electronAnalyserViewerSupport_LIBS += protobuf

zmq_DIR = $(ZMQ)/lib
protobuf_DIR = $(PROTOBUF)/lib

DBD += electronAnalyserViewerSupport.dbd

USR_INCLUDES += -I$(ZMQ)/include
USR_INCLUDES += -I$(PROTOBUF)/include

# ------------------------
# Build an IOC Application
# ------------------------

PROD_IOC_Linux += electronAnalyserViewer

# electronAnalyserViewer.dbd will be installed into <top>/dbd
# <name>.dbd will be created from <name>Include.dbd
DBD += electronAnalyserViewer.dbd
#DBD += electronAnalyserViewerSupport.dbd

# electronAnalyserViewer.dbd will be created from these files
electronAnalyserViewer_DBD += commonDriverSupport.dbd
electronAnalyserViewer_DBD += electronAnalyserViewerSupport.dbd
electronAnalyserViewer_DBD += NDPluginSupport.dbd

# <name>_registerRecordDeviceDriver.cpp will be created from <name>.dbd
electronAnalyserViewer_SRCS += electronAnalyserViewer_registerRecordDeviceDriver.cpp
# These two lines are needed for non-vxWorks builds, such as Linux
electronAnalyserViewer_SRCS_DEFAULT += electronAnalyserViewerMain.cpp
electronAnalyserViewer_SRCS_vxWorks += -nil-

# Add locally compiled object code
electronAnalyserViewer_LIBS += electronAnalyserViewerSupport
electronAnalyserViewer_LIBS += NDPlugin 
electronAnalyserViewer_LIBS += zmq
electronAnalyserViewer_LIBS += protobuf

# We need to link this IOC Application against the EPICS Base libraries

# install the areaDetector and dxp DLL libraries locally in our bin dir

BIN_INSTALLS_WIN32 += $(wildcard $(AREADETECTOR)/bin/win32-x86/*.dll)
BIN_INSTALLS_WIN32 += $(wildcard $(FFMPEGSERVER)/bin/win32-x86/*.dll)

# install caRepeater.exe in the bin dir so we dont depend on EPICS being preinstalled
# on our Windows target machine
BIN_INSTALLS_WIN32 += $(EPICS_BASE)/bin/$(EPICS_HOST_ARCH)/caRepeater.exe

# Ensure all the common libraries used by areaDetector are included in the build
# of both library and IOC executable.
include $(AREADETECTOR)/ADApp/commonDriverMakefile

include $(TOP)/configure/RULES
