import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material

Switch {
    id: mySwitch

    property color checkedColor: "#79D7BE"
    property color uncheckedColor: "#E5E5E5"

    width: 30
    height: 16

    anchors.centerIn: parent

    indicator: Rectangle {
        anchors.fill: parent

        radius: height/2
        color: mySwitch.checked ? mySwitch.checkedColor : mySwitch.uncheckedColor

        Rectangle {
            x: mySwitch.checked ? parent.width - width - 2 : 1
            width: mySwitch.checked ? parent.height - 4 : parent.height - 2
            height: width
            radius: width
            anchors.verticalCenter: parent.verticalCenter
            color: "#FFFFFF"

            Behavior on x {
                NumberAnimation { duration: 200 }
            }
        }
    }
}
