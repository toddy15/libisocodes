# Process this file with autoconf to produce a configure script.
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

# Set up autoconf
AC_PREREQ(2.68)
AC_INIT([libisocodes], [1.2.4], [toddy@debian.org])
AC_CONFIG_HEADERS([config.h])
AC_CONFIG_AUX_DIR([build-aux])
AC_CONFIG_MACRO_DIR([m4])

# Set up automake
AM_INIT_AUTOMAKE([1.11 foreign subdir-objects silent-rules no-dist-gzip dist-xz])
AM_MAINTAINER_MODE

# Set up libtool
LT_PREREQ([2.4.2])
LT_INIT
LIBISOCODES_LT_VERSION="2:3:1"
AC_SUBST([LIBISOCODES_LT_VERSION])

# Check for compilers and pkg-config
AM_PROG_VALAC([0.26], [], [
	AC_MSG_ERROR([valac is required. On Debian, try installing the package valac.])
])
AC_PATH_PROG([G_IR_COMPILER], [g-ir-compiler], [no])
if test x"$G_IR_COMPILER" = x"no" ; then
    AC_MSG_ERROR([g-ir-compiler is required. On Debian, try installing the package gobject-introspection.])
fi
AC_PROG_CC
AM_PROG_CC_C_O
PKG_PROG_PKG_CONFIG

# Set up gettext
AM_GNU_GETTEXT([external])
AM_GNU_GETTEXT_VERSION([0.19.3])
AC_DEFINE([GETTEXT_PACKAGE], ["libisocodes"], [Gettext package name.])

# Detect the needed libraries
PKG_CHECK_MODULES([GOBJECT], [gobject-2.0])
PKG_CHECK_MODULES([GLIB], [glib-2.0])
PKG_CHECK_MODULES([LIBXML], [libxml-2.0])
PKG_CHECK_MODULES([GEE], [gee-0.8])

# Write configuration files
AC_CONFIG_FILES([
	Makefile
	po/Makefile.in
])

# Terminate script
AC_OUTPUT
