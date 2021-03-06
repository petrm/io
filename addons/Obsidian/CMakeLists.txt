# Base Io build system
# Written by Jeremy Tregunna <jeremy.tregunna@me.com>
#
# Builds the Obsidian addon

# Create the _build bundle hierarchy if needed.
make_build_bundle(_build)

# Output our dynamic library to the top-level _build hierarchy
set(LIBRARY_OUTPUT_PATH ${CMAKE_CURRENT_BINARY_DIR}/_build/dll)

# Generate the IoObsidianInit.c file.
# Argument SHOULD ALWAYS be the exact name of the addon, case is
# important.
generate_ioinit(Obsidian)

# Our library sources.
set(SRCS "${CMAKE_CURRENT_SOURCE_DIR}/source/IoObsidianInit.c")

# Now build the shared library
add_library(IoObsidian SHARED ${SRCS})
add_dependencies(IoObsidian iovmall)
target_link_libraries(IoObsidian iovmall)

# Install the addon to our global addons hierarchy.
install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} DESTINATION ${CMAKE_INSTALL_PREFIX}/lib/io/addons)
install(DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/_build DESTINATION ${CMAKE_INSTALL_PREFIX}/lib/io/addons/Obsidian)
