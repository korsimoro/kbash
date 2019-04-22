#!/bin/bash
export BUILD_DOCS_BASE=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

echo "Building docs in "$BUILD_DOCS_BASE
cd $BUILD_DOCS_BASE

set -e
if [ ! -d "$BUILD_DOCS_BASE/venv" ]; then
  python3 -m venv "$BUILD_DOCS_BASE/venv"
fi

. $BUILD_DOCS_BASE/venv/bin/activate
pip install mkdocs

cd $BUILD_DOCS_BASE && mkdocs build
set +e
