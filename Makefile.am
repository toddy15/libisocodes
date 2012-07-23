# Process this file with automake to produce Makefile.in.
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

lib_LTLIBRARIES = libisocodes.la
libisocodes_la_SOURCES = isocodes.c iso_3166.c iso_3166_entry.c exceptions.c
include_HEADERS = libisocodes.h

LIBRARY_ABI_VERSION = 4:6:3

libisocodes_la_CFLAGS = $(GLIB_CFLAGS) $(LIBXML_CFLAGS)
libisocodes_la_LIBADD = $(GLIB_LIBS) $(LIBXML_LIBS)
libisocodes_la_LDFLAGS = -version-info $(LIBRARY_ABI_VERSION)

MAINTAINERCLEANFILES = config.h.in~
