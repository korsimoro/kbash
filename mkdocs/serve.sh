#!/bin/bash
export BUILD_DOCS_BASE=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

cd $BUILD_DOCS_BASE
. ./populate.sh
docker run --rm -it -p 8000:8000 -v ${PWD}:/docs squidfunk/mkdocs-material

