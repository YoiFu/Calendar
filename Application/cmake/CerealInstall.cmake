set(CEREAL_DIR ${CMAKE_BINARY_DIR})

if (NOT EXISTS "${CEREAL_DIR}/cereal-master")
    message(STATUS "Downloading Cereal...")
    file(DOWNLOAD
        "https://github.com/USCiLab/cereal/archive/refs/heads/master.zip"
        "${CEREAL_DIR}/cereal-master.zip")

    # expand cereal zip file
    execute_process(
        COMMAND powershell -Command "Expand-Archive -Path \"${CEREAL_DIR}/cereal-master.zip\" -DestinationPath \"${CEREAL_DIR}\""
        RESULT_VARIABLE EXPAND_RESULT
        ERROR_VARIABLE EXPAND_ERROR
    )
    if (NOT ${EXPAND_RESULT} EQUAL 0)
        message(FATAL_ERROR "Failed to expand archive: ${EXPAND_ERROR}")
    endif()

    # remove cereal zip file
    execute_process(
        COMMAND powershell -Command "del \"${CEREAL_DIR}/cereal-master.zip\""
    )
else()
    message(STATUS "Cereal already exists. Skipping download.")
endif()

set(CEREAL_INCLUDE_DIR "${CEREAL_DIR}/cereal-master/include" CACHE STRING "Path to Cereal include directory")
