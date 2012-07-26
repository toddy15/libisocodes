## Process this file with automake to produce Makefile.in.
#
# Copyright © 2012 Tobias Quathamer
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
LIBISOCODES_ABI_VERSION = 0:0:0

# This is needed for gettext, it is too much work to rewrite
# po/Makefile.in.in for a non-recursing approach.
SUBDIRS = po

EXTRA_DIST = libisocodes-$(VERSION).gir vapi/config.vapi

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
	--library=libisocodes \
	--vapidir=vapi --pkg config \
	--header=libisocodes.h \
	--gir=libisocodes-$(VERSION).gir

libisocodes_la_CFLAGS = $(GLIB_CFLAGS) $(LIBXML_CFLAGS)
libisocodes_la_LIBADD = $(GLIB_LIBS) $(LIBXML_LIBS)
libisocodes_la_LDFLAGS = -version-info $(LIBISOCODES_ABI_VERSION)

DISTCLEANFILES = libisocodes.h libisocodes.vapi libisocodes-$(VERSION).gir
MAINTAINERCLEANFILES = config.h.in~
