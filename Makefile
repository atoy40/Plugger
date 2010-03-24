VALAC=valac
#VALAFLAGS=-g --save-temps
VALAFLAGS=
SRCS = plugger.vala plugin.vala

all: plugger libmyplugin.so

# The main binary

plugger: $(SRCS)
	$(VALAC) $(VALAFLAGS) --pkg gmodule-2.0 $(SRCS)

# Generate a test plugin

libmyplugin.so: myplugin.vala plugin.vapi plugin.h
	$(VALAC) -C --pkg plugin --vapidir=. myplugin.vala
	$(CC) --shared -fPIC -I/usr/include/glib-2.0 -I/usr/lib/glib-2.0/include -I. -lglib-2.0 -o $@ myplugin.c

# Generate the plugin API (C and Vala)

plugin.vapi: plugin.vala
	echo "[CCode (cheader_filename = \"plugin.h\")]" > $@
	cat plugin.vala >> $@

plugin.h: plugin.vala
	$(VALAC) -H $@ -C plugin.vala

# Cleaning

clean:
	rm -f *.c *.h *.vapi plugger libmyplugin.so
