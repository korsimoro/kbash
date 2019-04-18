#!/bin/bash

export DOCS_BASE=$KXX/docs
export DOC_VIEWER_BASE=$KXX/nteract-docs
export DOCS_NODE_VERSION=v11.6.0



vet_environment_docs() {
  if check_basic_node_ability; then
    echo "Veted Environment for Docs - basic node ability for $DOCS_NODE_VERSION confirmed."
    true
  else
    false
  fi
}
