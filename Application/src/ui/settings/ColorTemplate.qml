import QtQuick
import QtQml
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

GridLayout {
	height: internal.templateHeight * 2 + internal.spacing
	flow: GridLayout.LeftToRight
	rows: 2
	columns: 7
	rowSpacing: internal.spacing
	columnSpacing: internal.spacing * 2

	Repeater {
		model: 14
		Rectangle {
			required property int index
			color: internal.colorModel[index]

			Layout.preferredHeight: internal.templateHeight
			Layout.preferredWidth: internal.templateHeight
			radius: width
		}
	}

	QtObject {
		id: internal

		readonly property int templateHeight: 16
		readonly property int spacing: 4

		readonly property color colorModel: [
			"red",
			"blue",
			"green",
			"yellow",
			"purple",
			"violet",
			"red",
			"red",
			"red",
			"red",
			"red",
			"red",
			"red",
			"red",
		]
	}
}
