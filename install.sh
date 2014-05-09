#!/usr/bin/env bash

DIR="$(cd -P "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd)"
BINDIR="${HOME}/bin"

mkdir -p "${BINDIR}"
ln -f -s -n "${DIR}/ltoggle-launch"  "${BINDIR}/ltoggle-launch"
ln -f -s -n "${DIR}/ltoggle-toggle"  "${BINDIR}/ltoggle-toggle"

