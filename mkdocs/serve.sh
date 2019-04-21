#!/bin/bash
export BUILD_DOCS_BASE=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

cd $BUILD_DOCS_BASE
./build.sh
. $BUILD_DOCS_BASE/venv/bin/activate
mkdocs serve

