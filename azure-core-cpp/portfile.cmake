# NOTE: All changes made to this file will get overwritten by the next port release.
# Please contribute your changes to https://github.com/Azure/azure-sdk-for-cpp.

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Jinming-Hu/azure-sdk-for-cpp
    REF 034910ca60673e0445c42a5bcf93bd23bf43a24a
    SHA512 e10c740b44af8544ed6ddeb7bd1d50e6bae9c8181ec7300c5dd2f1143ddd162bb4bed0a3fc3d82524509cb09afabb65f83a5618ad41423bc4a0f20c44906f02e
    HEAD_REF main
)

vcpkg_check_features(
    OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        curl BUILD_TRANSPORT_CURL
        winhttp BUILD_TRANSPORT_WINHTTP
)

file(GLOB_RECURSE unused "${SOURCE_PATH}/cgmanifest.json")
file(REMOVE_RECURSE ${unused})

if(EXISTS "${SOURCE_PATH}/sdk/core/azure-core")
  file(REMOVE_RECURSE "${SOURCE_PATH}/sdk/core/_")
  file(REMOVE_RECURSE "${SOURCE_PATH}/sdk/_")
  file(REMOVE_RECURSE "${SOURCE_PATH}/_")

  file(RENAME "${SOURCE_PATH}/sdk/core/azure-core" "${SOURCE_PATH}/sdk/core/_")
  file(RENAME "${SOURCE_PATH}/sdk/core" "${SOURCE_PATH}/sdk/_")
  file(RENAME "${SOURCE_PATH}/sdk" "${SOURCE_PATH}/_")
endif()

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}/_/_/_"
    OPTIONS
        ${FEATURE_OPTIONS}
        -DWARNINGS_AS_ERRORS=OFF
        -DBUILD_TESTING=OFF
        -DNO_AUTOMATIC_TRANSPORT_BUILD=ON
)

vcpkg_cmake_install()
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
vcpkg_cmake_config_fixup()
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")
vcpkg_copy_pdbs()
