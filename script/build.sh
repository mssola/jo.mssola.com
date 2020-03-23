#!/usr/bin/env bash
# Copyright (C) 2018-2020 Miquel Sabaté Solà <mikisabate@gmail.com>
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

# You may want to set the following environment variables for this script:
#
# - BUILD_SOURCE: the directory where the source code is located.
# - BUILD_DEST: the directory where the built files should go.
# - USER: the user who should own the files.
# - GROUP: the group who should own the files.

set -ex

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
pushd $DIR

# Set UTF-8 for the build (Jekyll needs this).
export LANG=en_US.UTF-8
export LANGUAGE=en_US:en
export LC_ALL=en_US.UTF-8

# The build source and destination directories. This is done this way so we
# can re-use this script when deploying.
: ${BUILD_SOURCE:=.}
: ${BUILD_DEST:=./_site}

# JS dependencies.
yarn --force
yarn run webpack-single-shot

# Build && test.
bundle
rm -rf $BUILD_DEST/*
bundle exec jekyll build -s $BUILD_SOURCE -d $BUILD_DEST
mkdir $BUILD_DEST/about $BUILD_DEST/en/about

# Hack to fix some issues with the about page...
cp $BUILD_DEST/about.html $BUILD_DEST/about/index.html
cp $BUILD_DEST/en/about.html $BUILD_DEST/en/about/index.html

bundle exec rubocop
bundle exec rake

# Fix ownership of files if a given user was provided.
if [ ! -z "$USER" ]; then
    chown -R $USER:$GROUP $BUILD_DEST
fi

# Nuke the source if specified (useful when the source was a temporary one).
if [ "$NUKE" = "true" ]; then
    pushd $BUILD_SOURCE
    # See: https://unix.stackexchange.com/a/77313. We cannot remove the
    # directory directly, because then Docker might scream "Device busy", since
    # it's a shared volume.
    rm -Rf ..?* .[!.]* *
    popd
fi

set +x
echo "Jekyll has built your application in '$BUILD_DEST'"
