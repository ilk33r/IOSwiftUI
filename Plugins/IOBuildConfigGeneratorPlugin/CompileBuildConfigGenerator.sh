#!/bin/sh

set -e
set -u
set -o pipefail

echo "CompileBuildConfigGenerator"
echo "${0}"
echo "${1}"
echo "${2}"
echo "${3}"
echo "${4}"

BCG_BUILDCONFIG_FILE="${2}/Generated/IOBuildConfig.swift"
BCG_CONFIG_FILE_ROOT="${1}"
BCG_APP_NAME="IOBuildConfig"
BCG_SOURCE_ROOT="${4}/Plugins/IOBuildConfigGenerator"
BCG_DESTINATION_BUILD_DIR="${2}/IOBuildConfigGenerator"
BCG_GENERATED_FILES_DIR="${2}/Generated"
BCG_ENVIRONMENT_FILE="${2}/IOBuildConfigGenerator/Configuration.env"

BCG_CLANG=$(which clang)

function compileBuildConfig {
    BCG_MAC_OSX_MIN_VERSION="10.11"
    
    BCG_XCODE_DIRECTORY=$(xcode-select -p)
    BCG_OSX_SDK_DIR=${BCG_XCODE_DIRECTORY}/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk
    
    BCG_CLANG_FLAGS="-DRELEASE=1 -std=gnu17 -stdlib=libc++ -fobjc-arc -isysroot ${BCG_OSX_SDK_DIR} -mmacosx-version-min=${BCG_MAC_OSX_MIN_VERSION} -I${BCG_SOURCE_ROOT}"
    BCG_COMPILER_FLAGS="-x objective-c ${BCG_CLANG_FLAGS}"
    
    BCG_LINKER_FLAGS="${BCG_CLANG_FLAGS} -Xlinker -add_ast_path -Xlinker -no_deduplicate -framework Foundation"
    
    # Compile Build config generator
    $BCG_CLANG -x c ${BCG_COMPILER_FLAGS} -c "${BCG_SOURCE_ROOT}/IOBuildConfigGenerator.m" -o "${BCG_DESTINATION_BUILD_DIR}/IOBuildConfigGenerator.o"
    $BCG_CLANG -x c ${BCG_COMPILER_FLAGS} -c "${BCG_SOURCE_ROOT}/${BCG_APP_NAME}.m" -o "${BCG_DESTINATION_BUILD_DIR}/${BCG_APP_NAME}.o"
    
    # Link Build Config Generator
    $BCG_CLANG ${BCG_LINKER_FLAGS} "${BCG_DESTINATION_BUILD_DIR}/IOBuildConfigGenerator.o" "${BCG_DESTINATION_BUILD_DIR}/${BCG_APP_NAME}.o" -o "${BCG_DESTINATION_BUILD_DIR}/${BCG_APP_NAME}"
}

function generateConfigurationFiles {
    echo "Command executing ${BCG_DESTINATION_BUILD_DIR}/${BCG_APP_NAME} ${BCG_GENERATED_FILES_DIR} Files/Configuration.json ${CONFIGURATION} ${BCG_CONFIG_FILE_ROOT}"
    ${BCG_DESTINATION_BUILD_DIR}/${BCG_APP_NAME} "${BCG_GENERATED_FILES_DIR}" "Files/Configuration.json" "${CONFIGURATION}" "${BCG_CONFIG_FILE_ROOT}" "${BCG_DESTINATION_BUILD_DIR}"
}

# Check destination root dir is not exists
if [ ! -d "${BCG_DESTINATION_BUILD_DIR}" ]; then
    # Then create directory
    mkdir -p ${BCG_DESTINATION_BUILD_DIR}
fi

# Check build config binary is not exists
if [ ! -f "${BCG_DESTINATION_BUILD_DIR}/${BCG_APP_NAME}" ]; then
    compileBuildConfig
fi

if [ ! -d "${BCG_GENERATED_FILES_DIR}" ]; then
    # Then create directory
    mkdir -p ${BCG_GENERATED_FILES_DIR}
fi

if [ ! -f "${BCG_BUILDCONFIG_FILE}" ]; then
    generateConfigurationFiles
    exit 0
fi

if [ -f "${BCG_GENERATED_FILES_DIR}/Configuration.checksum.sha256" ]; then
    echo "Configuration library exists."
    exit 0
fi

if [ -f "${BCG_ENVIRONMENT_FILE}" ]; then
    BCG_CONFIGURATION_ENVIRONMENT=$(cat "${BCG_ENVIRONMENT_FILE}")
    echo "Configuration file last environment: ${BCG_CONFIGURATION_ENVIRONMENT}"

    if [[ "${BCG_CONFIGURATION_ENVIRONMENT}" == "${CONFIGURATION}" ]]; then
        echo "No environment changes found in Configuration file."
        exit 0
    else
        echo "Removing generated Configuration file for environment change."
        rm -rf "${BCG_BUILDCONFIG_FILE}"
    fi
fi

generateConfigurationFiles

exit 0
