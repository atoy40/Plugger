AC_PREREQ(2.53)
AC_INIT([plugger], [1.0])
AM_INIT_AUTOMAKE([1.11])
AC_CONFIG_SRCDIR([plugger.vala])
AC_CONFIG_MACRO_DIR([m4])

#AC_ISC_POSIX
AC_PROG_CC
AC_STDC_HEADERS
AC_PROG_LIBTOOL
#AC_FUNC_MMAP

PKG_CHECK_MODULES(GOBJECT, gobject-2.0)
PKG_CHECK_MODULES(GMODULE, gmodule-2.0)
PKG_CHECK_MODULES(GIO, gio-2.0)

AM_PROG_VALAC([0.7.6])
AC_OUTPUT([Makefile])
