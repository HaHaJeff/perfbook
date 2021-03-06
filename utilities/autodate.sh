#!/bin/sh
#
# Extract git commit date info to generate autodate.tex.
# If invoked on not-clean git repository, append "(m)" to date field
# for title.
# If git status is not availabe, use current date instead.
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
# Copyright (C) Akira Yokosawa, 2017
#
# Authors: Akira Yokosawa <akiyks@gmail.com>

export LC_TIME=C
# check if we are in git repository
if ! test -e .git
then
	date_str=`date -R`
	modified=""
	release=""
else
	date_str=`git show --format="%cD" | head -1`
	# check if git status is clean
	gitstatus=`git status --porcelain | wc -l`
	if [ $gitstatus != "0" ]
	then
		modified="(m)"
	else
		modified=""
	fi
	release="`git describe --tags HEAD | sed -e 's/^.*-.*$//'`"
fi
month=`date --date="$date_str" +%B`
year=`date --date="$date_str" +%Y`
day=`date --date="$date_str" +%e`
if test -n "$release"
then
	release=`env printf '%s %s' '\\\\' "Release $release"`
fi

env printf '\\date{%s %s, %s %s %s}\n' $month $day $year $modified "$release"
env printf '\\newcommand{\\commityear}{%s}\n' $year
