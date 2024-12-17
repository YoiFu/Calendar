import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import TemporalUnit 1.0
import CPalette 1.0

Rectangle {
	id: root

	property QtObject temporalObject: nullptr

	signal openMonthSelectionPopup();

	implicitHeight: 26
	width: 212

	radius: 20

    color: CPalette.layer3

	component CButton: Rectangle{
		id: btn

		property alias rotate: arrow.rotation

		signal clicked();

		height: 20
		width: 20
		radius: width


        color: CPalette.layer4

		Image {
			id: arrow

			height: 24
			width: 24
			anchors.centerIn: parent

			fillMode: Image.PreserveAspectFit

            source: "../assets/Arrow.svg"
		}

		MouseArea {
			anchors.fill: parent

			onClicked: {
				btn.clicked();
			}
		}
	}

	RowLayout {
		anchors.fill: parent

		CButton {
			id: monthBackButton

			Layout.leftMargin: 4

            rotate: 180

			onClicked: {
				TemporalUnit.onMoveToPreviousMonth()
			}
		}

		Item {
			Layout.fillWidth: true
		}

		RowLayout {
			Layout.alignment: Qt.AlignHCenter || Qt.AlignVCenter

			implicitHeight: parent.implicitHeight

			spacing: 5

			Text {
				id: month

				text: temporalObject.getMonthName(temporalObject.month)

                color: CPalette.layer1

				font.pixelSize: 18

				MouseArea {
					anchors.fill: parent

					onClicked: {
						root.openMonthSelectionPopup();
					}
				}
			}

			Text {
				id: year

				text: temporalObject.year.toString()

                color: CPalette.layer2

				font.pixelSize: 18

				MouseArea {
					anchors.fill: parent

					onClicked: {
						root.openMonthSelectionPopup();
					}
				}
			}
		}

		Item {
			Layout.fillWidth: true
		}

		CButton {
			id: monthForwardButton

			Layout.rightMargin: 4
			onClicked: {
				TemporalUnit.onMoveToNextMonth()
			}
		}
	}
}

