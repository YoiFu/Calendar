import QtQuick
import QtQuick.Window

import ui.calendar 1.0
import ui.settings 1.0
import TemporalUnit 1.0
import CPalette 1.0

Window {
    id: root

    height: 500
    width: 700

    visible: true
    title: qsTr("Hello World")

    color: "transparent"

    flags: Qt.Window | Qt.FramelessWindowHint | Qt.WindowMinMaxButtonsHint

    Calendar {
        id: calendar
        temporalObject: TemporalUnit

        anchors {
            right: parent.right
            verticalCenter: parent.verticalCenter
        }

        onOpenSettings: {
            settings.visible = !settings.visible
        }
    }

    Settings {
        id: settings

        visible: false

        anchors {
            right: calendar.left
			rightMargin: 4
            verticalCenter: parent.verticalCenter
        }
    }

    Component.onCompleted: {
        console.log(calendar.Window.window)
        console.log(root)
    }
}
