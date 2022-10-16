#!/bin/sh

set -e
set -u
set -o pipefail

echo "GenerateAppRouter"
echo "${0}"
echo "${1}"
echo "${2}"
echo "${3}"
echo "${4}"

function onError {
    echo "error: ${1}"; exit 1;
}

ARG_ROUTER_FILE="${2}/Generated/AppRouter.swift"

if [ -f "${ARG_ROUTER_FILE}" ]; then
    echo "Generated file exists."
    exit 0
fi

ARG_FILE_CONTENT="import Foundation\n"
ARG_FILE_CONTENT+="import IOSwiftUIPresentation\n"
ARG_FILE_CONTENT+="import IOSwiftUIRouter\n"

for ((i=5; i<=$#; i+=2))
do
    echo "Screen name: ${!i}"
    ARG_FILE_CONTENT+="import ${!i}\n"
done

ARG_FILE_CONTENT+="\n"
ARG_FILE_CONTENT+="@objc(AppRouter)\n"
ARG_FILE_CONTENT+="final public class AppRouter: NSObject, IORouterProtocol {\n"
ARG_FILE_CONTENT+="\n"
ARG_FILE_CONTENT+="\tpublic static var _screens: [String : any IOController.Type] = [\n"

for ((i=6; i<=$#; i+=2))
do
    VIEWS_FOLDER="${!i}/Views"
    echo "Screen views folder: ${VIEWS_FOLDER}"
    
    for file in "${VIEWS_FOLDER}"/*
    do
        if [[ "${file}" == *"View.swift" ]]; then
            IFS='/' read -r -a array <<< "${file}"
            FILE_NAME="${array[@]: -1:1}"
            IFS='.' read -r -a array <<< "${FILE_NAME}"
            CLASS_NAME="${array[0]}"
            ARG_FILE_CONTENT+="\t\t\"${CLASS_NAME}\": ${CLASS_NAME}.self,\n"
        fi
    done
done

ARG_FILE_CONTENT+="\t]\n"
ARG_FILE_CONTENT+="\n"
ARG_FILE_CONTENT+="\tpublic static func _instance(controllerName: String, entity: IOEntity?) -> any IOController {\n"
ARG_FILE_CONTENT+="\t\tguard let controller = self._screens[controllerName] else {\n"
ARG_FILE_CONTENT+="\t\t\tfatalError(\"View with name \(controllerName) could not found\")\n"
ARG_FILE_CONTENT+="\t\t}\n"
ARG_FILE_CONTENT+="\n"
ARG_FILE_CONTENT+="\t\treturn controller.init(entity: entity)\n"
ARG_FILE_CONTENT+="\t}\n"
ARG_FILE_CONTENT+="}\n"

touch ${ARG_ROUTER_FILE}
echo "${ARG_FILE_CONTENT}" > ${ARG_ROUTER_FILE}

exit 0
