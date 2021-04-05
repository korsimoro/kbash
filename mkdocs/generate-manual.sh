#!/bin/bash
export BUILD_DOCS_BASE=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

echo error > $BUILD_DOCS_BASE/in/example-manual.md
echo "kx manual" | $BUILD_DOCS_BASE/../test/single.sh -i > $BUILD_DOCS_BASE/in/example-manual.md

