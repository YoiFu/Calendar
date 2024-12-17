project(ui)

find_package(Qt6 COMPONENTS Quick Qml Core REQUIRED)

add_library(${PROJECT_NAME})

qt_policy(SET QTP0001 NEW)

qt_add_qml_module(${PROJECT_NAME}
    URI ui
    VERSION 1.0
    QML_FILES
        Main.qml
        calendar/Days.qml
        calendar/MonthSelectionPopup.qml
        calendar/Calendar.qml
        calendar/TimelineBar.qml
        components/CustomSwitch.qml
        components/Function.qml
        settings/Settings.qml
        settings/ColorPickerPopup.qml
        settings/ColorPicker.qml
    RESOURCES
        qmldir
        components/qmldir
        calendar/qmldir
        settings/qmldir
        assets/Arrow.svg
        assets/Close.svg
        assets/Hide.svg
        assets/Lunar.svg
        assets/Shrink.svg
        assets/Solar.svg
        assets/Settings.svg
        assets/RGBAColor.png
)

target_link_libraries(${PROJECT_NAME} 
    PUBLIC 
        Qt6::Quick
        Qt6::Qml
        Qt6::Core
)

target_include_directories(${PROJECT_NAME} PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
