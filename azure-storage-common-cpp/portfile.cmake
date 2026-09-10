vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Jinming-Hu/azure-sdk-for-cpp
    REF 8fa43f90c4f2659c0d6ef2db2bdee4695f5fa745
    SHA512 7fefea6ebb845d60fda36b98758eff72bcab1f92bfa5551265a37f6d37110e53a1318ce49390630b9065d9f6b6681dc2d83b9947c739332f8c065be06ffd0f65
    HEAD_REF private_drop_stg105_ref
)

file(GLOB_RECURSE unused "${SOURCE_PATH}/cgmanifest.json")
file(REMOVE_RECURSE ${unused})

file(GLOB_RECURSE unused "${SOURCE_PATH}/Cargo.toml")
file(REMOVE_RECURSE ${unused})

file(GLOB_RECURSE unused "${SOURCE_PATH}/Cargo.lock")
file(REMOVE_RECURSE ${unused})

if(EXISTS "${SOURCE_PATH}/sdk/storage/azure-storage-common")
  file(REMOVE_RECURSE "${SOURCE_PATH}/sdk/storage/_")
  file(REMOVE_RECURSE "${SOURCE_PATH}/sdk/_")
  file(REMOVE_RECURSE "${SOURCE_PATH}/_")

  file(RENAME "${SOURCE_PATH}/sdk/storage/azure-storage-common" "${SOURCE_PATH}/sdk/storage/_")
  file(RENAME "${SOURCE_PATH}/sdk/storage" "${SOURCE_PATH}/sdk/_")
  file(RENAME "${SOURCE_PATH}/sdk" "${SOURCE_PATH}/_")
endif()

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}/_/_/_"
    OPTIONS
        -DWARNINGS_AS_ERRORS=OFF
        -DBUILD_TESTING=OFF
)

vcpkg_cmake_install()
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
vcpkg_cmake_config_fixup()
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")
vcpkg_copy_pdbs()
