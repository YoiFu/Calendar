project(model)

find_package(Qt6 COMPONENTS Core Widgets REQUIRED)

set(CMAKE_AUTOMOC ON)

set(sources
    SettingsModel.cpp
    PaletteModel.cpp
    ProfileSavingModel.cpp
)

set(headers
    SettingsModel.h
    PaletteModel.h
    ProfileSavingModel.h
)

add_library(${PROJECT_NAME} ${sources} ${headers})

target_link_libraries(${PROJECT_NAME} PUBLIC
    core
    utils
    Qt6::Core
    Qt6::Widgets
)

target_include_directories(${PROJECT_NAME} PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
