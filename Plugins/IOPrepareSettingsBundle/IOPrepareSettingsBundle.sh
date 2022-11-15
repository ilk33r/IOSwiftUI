#!/bin/bash

set -e
set -u
set -o pipefail

echo "CheckConfigurationFileHash"
echo "${0}"
echo "${1}"
echo "${2}"

PLIST_BUDDY="/usr/libexec/PlistBuddy"
ENVIRONMENT_NAME="${1}"
SETTINGS_PLIST_FILE="${2}"
APP_VERSION="${MARKETING_VERSION} (${CURRENT_PROJECT_VERSION})"

PLIST_LINES=$(${PLIST_BUDDY} ${SETTINGS_PLIST_FILE} -c "Print :PreferenceSpecifiers" | tr -d ' ')

PLIST_COUNTER=0
PLIST_VALUES=()

BRACE_OPEN="0"
BRACE_ARR_OPEN="0"

for PLIST_ITEMS in $PLIST_LINES;
do
    if [[ "${PLIST_ITEMS}" == "Dict{" ]]; then
        BRACE_OPEN="1"
    elif [[ "${BRACE_ARR_OPEN}" == "1" && "${PLIST_ITEMS}" == "}" ]]; then
        BRACE_ARR_OPEN="0"
    elif [[ "${BRACE_OPEN}" == "1" && "${BRACE_ARR_OPEN}" == "0" && "${PLIST_ITEMS}" == "}" ]]; then
        BRACE_OPEN="0"
    elif [[ "${BRACE_OPEN}" == "1" && "${BRACE_ARR_OPEN}" == "0" ]]; then
        KEY=$(echo ${PLIST_ITEMS} | cut -d= -f1)
        ITEM_VALUE=$(echo ${PLIST_ITEMS} | cut -d= -f2)
        if [[ "${KEY}" == "Title" ]]; then
            PLIST_VALUES+=("${ITEM_VALUE}")
            PLIST_COUNTER=${PLIST_COUNTER}+1
            BRACE_OPEN="0"
        elif [[ "${KEY}" == "Key" ]]; then
            PLIST_VALUES+=("${ITEM_VALUE}")
            PLIST_COUNTER=${PLIST_COUNTER}+1
            BRACE_OPEN="0"
        elif [[ "${ITEM_VALUE}" == "Array{" ]]; then
            BRACE_ARR_OPEN="1"
        fi
    fi
done

CURRENT_ARR_INDEX=0
for ((i=0; i<${PLIST_COUNTER}; i+=1))
do
    KEY="${PLIST_VALUES[i]}"
    if [[ "${ENVIRONMENT_NAME}" == "Release" && "${KEY}" == "debug"* ]]; then
        ${PLIST_BUDDY} ${SETTINGS_PLIST_FILE} -c "Delete :PreferenceSpecifiers:${CURRENT_ARR_INDEX} dict"
        echo "Removing index ${i} ${CURRENT_ARR_INDEX} ${KEY}"
        ((CURRENT_ARR_INDEX=CURRENT_ARR_INDEX-1))
    fi
    
    if [[ "${KEY}" == "Version" ]]; then
        ${PLIST_BUDDY} ${SETTINGS_PLIST_FILE} -c "Set :PreferenceSpecifiers:${CURRENT_ARR_INDEX}:DefaultValue '${APP_VERSION}'"
    fi
    
    ((CURRENT_ARR_INDEX=CURRENT_ARR_INDEX+1))
done





