import QtQuick
import QtQml
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

import CPalette 1.0

GridLayout {
	id: root

	property QtObject paletteModel: null

	height: internal.templateHeight * 2 + internal.spacing

	flow: GridLayout.LeftToRight

	rows: 2
	columns: 7
	rowSpacing: internal.spacing
	columnSpacing: internal.spacing

	Repeater {
		model: root.paletteModel ? root.paletteModel.rgbColorModel : 14
		Item {
			id: colorCell

			required property string modelData

			Layout.preferredHeight: internal.templateHeight + 4
			Layout.preferredWidth: internal.templateHeight + 4

			Rectangle {
				id: outter

				anchors.fill: parent

				radius: width

				border.width: 1
				border.color: CPalette.layer6

				color: "transparent"

				visible: false
			}

			Rectangle {
				id: inner

				anchors.centerIn: parent

				height: internal.templateHeight
				width: internal.templateHeight

				radius: width

				color: root.paletteModel.rgbColorModel ? modelData : "#FFFFFF"

				MouseArea {
					id: mouse

					anchors.fill: parent
					onClicked: {
						outter.visible = !outter.visible;
					}
				}
			}
		}
	}

	QtObject {
		id: internal

		readonly property int templateHeight: 18
		readonly property int spacing: 4
	}
}
