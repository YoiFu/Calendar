project(model)

find_package(Qt6 COMPONENTS Core REQUIRED)

set(CMAKE_AUTOMOC ON)

set(sources
    SettingsModel.cpp
    PaletteModel.cpp
)

set(headers
    SettingsModel.h
    PaletteModel.h
)

add_library(${PROJECT_NAME} ${sources} ${headers})

target_link_libraries(${PROJECT_NAME} PUBLIC
    core
    Qt6::Core
)

target_include_directories(${PROJECT_NAME} PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
