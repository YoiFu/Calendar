import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import TemporalUnit 1.0
import CPalette 1.0

Popup{
	id: root

	implicitHeight: 156
	implicitWidth: 230

	focus: true

	property QtObject temporalObject: null

	function isChosenMonth(value) {
		return value === temporalObject.month
	}

	component CButton: Image {
		id: btn

		signal clicked();

		height: 15
		width: 15

		fillMode: Image.PreserveAspectFit

        source: "../assets/Arrow.svg"

		MouseArea {
			anchors.fill: parent

			onClicked: {
				btn.clicked();
			}
		}
	}

	RowLayout {
		id: yearModify

		anchors {
			horizontalCenter: parent.horizontalCenter
			topMargin: 8
		}

		spacing: 18

		CButton {
			id: changeYearBackward

			Layout.alignment: Qt.AlignVCenter

            rotation: 180

			onClicked: {
				temporalObject.year = temporalObject.year - 1
			}
		}

		Text {
			id: year

			Layout.alignment: Qt.AlignVCenter

			text: temporalObject.year

            color: CPalette.layer1

			font.pixelSize: 18
		}

		CButton {
			id: changheYearForward

			Layout.alignment: Qt.AlignVCenter

			onClicked: {
				temporalObject.year = temporalObject.year + 1
			}
		}
	}

	GridView {
		id: months

		anchors {
			horizontalCenter: parent.horizontalCenter
			top: yearModify.bottom
			topMargin: 8
		}

		implicitHeight: 102
		implicitWidth: 206

		cellHeight: implicitHeight/4
		cellWidth: implicitWidth/3

		model: 12

		delegate: Rectangle {
			id: chosenMonth

			height: 18
			width: months.implicitWidth/3

			radius: 4

            color: isChosenMonth(model.index + 1) ? CPalette.layer2 : "transparent"
			opacity: 0.5

			Text {
				id: day

				text: temporalObject.getMonthName(model.index + 1)

				anchors.centerIn: parent
				font.pixelSize: 12
				font.bold: true
                color: isChosenMonth(model.index + 1) ? CPalette.layer4 : CPalette.layer1

				MouseArea {
					anchors.fill: parent

					onClicked: {
						temporalObject.month = model.index + 1
					}
				}
			}
		}
	}

	background: Rectangle {
        color: CPalette.layer4

		radius: 4
	}

}
