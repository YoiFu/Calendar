project(core)

find_package(Qt6 COMPONENTS Core Quick Gui REQUIRED)

set(CMAKE_AUTOMOC ON)

set(sources
    Palette.cpp
    TemporalUnit.cpp
    PaletteModel.cpp
)

set(headers
    Palette.h
    TemporalUnit.h
    PaletteModel.h
)

add_library(${PROJECT_NAME} ${sources} ${headers})

target_link_libraries(${PROJECT_NAME}
    PUBLIC
        Qt6::Core
        Qt6::Quick
        Qt6::Gui
)

target_include_directories(${PROJECT_NAME} PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
