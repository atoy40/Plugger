# Variables
VAPI_SOURCES_FILES = plugin.vala

# plugger target
bin_PROGRAMS = plugger
plugger_SOURCES = plugger.vala $(VAPI_SOURCES_FILES)
plugger_VALAFLAGS = -H plugin.h --library=plugin --pkg gmodule-2.0
AM_CFLAGS = $(GOBJECT_CFLAGS) $(GMODULE_LIBS)
plugger_LDADD = $(GOBJECT_LIBS) $(GMODULE_LIBS)

# VAPI generation
BUILT_SOURCES = plugin.vapi plugin.h
CLEANFILES = plugin.vapi plugin.h
plugin.vapi plugin.h: $(VAPI_SOURCES_FILES)
