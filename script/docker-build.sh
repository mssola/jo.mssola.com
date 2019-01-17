#!/usr/bin/env bash
# Copyright (C) 2019 Miquel Sabaté Solà <mikisabate@gmail.com>
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

# If the image does not exist, build it.
IMGTAG=mssola/jo:latest
[ ! -z $(docker images -q $IMGTAG) ] || docker build -t $IMGTAG .

# The user which should own the produced files.
user=$(id -u `whoami`)
group=$(id -g `whoami`)

# The -it flag should not be set on the post-receive hook because there's no TTY
# there.
IT="-it"
if [ "$POST_RECEIVE" = "true" ]; then
    IT=
fi

# And now the call...
docker run --rm $IT \
  -e BUILD_SOURCE=/src -e BUILD_DEST=/dest \
  -e BUNDLE_GEMFILE=/src/Gemfile -e USER=$user -e GROUP=$group \
  -e NODE_ENV=development -e NUKE=$NUKE \
  -v $BUILD_SOURCE:/src -v $BUILD_DEST:/dest \
  $IMGTAG /src/script/build.sh
