#!/usr/bin/env bash

DIR="$(cd -P "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd)"


"${DIR}/install-basic.sh"


source "${DIR}/ltoggle-common"

CMDSTR="|cmd"


SCHEMA_ARR=("org" "gnome" "settings-daemon" "plugins" "media-keys")
SCHEMA_STR_=""; for p in ${SCHEMA_ARR[@]}; do SCHEMA_STR_+="${p}."; done
PATH_STR_="/"; for p in ${SCHEMA_ARR[@]}; do PATH_STR_+="${p}/"; done
SS="custom-keybinding"
SCHEMA_STR="${SCHEMA_STR_}${SS}"
PATH_STR="${PATH_STR_}${SS}s"


KEYLIST="['${PATH_STR}/custom0/'"
CUSTOMKB_CNT=1
for ixx in ${!LTOGGLE_MAP[@]}; do
    if [[ "${ixx:(-${#CMDSTR})}" == "${CMDSTR}" ]]; then
        KEYLIST+=",'${PATH_STR}/custom${CUSTOMKB_CNT}/'"
        ((CUSTOMKB_CNT++))
        KEYLIST+=",'${PATH_STR}/custom${CUSTOMKB_CNT}/'"
        ((CUSTOMKB_CNT++))
        KEYLIST+=",'${PATH_STR}/custom${CUSTOMKB_CNT}/'"
        ((CUSTOMKB_CNT++))
    fi
done
KEYLIST+="]"

SCHEMA_STR_TRUNCATED="${SCHEMA_STR_:0:${#SCHEMA_STR_} - 1}"
gsettings set "${SCHEMA_STR_TRUNCATED}" "${SS}s" "${KEYLIST}"


CUSTOMKB_CNT=0
for ixx in ${!LTOGGLE_MAP[@]}; do
    if [[ "${ixx:(-${#CMDSTR})}" == "${CMDSTR}" ]]; then
        ix="${ixx:0:${#ixx} - ${#CMDSTR}}"

        gsettings set "${SCHEMA_STR}:${PATH_STR}/custom${CUSTOMKB_CNT}/" "name"    "'ltoggle-toggle_${ix}'"
        gsettings set "${SCHEMA_STR}:${PATH_STR}/custom${CUSTOMKB_CNT}/" "command" "'ltoggle-toggle ${ix}'"
        gsettings set "${SCHEMA_STR}:${PATH_STR}/custom${CUSTOMKB_CNT}/" "binding" "'${LTOGGLE_MAP["${ix}|keyb|toggle"]}'"
        ((CUSTOMKB_CNT++))
        gsettings set "${SCHEMA_STR}:${PATH_STR}/custom${CUSTOMKB_CNT}/" "name"    "'ltoggle-launch_${ix}'"
        gsettings set "${SCHEMA_STR}:${PATH_STR}/custom${CUSTOMKB_CNT}/" "command" "'ltoggle-launch ${ix}'"
        gsettings set "${SCHEMA_STR}:${PATH_STR}/custom${CUSTOMKB_CNT}/" "binding" "'${LTOGGLE_MAP["${ix}|keyb|launch"]}'"
        ((CUSTOMKB_CNT++))
        gsettings set "${SCHEMA_STR}:${PATH_STR}/custom${CUSTOMKB_CNT}/" "name"    "'ltoggle-capture_${ix}'"
        gsettings set "${SCHEMA_STR}:${PATH_STR}/custom${CUSTOMKB_CNT}/" "command" "'ltoggle-capture ${ix}'"
        gsettings set "${SCHEMA_STR}:${PATH_STR}/custom${CUSTOMKB_CNT}/" "binding" "'${LTOGGLE_MAP["${ix}|keyb|capture"]}'"
        ((CUSTOMKB_CNT++))
    fi
done

