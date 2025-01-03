import QtQuick
import QtQuick.Window

import ui.calendar 1.0
import ui.settings 1.0
import TemporalUnit 1.0
import CPalette 1.0
import settings 1.0

Window {
	id: root

	property int componentSpacing: 4

	height: 600
	width: calendar.width + settings.width + root.componentSpacing

	visible: true
	title: qsTr("Hello World")

	color: "transparent"

	flags: Qt.Window | Qt.FramelessWindowHint | Qt.WindowMinMaxButtonsHint

	SettingsModel{
		id: settingsModel
	}

	Calendar {
		id: calendar

		temporalObject: TemporalUnit
		settingsModel: settingsModel

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

		anchors {
			right: calendar.left
			rightMargin: root.componentSpacing
			verticalCenter: parent.verticalCenter
		}

		model: settingsModel
		height: calendar.height
		visible: false
	}
}
