import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

import ui.components 1.0
import CPalette 1.0

Item {
	id: root

	implicitHeight: 320
	implicitWidth: 340

	property QtObject temporalObject: null

	signal openSettings

	Image  {
		id: img

		property bool rounded: true
		property bool adapt: true

		anchors.fill: parent
		visible: true
		fillMode: Image.PreserveAspectCrop
		source: "file:///C:/Project/Calendar/Application/fantasy-scene-anime-style.jpg"
		layer.enabled: rounded
		layer.effect: OpacityMask {
			maskSource: Rectangle {
				anchors.centerIn: parent
				width: img.adapt ? img.width : Math.min(img.width, img.height)
				height: img.adapt ? img.height : width
				radius: internal.radius

				color: "red"
			}
		}
	}

	Rectangle {
		anchors.fill: parent

		radius: internal.radius
		// color: CPalette.background2

		color: "transparent"
		ColumnLayout {
			id: content

			anchors {
				top: parent.top
				horizontalCenter: parent.horizontalCenter
				topMargin: 10
			}

			spacing: 0

			RowLayout {
				Layout.fillWidth: true

				MouseArea {
					id: mouseArea

					implicitHeight: 14
					implicitWidth: 14

					Layout.leftMargin: 2
					Layout.alignment: Qt.AlignVCenter
					hoverEnabled: true

					Image {
						id: settingsIcon

						anchors.fill: parent

						source: "../assets/Settings.svg"

						ColorOverlay {
							anchors.fill: parent
							source: settingsIcon
							color: mouseArea.containsMouse ? "#D5D5D5" : "#9B9B9B"
						}
					}

					onClicked: {
						root.openSettings();
					}
				}

				Item {
					Layout.fillWidth: true
				}

				Function {
					Layout.alignment: Qt.AlignVCenter
					onHide: function() {

					}
					onShrink: function() {

					}
					onClose: function() {
					}
				}
			}

			RowLayout {
				id: calendarAdjust

				Layout.alignment: Qt.AlignHCenter
				Layout.topMargin: 8

				TimelineBar{
					id: timelineBar

					Layout.preferredWidth: 230

					temporalObject: root.temporalObject

					onOpenMonthSelectionPopup: {
						monthSelectionPopup.open();
					}
				}

				Item {
					Layout.fillWidth: true
				}

				CustomSwitch {
					id: calendarType
				}
			}

			Days {
				id: daysView

				Layout.alignment: Qt.AlignHCenter
				Layout.topMargin: 6

				temporalObject: root.temporalObject
			}
		}
	}

	MonthSelectionPopup {
		id: monthSelectionPopup

		anchors.centerIn: parent
		temporalObject: root.temporalObject
	}

	QtObject {
		id: internal

		readonly property int radius: 8
	}
}
