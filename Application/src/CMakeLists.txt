project(Calendar VERSION 1.0)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_STANDARD 20)

find_package(Qt6 COMPONENTS Quick Core REQUIRED)

add_subdirectory(ui)
add_subdirectory(core)

add_executable(${PROJECT_NAME} WIN32
    main.cpp
)

target_include_directories(${PROJECT_NAME} PRIVATE ./ui)

target_link_libraries(${PROJECT_NAME}
    PRIVATE
        Qt6::Quick
        Qt6::Core
        ui
        core
)

