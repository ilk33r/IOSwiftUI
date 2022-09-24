#!/bin/sh

set -e
set -u
set -o pipefail

echo "CheckConfigurationFileHash"
echo "${0}"
echo "${1}"
echo "${2}"
echo "${3}"
echo "${4}"

function onError {
    echo "error: ${1}"; exit 1;
}

BCG_BUILDCONFIG_FILE="${2}/Generated/IOBuildConfig.swift"
BCG_CONFIGURATION_FILE="${1}/Files/Configuration.json"
BCG_GENERATED_FILES_DIR="${2}/Generated"
BCG_CHECKSUM_FILE="${2}/IOBuildConfigGenerator/Configuration.checksum.sha256"

if [ ! -f "${BCG_CONFIGURATION_FILE}" ]; then
    onError "Could not found Configuration.json file at path: ${1}/Files"
fi

if [ ! -d "${BCG_GENERATED_FILES_DIR}" ]; then
    mkdir -p ${BCG_GENERATED_FILES_DIR}
    echo "Could not found Generated folder."
    exit 0
fi

if [ ! -f "${BCG_CHECKSUM_FILE}" ]; then
    echo "Could not found Configuration.checksum.sha256 file."
    rm -rf "${BCG_BUILDCONFIG_FILE}"
    exit 0
fi

BCG_CONFIGURATION_FILE_CHECKSUM=$(cat "${BCG_CHECKSUM_FILE}")
echo "Configuration file last checksum: ${BCG_CONFIGURATION_FILE_CHECKSUM}"

BCG_CONFIGURATION_FILE_CALCULATED_CHECKSUM=$(shasum -a256 "${BCG_CONFIGURATION_FILE}")
echo "Configuration file calculated checksum: ${BCG_CONFIGURATION_FILE_CALCULATED_CHECKSUM}"

if [[ "${BCG_CONFIGURATION_FILE_CALCULATED_CHECKSUM}" == *"${BCG_CONFIGURATION_FILE_CHECKSUM}"* ]]; then
    echo "No changes found in Configuration file."
else
    echo "Removing generated Configuration file."
    rm -rf "${BCG_BUILDCONFIG_FILE}"
fi

exit 0
