#!/bin/bash



describe_environment_docs() {
  report_vars "docs Build Environment" DOCS_BASE DOCS_NODE_VERSION DOC_VIEWER_BASE
}
describe_environment_docs_help() {
printf "`cat << EOF
${BLUE}kd activate docs${NC}

EOF
`\n"
}
