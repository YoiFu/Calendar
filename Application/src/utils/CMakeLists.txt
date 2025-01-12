project(utils)

find_package(Qt6 COMPONENTS Core Gui REQUIRED)

set(sources
    ProfileUtils.cpp
)

set(headers
    ProfileData.h
    ProfileUtils.h
)

add_library(${PROJECT_NAME} ${sources} ${headers})

target_link_libraries(${PROJECT_NAME} PUBLIC Qt6::Core Qt6::Gui)

target_include_directories(${PROJECT_NAME} PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
