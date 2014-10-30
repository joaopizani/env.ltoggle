#!/usr/bin/env bash

DIR="$(cd -P "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd)"
BINDIR="${HOME}/bin"

SCRIPTS_TO_INSTALL=( 'ltoggle-launch' 'ltoggle-toggle' 'ltoggle-capture' )

mkdir -p "${BINDIR}"
for s in ${SCRIPTS_TO_INSTALL[@]}; do ln -f -s -n "${DIR}/${s}" "${BINDIR}/${s}"; done

