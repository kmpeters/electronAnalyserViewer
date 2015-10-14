< envPaths

#
epicsEnvSet("PREFIX", "EAV1:")
epicsEnvSet("PORT",   "EA1")
epicsEnvSet("QSIZE",  "20")

#
epicsEnvSet EPICS_CA_MAX_ARRAY_BYTES 100000000

# Increase size of buffer for error logging from default 1256
errlogInit(20000)

dbLoadDatabase("$(TOP)/dbd/electronAnalyserViewer.dbd")
electronAnalyserViewer_registerRecordDeviceDriver(pdbbase)

#
drvAsynIPPortConfigure("$(PORT)","192.168.0.1:55555", 0, 0, 0)

# Configure electron analyser viewer 
electronAnalyserViewerConfig("$(PORT)", 30, 25000000, 0, 0)

#asynSetTraceMask("$(PORT)", 0, 0x1)
#asynSetTraceIOMask("$(PORT)", 0, 0x0)

# Load the detector-specific PVs
dbLoadRecords("$(TOP)/electronAnalyserViewerApp/Db/electronAnalyser.db","P=$(PREFIX),R=cam1:,PORT=$(PORT)")

# Load all the areaDetector plugins
< "$(AREA_DETECTOR)/iocBoot/commonPlugins.cmd"

< "$(TOP)/iocBoot/$(IOC)/save_restore.cmd"

iocInit()

# save things every thirty seconds
create_monitor_set("auto_settings.req", 30,"P=$(PREFIX),D=cam1:")

#asynSetTraceMask("$(PORT)", 0, 0x11)
asynSetTraceMask("$(PORT)", 0, 0x11)

#asynReport(10, "$(PORT)")
