import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material

Switch {
    id: root

    width: 30
    height: 16

    anchors.centerIn: parent

    indicator: Rectangle {
        anchors.fill: parent

        radius: height/2
        color: root.checked ? internal.checkedColor : internal.uncheckedColor

        Rectangle {
            x: root.checked ? parent.width - width - 2 : 1
            width: root.checked ? parent.height - 4 : parent.height - 2
            height: width
            radius: width
            anchors.verticalCenter: parent.verticalCenter
            color: "#FFFFFF"

            Behavior on x {
                NumberAnimation { duration: 200 }
            }
        }
    }

    QtObject {
        id: internal

        property color checkedColor: "#79D7BE"
        property color uncheckedColor: "#E5E5E5"
    }
}
