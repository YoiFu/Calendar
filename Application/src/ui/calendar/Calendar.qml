import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

import ui.components 1.0
import CPalette 1.0

Rectangle {
	id: root

    implicitHeight: 270
	implicitWidth: 300

	property QtObject temporalObject: null

    signal openSettings

	radius: 8

    color: CPalette.background2

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

            spacing: 6

            TimelineBar{
                id: timelineBar

                temporalObject: root.temporalObject

                onOpenMonthSelectionPopup: {
                    monthSelectionPopup.open();
                }
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

	MonthSelectionPopup {
		id: monthSelectionPopup

		anchors.centerIn: parent
		temporalObject: root.temporalObject
	}
}
