# Set IDF_PATH, as nothing else will work without this
SET(CMAKE_SYSTEM_NAME Generic)
set(PROJECT_TARGET "EmbeddedConnectivity")
set(PROJECT_OS_TARGET "freertos")
set(ETL_PROFILE "PROFILE_GCC_GENERIC")
set(PROJECT_PROCESSOR "esp32")

set(PROJECT_C_WARNING_FLAGS "-Wall -Wextra -Wno-strict-aliasing -Wno-implicit-function-declaration  -Wno-frame-address ")
set(PROJECT_CXX_WARNING_FLAGS "-Wall -Wextra -Wnon-virtual-dtor  -Wunused -Woverloaded-virtual  -Wdouble-promotion -Wformat=2 -Wlogical-op  -Wno-frame-address ")
set(ESP32_COMPILER_DEFINITIONS "-DESP_PLATFORM -D__CLANG_ATOMICS -DPROFILE_GCC_GENERIC -DPROJECT_FREERTOS -DESP32_FREERTOS -DSDK_DEBUGCONSOLE=1 -DPRINTF_FLOAT_ENABLE=0 -DSCANF_FLOAT_ENABLE=0 -DPRINTF_ADVANCED_ENABLE=0 -DSCANF_ADVANCED_ENABLE=0 -DCR_INTEGER_PRINTF -D__STARTUP_CLEAR_BSS -D__STARTUP_INITIALIZE_NONCACHEDATA -D_POSIX_MONOTONIC_CLOCK -mlongcalls ")

set(IDF_PATH "$ENV{IDF_PATH}")
if(NOT IDF_PATH)
    # Documentation says you should set IDF_PATH in your environment
	message(FATAL_ERROR, "The IDF_PATH Environment Variable is not set. SET it to the esp-idf path")
endif()

file(TO_CMAKE_PATH "${IDF_PATH}" IDF_PATH)
message("IDF_PATH = ${IDF_PATH}")

# set the tool chain path for compilers to be found
set(IDF_TOOLS_PATH "$ENV{IDF_TOOLS_PATH}")
file(TO_CMAKE_PATH "${IDF_TOOLS_PATH}" IDF_TOOLS_PATH)

message("IDF_TOOLS_PATH = ${IDF_TOOLS_PATH}")


#LIST(APPEND CMAKE_PROGRAM_PATH  "${IDF_TOOLS_PATH}\\tools\\mconf\\v4.6.0.0-idf-20190628")
message("PATH=$ENV{PATH}")
include(${IDF_PATH}\\tools\\cmake\\toolchain-esp32.cmake)
#include(${IDF_PATH}\\tools\\cmake\\project.cmake)
set(CMAKE_FIND_ROOT_PATH ${TOOLCHAIN_PATH})
set(CMAKE_TRY_COMPILE_TARGET_TYPE "STATIC_LIBRARY")


# Set some compiler flags
set(CMAKE_C_FLAGS "${ESP32_COMPILER_DEFINITIONS} ${PROJECT_C_WARNING_FLAGS} " CACHE INTERNAL "C compiler options" FORCE)
set(CMAKE_CXX_FLAGS "${ESP32_COMPILER_DEFINITIONS} ${PROJECT_CXX_WARNING_FLAGS} " CACHE INTERNAL "C++ compiler options" FORCE)
set(CMAKE_ASM_FLAGS "${ESP32_COMPILER_DEFINITIONS} ${PROJECT_C_WARNING_FLAGS} " CACHE INTERNAL "ASM compiler options" FORCE)
#set(CMAKE_EXE_LINKER_FLAGS "-Wl,-print-memory-usage -Wl,--sort-section=alignment -Wl,--as-needed --specs=nosys.specs --specs=nano.specs" CACHE INTERNAL "Linker options" FORCE)
#set(CMAKE_EXE_LINKER_FLAGS "-Wl,--sort-section=alignment -Wl,--as-needed " CACHE INTERNAL "Linker options" FORCE)

# Options for DEBUG build
set(CMAKE_C_FLAGS_DEBUG "-Og -ggdb -DDEBUG" CACHE INTERNAL "C Compiler options for debug build type" FORCE)
set(CMAKE_CXX_FLAGS_DEBUG "-Og -ggdb -DDEBUG" CACHE INTERNAL "C++ Compiler options for debug build type" FORCE)
set(CMAKE_ASM_FLAGS_DEBUG "-DDEBUG" CACHE INTERNAL "ASM Compiler options for debug build type" FORCE)
#set(CMAKE_EXE_LINKER_FLAGS_DEBUG "-Wl,-O0" CACHE INTERNAL "Linker options for debug build type" FORCE)

# Options for RELEASE with debug information build
set(CMAKE_C_FLAGS_RELWITHDEBINFO "-O2 -ggdb -DNDEBUG" CACHE INTERNAL "C Compiler options for release with debug info build type" FORCE)
set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "-O2 -ggdb -DNDEBUG" CACHE INTERNAL "C++ Compiler options for release with debug info build type" FORCE)
set(CMAKE_ASM_FLAGS_RELWITHDEBINFO "-DNDEBUG" CACHE INTERNAL "ASM Compiler options for release with debug info build type" FORCE)
set(CMAKE_EXE_LINKER_FLAGS_RELWITHDEBINFO "-Wl,-O1" CACHE INTERNAL "Linker options for release with debug info build type" FORCE)

# Options for RELEASE build
set(CMAKE_C_FLAGS_RELEASE "-Os -DNDEBUG" CACHE INTERNAL "C Compiler options for release build type" FORCE)
set(CMAKE_CXX_FLAGS_RELEASE "-Os -DNDEBUG" CACHE INTERNAL "C++ Compiler options for release build type" FORCE)
set(CMAKE_ASM_FLAGS_RELEASE "-DNDEBUG" CACHE INTERNAL "ASM Compiler options for release build type" FORCE)
set(CMAKE_EXE_LINKER_FLAGS_RELEASE "-Wl,-O1" CACHE INTERNAL "Linker options for release build type" FORCE)

set(CMAKE_EXE_LINKER_FLAGS "-nostdlib -Wl,--no-check-sections -u call_user_start -Wl,-static " CACHE STRING "Linker Base Flags")

# Set the include path for all the components from ESP-IDF

include_directories(${TOOLCHAIN_DIR}\\xtensa-esp32-elf\\sysroot\\usr\\include)
link_directories(${TOOLCHAIN_DIR}\\xtensa-esp32-elf\\sysroot\\usr\\lib)
