#!/bin/bash
export BUILD_DOCS_BASE=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

echo "kx manual" | $BUILD_DOCS_BASE/../test/single.sh -i > $BUILD_DOCS_BASE/in/example-manual.md

cd $BUILD_DOCS_BASE
docker run --rm -it -v ${PWD}:/docs squidfunk/mkdocs-material build

cp -r docs/* ../docs
