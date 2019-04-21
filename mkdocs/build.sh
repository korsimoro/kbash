#!/bin/bash
export BUILD_DOCS_BASE=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

set -e
if [ ! -d "$BUILD_DOCS_BASE/venv" ]; then
  virtualenv -p python3 "$BUILD_DOCS_BASE/venv"
fi

. $BUILD_DOCS_BASE/venv/bin/activate
pip install mkdocs

cd $BUILD_DOCS_BASE && mkdocs build
set +e
