#!/bin/sh

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
PROJECTPATH="$( cd "${SCRIPTPATH}/../.." ; pwd -P )"

# check swiftgen installed
if ! which swiftgen >/dev/null; then
    echo "warning: SwiftGen not installed, download it from https://github.com/AliSoftware/SwiftGen"
    exit 1
fi

# Generate the strings file
swiftgen \
    strings \
    -o "${PROJECTPATH}/NewsApp/Resources/Autogenerated/Localized.swift" \
    --templatePath "${PROJECTPATH}/Scripts/Swiftgen/strings-flat-swift4.stencil" \
    --param className=Localized \
    --param publicAccess=true \
    "${PROJECTPATH}/NewsApp/Resources/en.lproj/Localizable.strings"


# Generate the assets file
swiftgen \
    xcassets \
    -o "${PROJECTPATH}/NewsApp/Resources/Autogenerated/Assets.swift" \
    --templatePath "${PROJECTPATH}/scripts/swiftgen/assets-swift4.stencil" \
    --param enumName=Assets \
    --param publicAccess=true \
    "${PROJECTPATH}/NewsApp/Resources/Assets.xcassets"

exit 0
