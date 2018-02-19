#!/usr/bin/env bash
# Copyright (C) 2018 Miquel Sabaté Solà <mikisabate@gmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

set -ex

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
pushd $DIR

# The build source and destination directories. This is done this way so we
# can re-use this script when deploying.
: ${BUILD_SOURCE:=.}
: ${BUILD_DEST:=./_site}

# Clean up previous build.
rm -rf $BUILD_DEST

# Build && test.
bundle exec jekyll build -s $BUILD_SOURCE -d $BUILD_DEST
bundle exec rubocop
bundle exec rake

echo "Jekyll has built your application in '$BUILD_DEST'"
