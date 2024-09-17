#!/usr/bin/env sh

ROOT_DIR="$(cd "$( dirname "${BASH_SOURCE[0]}" )/.." &> /dev/null && pwd )"

rm -r $ROOT_DIR/build/*
cp -r $ROOT_DIR/src/public/* $ROOT_DIR/build/
find build/ -type f -name *.html -exec ruby scripts/render.rb {} \;

cp -r $ROOT_DIR/images $ROOT_DIR/build/
cp -r $ROOT_DIR/stylesheets $ROOT_DIR/build/
