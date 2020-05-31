cmake_minimum_required(VERSION 3.5)

project(esp32ProjectTemplate C CXX)



# Include for ESP-IDF build system functions

include(${IDF_PATH}/tools/cmake/idf.cmake)

# Create idf::esp32 and idf::freertos static libraries
idf_build_process(esp32
                # try and trim the build; additional components
                # will be included as needed based on dependency tree
                #
                # although esptool_py does not generate static library,
                # processing the component is needed for flashing related
                # targets and file generation
                COMPONENTS esp32 freertos esptool_py SPIbus I2Cbus
                SDKCONFIG ${CMAKE_CURRENT_SOURCE_DIR}/sdkconfig
                BUILD_DIR ${CMAKE_BINARY_DIR})


set(elf_file ${CMAKE_PROJECT_NAME}.elf)
add_executable(${elf_file} src/main.cpp )

# Link the static libraries to the executable

target_link_libraries(${elf_file} idf::esp32 idf::freertos idf::spi_flash idf::SPIbus idf::I2Cbus)
# Attach additional targets to the executable file for flashing,
# linker script generation, partition_table generation, etc.
idf_build_executable(${elf_file})

include_directories( "." 
	                "include"
					)

set_target_properties(${elf_file} PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}
	)
set(CMAKE_EXPORT_COMPILE_COMMANDS 1)