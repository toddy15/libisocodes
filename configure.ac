# Process this file with autoconf to produce a configure script.
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

# Set up autoconf
AC_PREREQ(2.68)
AC_INIT([libisocodes], [1.0], [toddy@debian.org])
AC_CONFIG_HEADERS([config.h])
AC_CONFIG_AUX_DIR([build-aux])
AC_CONFIG_MACRO_DIR([m4])

# Set up automake
AM_INIT_AUTOMAKE([1.11 foreign subdir-objects silent-rules no-dist-gzip dist-bzip2])
AM_MAINTAINER_MODE

# Set up libtool
LT_PREREQ([2.4.2])
LT_INIT

# Check for compiler and pkg-config
AC_PROG_CC
AM_PROG_CC_C_O
PKG_PROG_PKG_CONFIG

# Detect the two needed libraries
PKG_CHECK_MODULES([GLIB], [glib-2.0])
PKG_CHECK_MODULES([LIBXML], [libxml-2.0])

# Write configuration files
AC_CONFIG_FILES([
	Makefile
])

# Terminate script
AC_OUTPUT
