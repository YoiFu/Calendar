import QtQuick
import QtQuick.Window

import ui.calendar 1.0
import ui.settings 1.0
import TemporalUnit 1.0
import CPalette 1.0

Window {
    id: root

    readonly property int spacing: 4

    height: calendar.height
    width: calendar.width + settings.width + spacing

    visible: true
    title: qsTr("Hello World")

    color: "transparent"

    flags: Qt.Window | Qt.FramelessWindowHint | Qt.WindowMinMaxButtonsHint

    Calendar {
        id: calendar
        temporalObject: TemporalUnit

        anchors {
            right: parent.right
            top: parent.top
        }

        onOpenSettings: {
            settings.visible = !settings.visible
        }
    }

    Settings {
        id: settings

        visible: false

        anchors {
            left: parent.left
            top: parent.top
        }
    }

    Component.onCompleted: {
        console.log(calendar.Window.window)
        console.log(root)
    }
}
