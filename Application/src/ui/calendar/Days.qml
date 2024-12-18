import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import CPalette 1.0

Rectangle {
	id: root

	property QtObject temporalObject: nullptr

	color : "transparent"

	implicitWidth: 266
	implicitHeight: 198

	ListView {
		id: daysInWeek

		width: root.implicitWidth
		height: 30

        anchors.horizontalCenter: parent.horizontalCenter

		orientation: ListView.Horizontal

		model: internal.dayOfWeek

		delegate: Rectangle {
			id: textWrapper

			height: 30
			width: daysInWeek.width / internal.dayOfWeek

			color: "transparent"

			Text {
				anchors.centerIn: parent

				text: temporalObject.getDayName(model.index)

				font.pixelSize: 14
				font.bold: true
                color: CPalette.layer1
			}
		}
	}

	Rectangle {
		width: root.implicitWidth
		implicitHeight: (daysInWeek.width / internal.numberOfRow) * 4

		anchors {
			horizontalCenter: root.horizontalCenter
			top: daysInWeek.bottom
		}
		color: "transparent"

		GridView {
			id: days

			property bool realMonth: temporalObject.realCurrentMonth

			anchors.fill: parent
			cellWidth: width / internal.numberOfRow
			cellHeight: height / internal.numberOfColumn

			Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
			layoutDirection: GridView.FlowLeftToRight

			model: temporalObject.daysInCalendar
			delegate: Item {
				id: dayModel

				required property QtObject modelData
                property color dayColor: (modelData.day === temporalObject.today && days.realMonth) ? CPalette.layer4 : CPalette.layer2

				function correctColor(dayInCurrentMonth) {
					if (dayInCurrentMonth) {
						return dayModel.dayColor;
					}
                    return CPalette.layer3;
				}

				width: daysInWeek.width / internal.numberOfRow
				height: width

				anchors.leftMargin: (daysInWeek.width - internal.numberOfRow * 34)/ internal.numberOfColumn

				Rectangle {
					id: currentDay

					width: parent.width - 6
					height: width

					radius: width

					anchors.centerIn: parent

                    color: CPalette.layer1

					visible: modelData.day === temporalObject.today && modelData.rightMonth && days.realMonth
				}

				Text {
					id: day

					text: modelData.day

					anchors.centerIn: parent
					font.pixelSize: 14
					color: correctColor(modelData.rightMonth)
				}
			}
		}
	}

	QtObject {
		id: internal

		readonly property int numberOfColumn: 6
		readonly property int numberOfRow: 7
		readonly property int dayOfWeek: 7
	}
}
