# Variables
VAPI_SOURCES_FILES = plugin.vala
ACLOCAL_AMFLAGS = -Im4

# plugger target
bin_PROGRAMS = plugger
plugger_SOURCES = plugger.vala $(VAPI_SOURCES_FILES)
plugger_VALAFLAGS = --pkg gmodule-2.0 --pkg gio-2.0
AM_CFLAGS = $(GOBJECT_CFLAGS) $(GMODULE_LIBS)
plugger_LDADD = $(GOBJECT_LIBS) $(GMODULE_LIBS) $(GIO_LIBS)

# VAPI generation
BUILT_SOURCES = plugin.vapi plugin.h
CLEANFILES = plugin.vapi plugin.h

plugin.vapi plugin.h: $(VAPI_SOURCES_FILES)
	$(VALAC) -C -H plugin.h --library=plugin $(VAPI_SOURCES_FILES)

# myplugin target
lib_LTLIBRARIES = libmyplugin.la libmyotherplugin.la

libmyplugin_la_SOURCES = myplugin.vala
libmyplugin_la_VALAFLAGS = --vapidir=$(top_srcdir) --pkg plugin

libmyotherplugin_la_SOURCES = myotherplugin.vala
libmyotherplugin_la_VALAFLAGS = --vapidir=$(top_srcdir) --pkg plugin
