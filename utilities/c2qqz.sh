#!/bin/sh
#
# Numbers a code fragment and converts tabs to tildes and backslash-escapes
# various characters that latex is sensitive to.  Used for code sequences
# that are in a \QuickQuiz directive.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, you can access it online at
# http://www.gnu.org/licenses/gpl-2.0.html.
#
# Copyright (C) IBM Corporation, 2007-2019
# Copyright (C) Facebook, 2019
#
# Authors: Paul E. McKenney <paulmck@linux.ibm.com>

awk '{printf "%3d %s\n", NR, $0}' |
	sed -e 's/^  /~~/' \
	    -e 's/^ /~/' \
	    -e 's/	/~~/g' \
	    -e 's/\\/\\\\/g' \
	    -e 's/$/\\\\/' \
	    -e 's/[#&_{}$%]/\\&/g' \
	    -e 's/</$<$/g' \
	    -e 's/>/$>$/g'
