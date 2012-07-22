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

libisocodes_VALASOURCES = isocodes.vala iso_3166.vala exceptions.vala
libisocodes_CSOURCES = $(libisocodes_VALASOURCES:.vala=.c)
libisocodes_OBJECTS = $(libisocodes_CSOURCES:.c=.o)

ABI_VERSION = 1
MINOR_VERSION = 0

VALAC = /usr/bin/valac-0.16

libisocodes.so.$(ABI_VERSION).$(MINOR_VERSION): $(libisocodes_OBJECTS) vala.stamp
	ld -shared -soname=libisocodes.so.$(ABI_VERSION) \
	`pkg-config --libs glib-2.0` \
	`pkg-config --libs libxml-2.0` \
	-o libisocodes.so.$(ABI_VERSION).$(MINOR_VERSION) \
	$(libisocodes_OBJECTS)
	ln -sf libisocodes.so.$(ABI_VERSION).$(MINOR_VERSION) libisocodes.so.$(ABI_VERSION)
	ln -sf libisocodes.so.$(ABI_VERSION) libisocodes.so

vala.stamp: $(libisocodes_VALASOURCES)
	$(VALAC) -C -H libisocodes.h \
	--pkg libxml-2.0 \
	--library libisocodes-$(ABI_VERSION).$(MINOR_VERSION) \
	$(libisocodes_VALASOURCES)
	touch $@

$(libisocodes_CSOURCES): vala.stamp

%.o: %.c
	gcc \
	`pkg-config --cflags glib-2.0` \
	`pkg-config --cflags libxml-2.0` \
	-fPIC -g -c -Wall $<

clean:
	rm -f $(libisocodes_CSOURCES) $(libisocodes_OBJECTS) \
	libisocodes.so.$(ABI_VERSION).$(MINOR_VERSION) \
	libisocodes.so.$(ABI_VERSION) \
	libisocodes.so \
	libisocodes.h \
	libisocodes-$(ABI_VERSION).$(MINOR_VERSION).vapi \
	vala.stamp
