< envPaths

#
epicsEnvSet("PREFIX", "EAV1:")
epicsEnvSet("PORT",   "EA1")
epicsEnvSet("QSIZE",  "20")
epicsEnvSet("XSIZE",  "1392")
epicsEnvSet("YSIZE",  "1040")
epicsEnvSet("NCHANS", "2048")

#
epicsEnvSet EPICS_CA_MAX_ARRAY_BYTES 100000000

# Increase size of buffer for error logging from default 1256
errlogInit(20000)

dbLoadDatabase("$(TOP)/dbd/electronAnalyserViewer.dbd")
electronAnalyserViewer_registerRecordDeviceDriver(pdbbase)

# Configure electron analyser viewer 
# IP address specified in a PV: $(PREFIX):cam1:CONNECTION
#   "tcp://192.168.0.1:55555"
#   "tcp://164.54.118.4:8888"

electronAnalyserViewerConfig("$(PORT)", 30, 25000000, 0, 0)

#asynSetTraceMask("$(PORT)", 0, 0x1)
#asynSetTraceIOMask("$(PORT)", 0, 0x0)

# Load the ADBase PVs
dbLoadRecords("$(AREA_DETECTOR)/ADApp/Db/ADBase.template",     "P=$(PREFIX),R=cam1:,PORT=$(PORT),ADDR=0,TIMEOUT=1")

# Create a standard arrays plugin
NDStdArraysConfigure("Image1", 3, 0, "$(PORT)", 0)
dbLoadRecords("$(AREA_DETECTOR)/ADApp/Db/NDPluginBase.template","P=$(PREFIX),R=image1:,PORT=Image1,ADDR=0,TIMEOUT=1,NDARRAY_PORT=$(PORT),NDARRAY_ADDR=0")

# This creates a waveform large enough for 1392x1040x1 (e.g. grayscale) arrays.
# This waveform only allows transporting 64-bit images
dbLoadRecords("$(AREA_DETECTOR)/ADApp/Db/NDStdArrays.template", "P=$(PREFIX),R=image1:,PORT=Image1,ADDR=0,TIMEOUT=1,TYPE=Float64,FTVL=DOUBLE,NELEMENTS=1447680")

# Load the detector-specific PVs
dbLoadRecords("$(TOP)/electronAnalyserViewerApp/Db/electronAnalyserViewer.db","P=$(PREFIX),R=cam1:,PORT=$(PORT)")

# Load all the areaDetector plugins
#!< "$(AREA_DETECTOR)/iocBoot/commonPlugins.cmd"
< "$(TOP)/iocBoot/$(IOC)/commonPlugins_noMagick.cmd"

< "$(TOP)/iocBoot/$(IOC)/save_restore.cmd"

iocInit()

# save things every thirty seconds
create_monitor_set("auto_settings.req", 30,"P=$(PREFIX),D=cam1:")

#asynSetTraceMask("$(PORT)", 0, 0x1)

#asynReport(10, "$(PORT)")
