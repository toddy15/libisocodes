## Process this file with automake to produce Makefile.in.
#
# Copyright © 2012-2013 Tobias Quathamer
#
# This file is part of libisocodes.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

ACLOCAL_AMFLAGS = -I m4

# This is needed for gettext, it is too much work to rewrite
# po/Makefile.in.in for a non-recursive approach.
SUBDIRS = po

EXTRA_DIST = libisocodes-$(VERSION).gir vapi/config.vapi $(codetest_testfiles)

lib_LTLIBRARIES = libisocodes.la
libisocodes_la_SOURCES = \
	src/isocodes.vala \
	src/iso_3166.vala \
	src/iso_3166_entry.vala \
	src/exceptions.vala
include_HEADERS = libisocodes.h

libisocodes.h:
	touch $@

VALAFLAGS = \
	--pkg libxml-2.0 \
	--pkg gee-1.0 \
	--library=libisocodes \
	--vapidir=vapi --pkg config \
	--header=libisocodes.h \
	--gir=libisocodes-$(VERSION).gir

# Here are two quotes needed due to expansion by libtool
libisocodes_la_CPPFLAGS = -include config.h -DLOCALEDIR=\""$(localedir)"\"
libisocodes_la_CFLAGS = $(GOBJECT_CFLAGS) $(GLIB_CFLAGS) $(LIBXML_CFLAGS) $(GEE_CFLAGS)
libisocodes_la_LIBADD = $(GOBJECT_LIBS) $(GLIB_LIBS) $(LIBXML_LIBS) $(GEE_LIBS)
libisocodes_la_LDFLAGS = -version-info $(LIBISOCODES_LT_VERSION)

DISTCLEANFILES = libisocodes.h libisocodes.vapi libisocodes-$(VERSION).gir
MAINTAINERCLEANFILES = config.h.in~

# Generate and install gir and typelib data
girdir = $(datadir)/gir-1.0
gir_DATA = libisocodes-$(VERSION).gir

libisocodes-$(VERSION).gir: $(lib_LTLIBRARIES)

libisocodes-$(VERSION).typelib: libisocodes-$(VERSION).gir
	g-ir-compiler --shared-library=libisocodes.so --output=$@ $<

typelibdir = $(libdir)/girepository-1.0
typelib_DATA = libisocodes-$(VERSION).typelib

CLEANFILES = $(gir_DATA) $(typelib_DATA)

# All code below is needed for testing the package
codetest_testfiles = \
	tests/codetest.vala \
	tests/test_iso_3166.vala \
	tests/test_iso_3166_2.vala
codetest_sources = $(codetest_testfiles) $(libisocodes_la_SOURCES)
codetest_VALAFLAGS = \
	--pkg libxml-2.0 \
	--pkg gee-1.0 \
	--vapidir=$(srcdir)/vapi --pkg config \
	-X -I. \
	-X -DGETTEXT_PACKAGE=\"libisocodes\" \
	-X -DLOCALEDIR=\"$(localedir)\"

codetest: $(addprefix $(srcdir)/, $(codetest_sources))
	$(VALAC) $(codetest_VALAFLAGS) --output=$@ $^

check-local: codetest
	gtester --verbose $<

DISTCLEANFILES += codetest
