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

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
pushd $DIR

##
# Ask basic stuff like language and the file name.

catalan=0

while true; do
    read -p "Catalan only (Y/n)? " choice
    case "$choice" in
        n|N )
            break
            ;;
        * )
            catalan=1
            break
            ;;
    esac
done

read -p "File name (with dashes but without the date): " base
file="$(date +%Y-%m-%d)-$base.org"

##
# Copy template and sed away stuff.

mkdir -p org/ca/_posts
dst=org/ca/_posts/$file
cp templates/post.org $dst
sed -i '/catalan_available/g' $dst

if [[ $catalan == 0 ]]; then
    mkdir -p org/en/_posts
    dst=org/en/_posts/$file
    cp templates/post.org $dst
    sed -i 's/lang: ca/lang: en/g' $dst
    sed -i '/english_available/g' $dst
else
    sed -i 's/english_available: true/english_available: false/g' $dst
fi

##
# Final output.

echo "* Created file: $DIR/org/ca/_posts/$file"
if [[ $catalan == 0 ]]; then
    echo "* Created file: $DIR/org/en/_posts/$file"
fi
