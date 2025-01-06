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
        components/CustomToggle.qml
        components/SliderWithToolTips.qml
        components/IconButton.qml
        components/MaskedImage.qml
        components/CustomTooltip.qml
        components/FolderInsert.qml
        settings/Settings.qml
        settings/ColorPickerPopup.qml
        settings/ColorPicker.qml
        settings/ColorAlphaSlider.qml
        settings/ColorDetails.qml
        settings/ColorCircle.qml
        settings/ColorPickerContent.qml
        settings/ColorTemplate.qml
        settings/ColorCustomList.qml
        js_functions/FunctionUtils.js
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
        assets/Plus.svg
        assets/More.svg
        assets/Less.svg
        assets/Brightness-increase.svg
        assets/Brightness-decrease.svg
        assets/Transparent.svg
        assets/Solid.svg
        assets/File.svg
)

target_link_libraries(${PROJECT_NAME} 
    PUBLIC 
        Qt6::Quick
        Qt6::Qml
        Qt6::Core
)

target_include_directories(${PROJECT_NAME} PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
