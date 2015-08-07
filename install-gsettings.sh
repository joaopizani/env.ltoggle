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


SCHEMA_STR_TRUNCATED="${SCHEMA_STR_:0:${#SCHEMA_STR_} - 1}"
KEYLIST_EXISTING="$(gsettings get "${SCHEMA_STR_TRUNCATED}" "${SS}s")"
KEYLIST_ADDITIONAL="'${PATH_STR}/custom-ltoggle-empty/'"
for ixx in ${!LTOGGLE_MAP[@]}; do
    if [[ "${ixx:(-${#CMDSTR})}" == "${CMDSTR}" ]]; then
        ix="${ixx:0:${#ixx} - ${#CMDSTR}}"
        KEYLIST_ADDITIONAL+=",'${PATH_STR}/custom-${ix}-toggle/'"
        KEYLIST_ADDITIONAL+=",'${PATH_STR}/custom-${ix}-launch/'"
        KEYLIST_ADDITIONAL+=",'${PATH_STR}/custom-${ix}-capture/'"
    fi
done
KEYLIST_ADDITIONAL+="]"
[[ ${KEYLIST_EXISTING:(-2)} = "[]" ]] && KEYLIST="[${KEYLIST_ADDITIONAL}" || KEYLIST="${KEYLIST_EXISTING:0:${#KEYLIST_EXISTING} - 1},${KEYLIST_ADDITIONAL}"
gsettings set "${SCHEMA_STR_TRUNCATED}" "${SS}s" "${KEYLIST}"


for ixx in ${!LTOGGLE_MAP[@]}; do
    if [[ "${ixx:(-${#CMDSTR})}" == "${CMDSTR}" ]]; then
        ix="${ixx:0:${#ixx} - ${#CMDSTR}}"

        gsettings set "${SCHEMA_STR}:${PATH_STR}/custom-${ix}-toggle/" "name"    "'ltoggle-toggle_${ix}'"
        gsettings set "${SCHEMA_STR}:${PATH_STR}/custom-${ix}-toggle/" "command" "'ltoggle-toggle ${ix}'"
        gsettings set "${SCHEMA_STR}:${PATH_STR}/custom-${ix}-toggle/" "binding" "'${LTOGGLE_MAP["${ix}|keyb|toggle"]}'"
        gsettings set "${SCHEMA_STR}:${PATH_STR}/custom-${ix}-launch/" "name"    "'ltoggle-launch_${ix}'"
        gsettings set "${SCHEMA_STR}:${PATH_STR}/custom-${ix}-launch/" "command" "'ltoggle-launch ${ix}'"
        gsettings set "${SCHEMA_STR}:${PATH_STR}/custom-${ix}-launch/" "binding" "'${LTOGGLE_MAP["${ix}|keyb|launch"]}'"
        gsettings set "${SCHEMA_STR}:${PATH_STR}/custom-${ix}-capture/" "name"    "'ltoggle-capture_${ix}'"
        gsettings set "${SCHEMA_STR}:${PATH_STR}/custom-${ix}-capture/" "command" "'ltoggle-capture ${ix}'"
        gsettings set "${SCHEMA_STR}:${PATH_STR}/custom-${ix}-capture/" "binding" "'${LTOGGLE_MAP["${ix}|keyb|capture"]}'"
    fi
done

