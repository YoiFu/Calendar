import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 2.15

import CPalette 1.0

Rectangle {
	id: root

	property bool isSolarCalendar: true

	implicitHeight: 26
	implicitWidth: 61

    color: CPalette.layer3

	radius: 4

	states: [
		State {
			name: "solar"
			when: isSolarCalendar
			PropertyChanges {
				target: calendarType
				text: "Solar"
			}
			PropertyChanges {
				target: icon
                source: "../assets/Solar.svg"
			}
		},
		State {
			name: "lunar"
			when: !isSolarCalendar
			PropertyChanges {
				target: calendarType
				text: "Lunar"
			}
			PropertyChanges {
				target: icon
                source: "../assets/Lunar.svg"
			}
		}
	]

	RowLayout {
		anchors.centerIn: parent

		spacing: 2

		Image {
			id: icon

			height: 20
			width: 20

			Layout.alignment: Qt.AlignVCenter
			fillMode: Image.PreserveAspectFit
		}

		Text {
			id: calendarType

            color: CPalette.layer1
			Layout.alignment: Qt.AlignVCenter
			font.pixelSize: 14
		}
	}

	ToolTip {
		id: tooltip

		delay: 1000
		timeout: 5000

		background: Rectangle {
			color: "yellow"
			radius: 4
		}
		contentItem: Text {
			text: "Custom styled tooltip"
			color: "black"
		}
	}

	MouseArea {
		anchors.fill: parent

		hoverEnabled: true

		onClicked: {
			isSolarCalendar = !isSolarCalendar
			tooltip.visible = false
		}

		onEntered: {
			tooltip.visible = true;
		}

		onExited: {
			tooltip.visible = false;
		}
	}
}
