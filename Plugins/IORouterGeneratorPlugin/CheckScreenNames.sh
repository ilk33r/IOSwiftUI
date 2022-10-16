#!/bin/sh

set -e
set -u
set -o pipefail

echo "CheckScreenNames"
echo "${0}"
echo "${1}"
echo "${2}"
echo "${3}"
echo "${4}"

function onError {
    echo "error: ${1}"; exit 1;
}

function removeGeneratedFolder {
    if [ -d "${1}" ]; then
        rm -rf "${1}"
        echo "Generated folder was removed."
    fi
}

function checkScreenNameInFile {
    local screenNames=("$@")
    local result="0"
    local snLen=${#screenNames[@]}
    
    for ((i=1; i<${snLen}; i++))
    do
        screenName="${screenNames[$i]}"
                    
        if [[ "${screenName}" == "${1}" ]]; then
            result="1"
            break
        fi
    done
    
    echo "${result}"
}

ARG_ROUTER_FILE="${2}/Generated/AppRouter.swift"
ARG_GENERATED_FILES_DIR="${2}/Generated"
ARG_TEMP_DIR="${2}/IORouterGenerator"
ARG_SCREEN_LIST_FILE="${2}/IORouterGenerator/Screens.filelist"

ARG_SCREEN_LIST=""
ARG_SCREEN_LIST_ARR=()

for ((i=5; i<=$#; i+=2))
do
    echo "Screen name: ${!i}"
    ARG_SCREEN_LIST+="${!i}\n"
    ARG_SCREEN_LIST_ARR+=("${!i}")
done

if [ ! -d "${ARG_TEMP_DIR}" ]; then
    echo "Creating temp dir."
    mkdir -p ${ARG_TEMP_DIR}
fi

if [ ! -f "${ARG_SCREEN_LIST_FILE}" ]; then
    touch ${ARG_SCREEN_LIST_FILE}
    echo "${ARG_SCREEN_LIST}" > ${ARG_SCREEN_LIST_FILE}
    echo "Screen file list generated."
    
    removeGeneratedFolder ${ARG_GENERATED_FILES_DIR}
else
    SCREENS_IN_FILE=()
    SCREEN_EXISTS="1"
    
    while IFS= read -r line
    do
        SCREENS_IN_FILE+=("${line}")
    done < "${ARG_SCREEN_LIST_FILE}"
    
    screenFileLen=${#SCREENS_IN_FILE[@]}
    let "screenFileLen--"
    screensLen=${#ARG_SCREEN_LIST_ARR[@]}
    
    if [ "${screenFileLen}" != "${screensLen}" ]; then
        echo "Screen count is not equal ${screenFileLen} ${screensLen}"
        SCREEN_EXISTS=0
    else
        for screenName in "${ARG_SCREEN_LIST_ARR[@]}"
        do
            SCREEN_EXISTS=$(checkScreenNameInFile "${screenName}" "${SCREENS_IN_FILE[@]}")
            echo "SCREEN_EXISTS = ${SCREEN_EXISTS} ${screenName}"
                
            if [ "${SCREEN_EXISTS}" == "0" ]; then
                break
            fi
        done
    fi

    if [ "${SCREEN_EXISTS}" == "0" ]; then
        echo "Screens file is not equal"
        rm -rf "${ARG_GENERATED_FILES_DIR}"
        rm -rf "${ARG_SCREEN_LIST_FILE}"
        
        touch ${ARG_SCREEN_LIST_FILE}
        echo "${ARG_SCREEN_LIST}" > ${ARG_SCREEN_LIST_FILE}
    else
        echo "Screens file is equal"
    fi
fi

if [ ! -d "${ARG_GENERATED_FILES_DIR}" ]; then
    mkdir -p ${ARG_GENERATED_FILES_DIR}
    echo "Could not found Generated folder."
    exit 0
fi

exit 0
